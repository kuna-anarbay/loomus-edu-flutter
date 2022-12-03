import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loomus_app/data/repository/auth_repository.dart';
import 'package:loomus_app/data/repository/user_repository.dart';
import 'package:loomus_app/services/analytics_service.dart';
import 'package:loomus_app/utilities/ls_color.dart';
import 'package:loomus_app/utilities/ls_router.dart';

import '../../base/base_view_model.dart';
import '../../components/alert/bottom_sheet_action.dart';
import '../../components/alert/bottom_sheet_alert.dart';
import '../../components/alert/cancel_action.dart';
import '../../models/user/user.dart';
import '../../services/local_storage.dart';

class EditProfileDataSource {
  final User user;

  EditProfileDataSource(this.user);
}

mixin EditProfileDelegate {
  void editUser(User user);
}

class EditProfileViewModel extends BaseViewModel {
  final UserRepository userRepository;
  final AuthRepository authRepository;
  final LocalStorage localStorage;
  final TextEditingController firstNameEditingController =
      TextEditingController();
  final TextEditingController lastNameEditingController =
      TextEditingController();
  final EditProfileDelegate delegate;
  bool isEditingAccount = false;
  bool isLoadingAvatar = false;
  bool isLoggingOut = false;
  bool isDeletingAccount = false;
  User user;

  EditProfileViewModel(EditProfileDataSource dataSource, this.delegate,
      this.userRepository, this.authRepository, this.localStorage)
      : user = dataSource.user {
    AnalyticsService.openedPageEditProfile(user.id);
    firstNameEditingController.text = user.firstName;
    lastNameEditingController.text = user.lastName ?? "";
  }

  onEditAvatar(BuildContext context, AppLocalizations? local) {
    AnalyticsService.pressEditAvatar(user.id);
    List<BottomSheetAction> actions = [
      BottomSheetAction(
          title: Text(local?.editProfilePageGallery ?? "",
              style: const TextStyle(
                  color: LsColor.brand, fontWeight: FontWeight.normal)),
          onPressed: (context) {
            AnalyticsService.pressSelectAvatar(user.id, "gallery");
            pickImage(ImageSource.gallery);
            LsRouter(context).pop();
          }),
      BottomSheetAction(
          title: Text(local?.editProfilePageCamera ?? "",
              style: const TextStyle(
                  color: LsColor.brand, fontWeight: FontWeight.normal)),
          onPressed: (context) {
            AnalyticsService.pressSelectAvatar(user.id, "camera");
            pickImage(ImageSource.camera);
            LsRouter(context).pop();
          })
    ];
    if (user.avatarUrl != null) {
      actions.add(BottomSheetAction(
          title: Text(local?.editProfilePageDeleteAvatar ?? "",
              style: const TextStyle(
                  color: LsColor.red, fontWeight: FontWeight.normal)),
          onPressed: (context) {
            AnalyticsService.pressDeleteAvatar(user.id);
            onDeleteAvatar();
            LsRouter(context).pop();
          }));
    }
    showAdaptiveActionSheet(
        context: context,
        actions: actions,
        cancelAction: CancelAction(
            title: Text(local?.editProfilePageCancel ?? "",
                style: const TextStyle(
                    color: LsColor.brand, fontWeight: FontWeight.w600))));
  }

  pickImage(ImageSource source) async {
    if (isLoadingAvatar) return;
    isLoadingAvatar = true;
    notifyListeners();

    final ImagePicker imagePicker = ImagePicker();
    final xFile = await imagePicker.pickImage(
        source: source, maxHeight: 1280, maxWidth: 1280);
    if (xFile != null) {
      try {
        user.avatarUrl = await userRepository.editAvatar(File(xFile.path));
        delegate.editUser(user);
        await localStorage.setCurrentUser(user);

        isLoadingAvatar = false;
        notifyListeners();
      } catch (e) {
        toastDioError(e);
        isLoadingAvatar = false;
        notifyListeners();
      }
    } else {
      isLoadingAvatar = false;
      notifyListeners();
    }
  }

  Future<bool> onEditProfile() async {
    if (isEditingAccount) return false;
    AnalyticsService.pressEditProfile(user.id);
    isEditingAccount = true;
    notifyListeners();

    try {
      await userRepository.editProfile(user.firstName, user.lastName,
          user.birthday, user.gender, user.color, user.theme, user.language);
      delegate.editUser(user);
      await localStorage.setCurrentUser(user);
      isEditingAccount = false;
      notifyListeners();

      return true;
    } catch (e) {
      toastDioError(e);
      isEditingAccount = false;
      notifyListeners();

      return false;
    }
  }

  Future<void> onLogOut() async {
    if (isLoggingOut) return;
    AnalyticsService.pressLogout(user.id);
    isLoggingOut = true;
    notifyListeners();

    try {
      final refreshToken = (await localStorage.getTokenData())?.refreshToken;
      if (refreshToken == null) return;
      await authRepository.signOut(refreshToken);
      await localStorage.setTokenRefreshedAt(null);
      await localStorage.setTokenData(null);
      await localStorage.setCurrentUser(null);
      isLoggingOut = false;
      notifyListeners();
    } catch (e) {
      toastDioError(e);
      await localStorage.setTokenRefreshedAt(null);
      await localStorage.setTokenData(null);
      await localStorage.setCurrentUser(null);
      isLoggingOut = false;
      notifyListeners();
    }
  }

  Future<void> onDeleteAccount() async {
    if (isDeletingAccount) return;
    AnalyticsService.pressDeleteAccount(user.id);
    isDeletingAccount = true;
    notifyListeners();

    try {
      await userRepository.deleteProfile();
      await localStorage.setTokenRefreshedAt(null);
      await localStorage.setTokenData(null);
      await localStorage.setCurrentUser(null);
      isDeletingAccount = false;
      notifyListeners();
    } catch (e) {
      toastDioError(e);
      isDeletingAccount = false;
      notifyListeners();
    }
  }

  onDeleteAvatar() async {
    if (isLoadingAvatar) return;
    isLoadingAvatar = true;
    notifyListeners();

    try {
      await userRepository.deleteAvatar();
      user.avatarUrl = null;
      delegate.editUser(user);
      await localStorage.setCurrentUser(user);
      isLoadingAvatar = false;
      notifyListeners();
    } catch (e) {
      toastDioError(e);
      isLoadingAvatar = false;
      notifyListeners();
    }
  }
}
