import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:loomus_app/components/ls_button.dart';
import 'package:path/path.dart';

import '../../utilities/ls_color.dart';
import '../../utilities/utils.dart';
import 'select_homework_submission_resource_widget.dart';

mixin StudentWorkWidgetDelegate {
  void pickFile(BuildContext context, AppLocalizations? local);

  void onChanged(String value);

  void removeFile();

  void textManager();
}

class StudentWorkWidget extends StatelessWidget
    with SelectHomeworkSubmissionResourceWidgetDelegate {
  final bool isAvailable;
  final String value;
  final File? file;
  final StudentWorkWidgetDelegate delegate;

  const StudentWorkWidget(
      this.value, this.file, this.isAvailable, this.delegate,
      {super.key});

  @override
  void removeFile() {
    delegate.removeFile();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? local = AppLocalizations.of(context);

    Widget filePicker() {
      final file = this.file;
      if (file == null) {
        return GestureDetector(
            onTap: () {
              delegate.pickFile(context, local);
            },
            child: Row(
              children: [
                Image.asset("assets/images/attach.fill.png",
                    height: 18, width: 18, color: LsColor.brand),
                const SizedBox(width: 8),
                Text(local?.homeworkPageAttach ?? "",
                    style: const TextStyle(
                        color: LsColor.brand,
                        fontSize: 16,
                        fontWeight: FontWeight.w500))
              ],
            ));
      }
      return SelectHomeworkSubmissionResourceWidget(
          basename(file.path), Utils.fileSize(file.lengthSync()), this);
    }

    final mainBody = Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: LsColor.background,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(37, 37, 37, 0.02),
                spreadRadius: 0,
                blurRadius: 4,
                offset: Offset(0, 2)),
            BoxShadow(
                color: Color.fromRGBO(37, 37, 37, 0.02),
                spreadRadius: 0,
                blurRadius: 4,
                offset: Offset(0, -2))
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(local?.homeworkPageAnswer ?? "",
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        PlatformTextField(
            hintText: local?.homeworkPageComments ?? "",
            maxLines: 10,
            minLines: 4,
            onChanged: (value) {
              delegate.onChanged(value);
            },
            cupertino: (_, __) => CupertinoTextFieldData(
                placeholderStyle:
                    const TextStyle(color: LsColor.secondaryLabel),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    border: Border.all(color: LsColor.divider, width: 1),
                    borderRadius: BorderRadius.circular(8))),
            material: (_, __) => MaterialTextFieldData(
                decoration: InputDecoration(
                    hintStyle: const TextStyle(color: LsColor.secondaryLabel),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))))),
        const SizedBox(height: 16),
        filePicker()
      ]),
    );

    if (isAvailable) {
      return mainBody;
    } else {
      return Stack(
        children: [
          mainBody,
          Container(
            color: LsColor.white.withOpacity(0.5),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: Column(
                      children: [
                        Text("Тариф PRO"),
                        const SizedBox(height: 8),
                        Text(local?.homeworkPageProTitle ?? "",
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: LsColor.label)),
                        const SizedBox(height: 4),
                        Text(local?.homeworkPageProDescription ?? "",
                            style: const TextStyle(
                                fontSize: 15, color: LsColor.label)),
                        const SizedBox(height: 24),
                        LsButton(
                            title: local?.homeworkPageProUnlock ?? "",
                            onPressed: () => delegate.textManager())
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      );
    }
  }
}
