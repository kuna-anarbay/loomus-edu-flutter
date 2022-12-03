import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loomus_app/models/test/question_option.dart';

import '../../models/test/answer.dart';
import '../../utilities/ls_color.dart';

mixin TestQuestionOptionWidgetDelegate {
  void selectOption(int questionId, int optionId);
}

class TestQuestionOptionWidget extends StatelessWidget {
  final QuestionOption option;
  final bool isSelected;
  final Answer? answer;
  final bool isReviewable;
  final TestQuestionOptionWidgetDelegate delegate;

  const TestQuestionOptionWidget(
      this.option, this.isSelected, this.answer, this.isReviewable, this.delegate,
      {super.key});

  @override
  Widget build(BuildContext context) {
    Color textColor() {
      final answerOption = answer?.options
          .firstWhereOrNull((element) => element.id == option.id);
      if (answerOption == null) return LsColor.label;

      return answerOption.isCorrect ? LsColor.green : LsColor.red;
    }

    Widget iconWidget() {
      final answerOption = answer?.options
          .firstWhereOrNull((element) => element.id == option.id);

      if (answerOption == null) {
        return Image.asset(
          isSelected
              ? "assets/images/radio.selected.png"
              : "assets/images/circle.png",
          height: 18,
          width: 18,
          color: isSelected ? LsColor.brand : LsColor.gray,
        );
      }
      if (!isReviewable && option.isCorrect) {
        return Image.asset("assets/images/circle.png",
            height: 18, width: 18, color: LsColor.green);
      }

      return Image.asset(
        answerOption.isCorrect
            ? "assets/images/checkmark.fill.png"
            : "assets/images/xmark.circle.fill.png",
        height: 18,
        width: 18,
        color: answerOption.isCorrect ? LsColor.green : LsColor.red,
      );
    }

    return GestureDetector(
      onTap: () => delegate.selectOption(option.questionId, option.id),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.5, horizontal: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: option.isCorrect
                ? LsColor.green.withOpacity(0.12)
                : LsColor.background,
            border: Border.all(
                color: isSelected ? LsColor.lightDivider : Colors.transparent),
            boxShadow: isSelected
                ? const [
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
                  ]
                : []),
        child: Row(
          children: [
            iconWidget(),
            const SizedBox(width: 8),
            Expanded(
                child: Text(option.value,
                    style: TextStyle(fontSize: 16, color: textColor())))
          ],
        ),
      ),
    );
  }
}
