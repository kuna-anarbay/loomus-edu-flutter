import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loomus_app/models/test/question.dart';
import 'package:loomus_app/utilities/utils.dart';
import 'package:loomus_app/widgets/test/test_question_option_widget.dart';

import '../../models/test/answer.dart';
import '../../utilities/ls_color.dart';

class TestQuestionWidget extends StatelessWidget {
  final Question question;
  final int index;
  final List<int> selectedOptionIds;
  final Answer? answer;
  final bool isReviewable;
  final TestQuestionOptionWidgetDelegate delegate;

  const TestQuestionWidget(this.index, this.question, this.selectedOptionIds,
      this.answer, this.isReviewable, this.delegate,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? local = AppLocalizations.of(context);

    List<Widget> columns() {
      List<Widget> result = [
        Text(
            Utils.replace(local?.testPageQuestionIndex, ["$index"])
                .toLowerCase(),
            style: const TextStyle(
                fontFeatures: [FontFeature.enable("smcp")],
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: LsColor.brand)),
        const SizedBox(height: 2),
        Text(question.value,
            style: const TextStyle(fontSize: 17, color: LsColor.label))
      ];
      if (question.solution != null) {
        result.addAll([
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: LsColor.secondaryBackground,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: LsColor.secondaryDivider)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(local?.testPageSolution ?? "",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: LsColor.label)),
                  const SizedBox(height: 4),
                  Text(question.solution ?? "",
                      style:
                          const TextStyle(fontSize: 15, color: LsColor.label)),
                ]),
          )
        ]);
      }

      return result;
    }

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
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
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: columns(),
                  )),
              const SizedBox(height: 12),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: question.options
                      .map((option) => TestQuestionOptionWidget(
                          option,
                          selectedOptionIds.contains(option.id),
                          answer,
                          isReviewable,
                          delegate))
                      .toList())
            ],
          ),
        ));
  }
}
