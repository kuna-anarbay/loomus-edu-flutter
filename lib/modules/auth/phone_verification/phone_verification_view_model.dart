import 'package:loomus_app/base/base_view_model.dart';
import 'package:loomus_app/data/repository/auth_repository.dart';

import '../../../services/local_storage.dart';

class PhoneVerificationViewModel extends BaseViewModel {
  final AuthRepository authRepository;
  final LocalStorage localStorage;
  String phone = "";
  String code = "";
  bool codeSent = false;
  bool isLoading = false;

  PhoneVerificationViewModel(this.authRepository, this.localStorage);

  onClickSubmit() {
    if (isLoading) return;
    if (codeSent) {
      onVerifyPhoneNumber();
    } else {
      onGetVerificationCode();
    }
  }

  onGetVerificationCode() async {
    isLoading = true;
    notifyListeners();
    await authRepository.getSmsVerificationCode(phone);
    isLoading = false;
    codeSent = true;
    notifyListeners();
  }

  onVerifyPhoneNumber() async {
    isLoading = true;
    notifyListeners();
    final tokenData = await authRepository.verifyPhoneNumber(phone, code);
    isLoading = false;
    notifyListeners();

    if (tokenData.phoneVerified) {
      localStorage.setTokenData(tokenData);
    } else {}
  }
}
