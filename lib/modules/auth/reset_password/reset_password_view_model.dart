import 'package:loomus_app/base/base_view_model.dart';
import 'package:loomus_app/data/repository/auth_repository.dart';
import 'package:loomus_app/data/repository/user_repository.dart';
import 'package:loomus_app/services/analytics_service.dart';

import '../../../models/user/user.dart';
import '../../../services/local_storage.dart';
import '../../../utilities/utils.dart';

class ResetPasswordDataSource {
  String? email;

  ResetPasswordDataSource(this.email);
}

class ResetPasswordViewModel extends BaseViewModel {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final LocalStorage localStorage;
  String email = "";
  String password = "";
  String code = "";
  bool codeSent = false;
  bool isLoading = false;

  ResetPasswordViewModel(ResetPasswordDataSource dataSource,
      this.authRepository, this.userRepository, this.localStorage)
      : email = dataSource.email ?? "" {
    AnalyticsService.openedPageResetPassword();
  }

  onGetVerificationCode() async {
    if (isLoading) return;
    AnalyticsService.pressRequestEmailCode("reset_password");
    isLoading = true;
    notifyListeners();

    try {
      await authRepository.getEmailVerificationCode(email, "RESET_PASSWORD");
      isLoading = false;
      codeSent = true;
      notifyListeners();
    } catch (e) {
      toastDioError(e);
      isLoading = false;
      notifyListeners();
    }
  }

  Future<User?> onResetPassword() async {
    if (isLoading) return null;
    AnalyticsService.pressResetPassword();
    isLoading = true;
    notifyListeners();

    try {
      final tokenData =
          await authRepository.resetPassword(email, password, code);

      await localStorage.setTokenData(tokenData);
      await localStorage.setTokenRefreshedAt(Utils.seconds(DateTime.now()));

      final user = await userRepository.getMyProfile();
      await localStorage.setCurrentUser(user);

      isLoading = false;
      notifyListeners();

      return user;
    } catch (e) {
      toastDioError(e);
      isLoading = false;
      notifyListeners();

      return null;
    }
  }
}
