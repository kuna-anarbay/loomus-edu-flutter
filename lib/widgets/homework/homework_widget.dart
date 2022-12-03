import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loomus_app/components/ls_button.dart';
import 'package:loomus_app/models/homework/homework.dart';
import 'package:loomus_app/modules/homework/homework/homework_view_model.dart';
import 'package:loomus_app/modules/homework/homework_terms/homework_terms_view_model.dart';
import 'package:loomus_app/modules/lesson/lesson_view_model.dart';
import 'package:loomus_app/services/analytics_service.dart';
import 'package:loomus_app/utilities/ls_router.dart';
import 'package:loomus_app/utilities/utils.dart';
import 'package:loomus_app/widgets/common/avatar_widget.dart';
import 'package:loomus_app/widgets/homework/homework_resource_widget.dart';
import 'package:loomus_app/widgets/homework/homework_submission_resource_widget.dart';

import '../../models/homework/homework_submission.dart';
import '../../utilities/ls_color.dart';

mixin HomeworkWidgetDelegate {
  bool isTestPassed();

  void editHomeworkSubmission(HomeworkSubmission submission);
}

class HomeworkWidget extends StatelessWidget with HomeworkDelegate {
  final Homework homework;
  final bool isResourceLoading;
  final bool isHomeworkAgreementHidden;
  final bool isHomeworkAvailable;
  final LessonVideoDelegate videoDelegate;
  final HomeworkWidgetDelegate delegate;
  final HomeworkResourceWidgetDelegate resourceDelegate;

  const HomeworkWidget(
      this.homework,
      this.isResourceLoading,
      this.isHomeworkAgreementHidden,
      this.isHomeworkAvailable,
      this.videoDelegate,
      this.delegate,
      this.resourceDelegate,
      {super.key});

  @override
  void editHomeworkSubmission(HomeworkSubmission submission) {
    delegate.editHomeworkSubmission(submission);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? local = AppLocalizations.of(context);

    List<Widget> columns() {
      final resource = homework.resource;
      final submission = homework.submission;

      List<Widget> result = [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset("assets/images/homework.png",
                  fit: BoxFit.cover, height: 42, width: 42),
            ),
            const SizedBox(width: 10),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(local?.lessonPageHomeworkTitle ?? "",
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(
                    homework.submission == null
                        ? local?.lessonPageHomeworkSubtitle ?? ""
                        : local?.lessonPageHomeworkPassed ?? "",
                    style: const TextStyle(
                        fontSize: 13, color: LsColor.secondaryLabel)),
              ],
            ))
          ],
        ),
        const SizedBox(height: 10),
        Text(homework.value,
            style: const TextStyle(fontSize: 17, color: LsColor.label))
      ];
      if (submission == null) {
        result.addAll([
          const SizedBox(height: 16),
          LsButton(
              isLoading: false,
              onPressed: () {
                if (!delegate.isTestPassed()) return;
                videoDelegate.pauseVideo();
                if (isHomeworkAgreementHidden) {
                  AnalyticsService.pressOpenPageHomework(
                      homework.courseId, homework.id, "lesson");
                  LsRouter(context).openHomework(
                      HomeworkDataSource(homework, isHomeworkAvailable), this);
                } else {
                  AnalyticsService.pressOpenPageHomeworkInstructions(
                      homework.courseId, homework.id);
                  LsRouter(context).openHomeworkTerms(
                      HomeworkTermsDataSource(homework, isHomeworkAvailable),
                      this);
                }
              },
              title: local?.lessonPageHomeworkPass ?? "",
              height: 42,
              fontSize: 16,
              fontWeight: FontWeight.w500)
        ]);
      }
      if (resource != null) {
        result.addAll([
          const SizedBox(height: 10),
          HomeworkResourceWidget(resource, isResourceLoading, resourceDelegate)
        ]);
      }
      if (submission != null) {
        final value = submission.value;
        final resource = submission.resource;
        final staff = submission.staff;
        final comment = submission.notes;
        List<Widget> submissionColumns = [
          Text(submission.statusMessage(local),
              style:
                  const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Text(
              Utils.replace(local?.lessonPageHomeworkSubmittedAt,
                  [Utils.date(submission.submittedAt)]),
              style:
                  const TextStyle(fontSize: 13, color: LsColor.secondaryLabel)),
        ];
        if (value != null) {
          submissionColumns.addAll([
            const SizedBox(height: 10),
            Text(submission.value ?? "",
                style: const TextStyle(fontSize: 17, color: LsColor.label)),
          ]);
        }
        if (resource != null) {
          submissionColumns.addAll([
            const SizedBox(height: 10),
            HomeworkSubmissionResourceWidget(resource)
          ]);
        }
        if (comment != null && staff != null) {
          submissionColumns.addAll([
            const SizedBox(height: 10),
            Container(color: LsColor.secondaryDivider, height: 1),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: LsColor.secondaryBackground,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                    children: [
                      AvatarWidget(staff.avatarUrl, 26),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Column(
                        children: [
                          Text(staff.fullName,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 2),
                          Text(staff.fullName,
                              style: const TextStyle(
                                  fontSize: 12, color: LsColor.secondaryLabel))
                        ],
                      ))
                    ],
                  ),
                  const SizedBox(width: 4),
                  Text(comment, style: const TextStyle(fontSize: 17))
                ],
              ),
            )
          ]);
        }
        result.addAll([
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: LsColor.secondaryDivider)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: submissionColumns,
            ),
          )
        ]);
      }

      return result;
    }

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
        children: columns(),
      ),
    );
  }
}
