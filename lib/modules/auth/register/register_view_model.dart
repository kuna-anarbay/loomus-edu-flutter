import 'package:loomus_app/base/base_view_model.dart';
import 'package:loomus_app/data/repository/auth_repository.dart';
import 'package:loomus_app/data/repository/user_repository.dart';
import 'package:loomus_app/models/user/user.dart';
import 'package:loomus_app/services/analytics_service.dart';

import '../../../services/local_storage.dart';
import '../../../utilities/utils.dart';

class RegisterDataSource {
  String? email;

  RegisterDataSource(this.email);
}

mixin RegisterDelegate {}

class RegisterViewModel extends BaseViewModel {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final LocalStorage localStorage;
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String code = "";
  bool codeSent = false;
  bool isLoading = false;

  RegisterViewModel(RegisterDataSource dataSource, this.authRepository,
      this.userRepository, this.localStorage)
      : email = dataSource.email ?? "" {
    AnalyticsService.openedPageSignUp();
  }

  onGetVerificationCode() async {
    if (isLoading) return;
    AnalyticsService.pressRequestEmailCode("sign_up");
    isLoading = true;
    notifyListeners();

    try {
      await authRepository.getEmailVerificationCode(email, "SIGN_UP");
      isLoading = false;
      codeSent = true;
      notifyListeners();
    } catch (e) {
      toastDioError(e);
      isLoading = false;
      notifyListeners();
    }
  }

  Future<User?> onSignUp() async {
    if (isLoading) return null;
    AnalyticsService.pressSignUp();
    isLoading = true;
    notifyListeners();

    try {
      final tokenData = await authRepository.signUp(
          firstName, lastName, email, password, code);

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
