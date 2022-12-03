import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:loomus_app/components/ls_button.dart';

import '../../utilities/ls_color.dart';

mixin LessonQuestionWidgetDelegate {
  void askQuestion();

  void editQuestion(String value);
}

class LessonQuestionWidget extends StatelessWidget {
  final TextEditingController controller;
  final String value;
  final bool canAskQuestion;
  final LessonQuestionWidgetDelegate delegate;

  LessonQuestionWidget(this.value, this.canAskQuestion, this.delegate,
      {super.key})
      : controller = TextEditingController(text: value);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? local = AppLocalizations.of(context);

    return Container(
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset("assets/images/student-question.png",
                    fit: BoxFit.cover, height: 42, width: 42),
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(local?.lessonPageQuestionTitle ?? "",
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 2),
                  Text(local?.lessonPageQuestionSubtitle ?? "",
                      style: const TextStyle(
                          fontSize: 13, color: LsColor.secondaryLabel)),
                ],
              ))
            ],
          ),
          const SizedBox(height: 10),
          PlatformTextField(
              enabled: canAskQuestion,
              hintText: local?.lessonPageQuestionField ?? "",
              maxLines: 10,
              minLines: 4,
              controller: controller,
              onChanged: (value) {
                delegate.editQuestion(value);
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
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 12),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))))),
          const SizedBox(height: 16),
          Visibility(
              visible: canAskQuestion,
              child: LsButton(
                  isLoading: false,
                  onPressed: () => delegate.askQuestion(),
                  title: local?.lessonPageQuestionAsk ?? "",
                  height: 42,
                  fontSize: 15,
                  fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}
