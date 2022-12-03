import 'package:google_sign_in/google_sign_in.dart';
import 'package:loomus_app/base/base_view_model.dart';
import 'package:loomus_app/data/repository/auth_repository.dart';
import 'package:loomus_app/services/analytics_service.dart';
import 'package:loomus_app/utilities/utils.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../data/repository/user_repository.dart';
import '../../../models/user/user.dart';
import '../../../services/local_storage.dart';

class LoginDataSource {}

mixin LoginDelegate {}

class LoginViewModel extends BaseViewModel {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final LocalStorage localStorage;
  String email = "";
  String password = "";
  bool isLoadingEmail = false;
  bool isLoadingGoogle = false;
  bool isLoadingApple = false;

  bool get isLoading => isLoadingEmail || isLoadingApple || isLoadingGoogle;

  LoginViewModel(this.authRepository, this.userRepository, this.localStorage) {
    AnalyticsService.openedPageSignIn();
  }

  Future<User?> onSignIn() async {
    if (isLoading) return null;
    AnalyticsService.pressSignIn();
    isLoadingEmail = true;
    notifyListeners();
    try {
      final tokenData = await authRepository.signIn(email, password);

      await localStorage.setTokenData(tokenData);
      await localStorage.setTokenRefreshedAt(Utils.seconds(DateTime.now()));

      final user = await userRepository.getMyProfile();
      await localStorage.setCurrentUser(user);

      isLoadingEmail = false;
      notifyListeners();

      return user;
    } catch (e) {
      toastDioError(e);
      isLoadingEmail = false;
      notifyListeners();
      return null;
    }
  }

  Future<User?> onSignInWithApple() async {
    if (isLoading) return null;
    AnalyticsService.pressSignInWithApple();
    isLoadingApple = true;
    notifyListeners();

    try {
      final credentials = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName
      ]);

      print(credentials.identityToken);
      print(credentials.userIdentifier);
      print(credentials.authorizationCode);
      final identityToken = credentials.identityToken;
      if (identityToken == null) {
        toastError("Cannot Sign in with Apple");
        return null;
      }

      final tokenData = await authRepository.signInWithApple(identityToken);

      await localStorage.setTokenData(tokenData);
      await localStorage.setTokenRefreshedAt(Utils.seconds(DateTime.now()));

      final user = await userRepository.getMyProfile();
      await localStorage.setCurrentUser(user);

      isLoadingApple = false;
      notifyListeners();

      return user;
    } catch (e) {
      toastDioError(e);
      isLoadingApple = false;
      notifyListeners();
      return null;
    }
  }

  Future<User?> onSignInWithGoogle() async {
    if (isLoading) return null;
    AnalyticsService.pressSignInWithGoogle();
    isLoadingGoogle = true;
    notifyListeners();

    try {
      final googleSignIn = GoogleSignIn();
      final googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount == null) {
        isLoadingGoogle = false;
        notifyListeners();
        return null;
      }
      final googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final idToken = googleSignInAuthentication.idToken;
      if (idToken == null) {
        isLoadingGoogle = false;
        notifyListeners();
        return null;
      }
      final tokenData = await authRepository.signInWithGoogle(idToken);

      await localStorage.setTokenData(tokenData);
      await localStorage.setTokenRefreshedAt(Utils.seconds(DateTime.now()));

      final user = await userRepository.getMyProfile();
      await localStorage.setCurrentUser(user);

      isLoadingGoogle = false;
      notifyListeners();

      return user;
    } catch (e) {
      toastDioError(e);

      isLoadingGoogle = false;
      notifyListeners();

      return null;
    }
  }
}
