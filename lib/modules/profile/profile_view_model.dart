import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loomus_app/base/base_view_model.dart';
import 'package:loomus_app/data/repository/user_repository.dart';
import 'package:loomus_app/models/common/language.dart';
import 'package:loomus_app/modules/edit_profile/edit_profile_view_model.dart';
import 'package:loomus_app/services/analytics_service.dart';
import 'package:loomus_app/utilities/constants.dart';
import 'package:loomus_app/utilities/utils.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../components/alert/bottom_sheet_action.dart';
import '../../components/alert/bottom_sheet_alert.dart';
import '../../components/alert/cancel_action.dart';
import '../../models/user/user.dart';
import '../../provider/app_provider.dart';
import '../../services/local_storage.dart';
import '../../utilities/ls_color.dart';
import '../../utilities/ls_router.dart';

class ProfileItem {
  int index;
  String image;
  String title;
  String? details;

  ProfileItem(this.index, this.image, this.title, this.details);
}

class ProfileSection {
  int index;
  String? title;
  List<ProfileItem> items;

  ProfileSection(this.index, this.title, this.items);
}

class ProfileDataSource {
  final User user;

  ProfileDataSource(this.user);
}

class ProfileViewModel extends BaseViewModel with EditProfileDelegate {
  final UserRepository userRepository;
  final LocalStorage localStorage;
  User user;

  ProfileViewModel(
      ProfileDataSource dataSource, this.userRepository, this.localStorage)
      : user = dataSource.user {
    AnalyticsService.openedPageProfile(user.id);
  }

  List<ProfileSection> sections(AppLocalizations? local) {
    return [
      ProfileSection(0, null, [
        ProfileItem(
            0,
            "assets/images/translate.png",
            local?.profilePageLanguage ?? "",
            Language.languageName(user.language)),
        ProfileItem(1, "assets/images/hand.wave.png",
            local?.profilePageSupport ?? "", null)
      ]),
      ProfileSection(2, Utils.replace(local?.profilePageVersion, ["1.0.0"]), [])
    ];
  }

  @override
  editUser(User user) {
    this.user = user;
    notifyListeners();
  }

  onClickOnCell(
      BuildContext context, AppLocalizations? local, int section, int index) {
    if (section == 0) {
      if (index == 0) {
        onEditLanguage(context, local);
      } else if (index == 1) {
        onOpenSupport(context, local);
      }
    }
  }

  onEditLanguage(BuildContext context, AppLocalizations? local) {
    AnalyticsService.pressOpenActionSheetChangeLanguage(user.id);
    setLanguage(Language language, BuildContext context) async {
      LsRouter(context).pop();
      AnalyticsService.pressChangeLanguage(user.id, language.name);
      context.read<AppProvider>().setLocale(language.locale);
      user.language = language.name.toUpperCase();
      await localStorage.setCurrentUser(user);
      onEditProfile();
      notifyListeners();
    }

    showAdaptiveActionSheet(
        context: context,
        actions: Language.values
            .map((language) => BottomSheetAction(
                title: Text(language.localedName(),
                    style: const TextStyle(
                        color: LsColor.brand, fontWeight: FontWeight.normal)),
                onPressed: (context) => setLanguage(language, context)))
            .toList(),
        cancelAction: CancelAction(
            title: Text(local?.profilePageCancel ?? "",
                style: const TextStyle(
                    color: LsColor.brand, fontWeight: FontWeight.w600))));
  }

  onOpenSupport(BuildContext context, AppLocalizations? local) {
    AnalyticsService.pressOpenActionSheetSupport(user.id);
    String url = "https://t.me/loomus";
    launchUrlString(url, mode: LaunchMode.externalApplication);
  }

  onShareApp(AppLocalizations? local) {
    AnalyticsService.pressShareApp(user.id);
    Share.share("Loomus Academy. iOS: ${Constants.appleIdUrl}");
  }

  onRateApp() {
    AnalyticsService.pressRateApp(user.id);
    RateMyApp(appStoreIdentifier: Constants.appleAppId).init();
  }

  onEditProfile() async {
    await userRepository.editProfile(user.firstName, user.lastName,
        user.birthday, user.gender, user.color, user.theme, user.language);
    await localStorage.setCurrentUser(user);
  }
}
