import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:loomus_app/components/ls_button.dart';
import 'package:loomus_app/modules/test/test/test_view_model.dart';
import 'package:loomus_app/widgets/common/loading_page_widget.dart';
import 'package:loomus_app/widgets/test/test_result_widget.dart';
import 'package:provider/provider.dart';

import '../../../utilities/ls_color.dart';
import '../../../widgets/test/test_question_widget.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TestViewModel viewModel = context.watch<TestViewModel>();
    final AppLocalizations? local = AppLocalizations.of(context);

    List<Widget> questions() {
      final submission = viewModel.submission;
      List<Widget> result = [];
      if (viewModel.isLoading) {
        result.add(const LoadingPageWidget());
      }
      if (submission != null && !viewModel.isLoading) {
        result.add(
            TestResultWidget(submission, viewModel.test.isPassed, viewModel));
      }
      for (var index = 0; index < viewModel.questions.length; index++) {
        final question = viewModel.questions[index];
        result.add(TestQuestionWidget(
            index + 1,
            question,
            viewModel.selectedAnswers[question.id] ?? [],
            viewModel.answers.firstWhereOrNull(
                (element) => element.questionId == question.id),
            viewModel.submission?.isReviewable ?? false,
            viewModel));
      }

      return result;
    }

    return PlatformScaffold(
        appBar: PlatformAppBar(
            title: Text(local?.testPageTitle ?? "",
                style: const TextStyle(color: LsColor.label)),
          material: (_, __) => MaterialAppBarData(
              shadowColor: const Color.fromRGBO(37, 37, 37, 0.1)),),
        backgroundColor: LsColor.highlightBackground,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 10, bottom: 56),
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: questions()),
            )),
            Visibility(
                visible: viewModel.submission == null && viewModel.isDataLoaded,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
                  decoration: const BoxDecoration(
                      color: LsColor.background,
                      border: Border(top: BorderSide(color: LsColor.divider))),
                  child: LsButton(
                    isLoading: viewModel.isSubmitting,
                    title: local?.testPageSubmit ?? "",
                    onPressed: () {
                      viewModel.submitTest();
                    },
                  ),
                )),
          ],
        ));
  }
}
