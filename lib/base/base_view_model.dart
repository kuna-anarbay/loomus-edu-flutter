import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loomus_app/utilities/ls_color.dart';

class BaseViewModel extends ChangeNotifier {
  void toastDioError(Object e) {
    if (e.runtimeType == String) {
      showToast(e.toString(), true);
    }
  }

  void toastError(String message) {
    showToast(message, true);
  }

  void showToast(String message, [bool isError = false]) {
    if (message.trim().isEmpty) return;
    Get.snackbar("", "",
        icon: Image.asset(
          isError
              ? "assets/images/xmark.circle.fill.png"
              : "assets/images/checkmark.fill.png",
          color: LsColor.white,
          width: 20,
          height: 20,
        ),
        titleText: Text(message,
            style: const TextStyle(fontSize: 17, color: LsColor.white)),
        messageText: Visibility(visible: false, child: Container()),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: isError ? LsColor.errorToast : LsColor.successToast,
        borderRadius: 12,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        duration: const Duration(seconds: 3),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal);
  }
}
