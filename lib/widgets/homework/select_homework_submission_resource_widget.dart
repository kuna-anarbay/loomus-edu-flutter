import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utilities/ls_color.dart';
import '../../utilities/utils.dart';

mixin SelectHomeworkSubmissionResourceWidgetDelegate {
  void removeFile();
}

class SelectHomeworkSubmissionResourceWidget extends StatelessWidget {
  final String? name;
  final String? size;
  final SelectHomeworkSubmissionResourceWidgetDelegate delegate;

  const SelectHomeworkSubmissionResourceWidget(this.name, this.size, this.delegate,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Utils.getFilePath(name ?? "unknown.dart"),
              fit: BoxFit.cover, height: 32, width: 24),
          const SizedBox(width: 8),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(name ?? "Гайд по настройке таргета.pdf",
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                      color: LsColor.label)),
              const SizedBox(height: 2),
              Text(size ?? "1 mb",
                  style: const TextStyle(
                      fontSize: 12, color: LsColor.secondaryLabel))
            ],
          )),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => delegate.removeFile(),
            child: Image.asset("assets/images/xmark.circle.fill.png",
                height: 18, width: 18, color: LsColor.red),
          )
        ],
      ),
    );
  }
}
