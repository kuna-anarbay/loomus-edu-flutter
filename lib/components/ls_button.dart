import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loomus_app/utilities/ls_color.dart';

typedef VoidCallback = void Function();

enum LsButtonType { filled, outline, gray }

class LsButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double height;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final bool isLoading;
  final LsButtonType type;
  final Color titleColor;
  final Color backgroundColor;
  final Color? borderColor;
  final Widget? icon;

  const LsButton(
      {super.key,
      required this.title,
      this.isLoading = false,
      this.height = 48,
      this.borderRadius = 8,
      this.fontSize = 17,
      this.fontWeight = FontWeight.w600,
      this.borderColor,
      this.type = LsButtonType.filled,
      this.titleColor = LsColor.white,
      this.backgroundColor = LsColor.brand,
      this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return Container(
          height: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border:
                  borderColor != null ? Border.all(color: borderColor!) : null),
          child: CupertinoButton(
              onPressed: onPressed,
              color: backgroundColor,
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.circular(borderRadius),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                      visible: isLoading || icon != null,
                      child: isLoading
                          ? CupertinoActivityIndicator(color: titleColor)
                          : (icon ?? Container())),
                  Visibility(
                      visible: isLoading || icon != null,
                      child: const SizedBox(width: 10)),
                  Text(title,
                      style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: fontWeight,
                          color: titleColor))
                ],
              )));
    } else {
      return Container(
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border:
                borderColor != null ? Border.all(color: borderColor!) : null),
        child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius))),
                backgroundColor: MaterialStateProperty.all(backgroundColor),
                shadowColor: MaterialStateProperty.all(Colors.transparent)),
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                    visible: isLoading || icon != null,
                    child: isLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                color: titleColor, strokeWidth: 3),
                          )
                        : (icon ?? Container())),
                Visibility(
                    visible: isLoading || icon != null,
                    child: const SizedBox(width: 10)),
                Text(title,
                    style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        color: titleColor))
              ],
            )),
      );
    }
  }
}
