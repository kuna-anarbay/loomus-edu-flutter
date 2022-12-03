import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:loomus_app/utilities/ls_color.dart';

class ToastWidget extends StatelessWidget {
  final String title;
  final String? description;

  const ToastWidget(this.title, this.description, {super.key});

  static showToastWidget(String title, BuildContext context,
      [bool isError = false]) {
    Get.snackbar("", "",
        icon: Image.asset(
          isError
              ? "assets/images/xmark.circle.fill.png"
              : "assets/images/checkmark.fill.png",
          color: LsColor.white,
          width: 20,
          height: 20,
        ),
        titleText: Text(title,
            style: const TextStyle(fontSize: 17, color: LsColor.white)),
        messageText: Visibility(visible: false, child: Container()),
        snackPosition: isError ? SnackPosition.BOTTOM : SnackPosition.TOP,
        backgroundColor: isError ? LsColor.errorToast : LsColor.successToast,
        borderRadius: 12,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        duration: const Duration(seconds: 3),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> columns() {
      List<Widget> result = [
        Text(title,
            style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: LsColor.white)),
      ];
      if (description != null) {
        result.add(Text(description ?? "",
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: LsColor.white)));
      }

      return result;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: LsColor.successToast,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("assets/images/checkmark.fill.png",
              height: 22, width: 22, color: LsColor.white),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: columns(),
              ))
        ],
      ),
    );
  }
}
