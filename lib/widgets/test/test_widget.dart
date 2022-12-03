import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loomus_app/components/ls_button.dart';
import 'package:loomus_app/models/test/test.dart';
import 'package:loomus_app/modules/lesson/lesson_view_model.dart';
import 'package:loomus_app/modules/test/test/test_view_model.dart';
import 'package:loomus_app/modules/test/test_terms/test_terms_view_model.dart';
import 'package:loomus_app/services/analytics_service.dart';
import 'package:loomus_app/utilities/ls_router.dart';
import 'package:loomus_app/utilities/utils.dart';

import '../../utilities/ls_color.dart';

class TestWidget extends StatelessWidget {
  final Test test;
  final bool isTestAgreementHidden;
  final LessonVideoDelegate videoDelegate;
  final TestDelegate delegate;

  const TestWidget(
      this.test, this.isTestAgreementHidden, this.videoDelegate, this.delegate,
      {super.key});

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
                child: Image.asset("assets/images/test.png",
                    fit: BoxFit.cover, height: 42, width: 42),
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(local?.lessonPageTestTitle ?? "",
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 2),
                  Text(
                      test.submission == null
                          ? local?.lessonPageTestSubtitle ?? ""
                          : local?.lessonPageTestPassed ?? "",
                      style: const TextStyle(
                          fontSize: 13, color: LsColor.secondaryLabel)),
                ],
              ))
            ],
          ),
          Visibility(
              visible: test.submission != null,
              child: const SizedBox(height: 10)),
          Visibility(
              visible: test.submission != null,
              child: Text(
                  Utils.replace(local?.lessonPageTestResults, [
                    "${test.submission?.score}",
                    "${test.submission?.total}"
                  ]),
                  style: const TextStyle(fontSize: 17, color: LsColor.label))),
          const SizedBox(height: 16),
          LsButton(
              isLoading: false,
              backgroundColor: test.submission == null
                  ? LsColor.brand
                  : LsColor.secondaryBackground,
              titleColor:
                  test.submission == null ? LsColor.white : LsColor.brand,
              onPressed: () {
                videoDelegate.pauseVideo();
                if (test.submission != null || isTestAgreementHidden) {
                  AnalyticsService.pressOpenPageTest(test.courseId, test.id,
                      "lesson", test.submission != null);
                  LsRouter(context).openTest(TestDataSource(test), delegate);
                } else {
                  AnalyticsService.pressOpenPageTestInstructions(
                      test.courseId, test.id);
                  LsRouter(context)
                      .openTestTerms(TestTermsDataSource(test), delegate);
                }
              },
              title: test.submission == null
                  ? local?.lessonPageTestPass ?? ""
                  : local?.lessonPageTestView ?? "",
              height: 42,
              fontSize: 16,
              fontWeight: FontWeight.w500)
        ],
      ),
    );
  }
}
