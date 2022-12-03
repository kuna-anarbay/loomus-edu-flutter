import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loomus_app/models/test/test_submission.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../utilities/ls_color.dart';
import '../../utilities/utils.dart';

mixin TestResultWidgetDelegate {
  void resubmitTest();
}

class TestResultWidget extends StatelessWidget {
  final TestSubmission submission;
  final bool isPassed;
  final TestResultWidgetDelegate delegate;

  const TestResultWidget(this.submission, this.isPassed, this.delegate,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? local = AppLocalizations.of(context);

    List<Widget> columns() {
      List<Widget> result = [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                    isPassed
                        ? local?.testPagePassed ?? ""
                        : local?.testPageFailed ?? "",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(isPassed ? "" : local?.testPageFailedSubtitle ?? "",
                    style: const TextStyle(
                        fontSize: 13, color: LsColor.secondaryLabel)),
                const SizedBox(height: 8),
                Text(
                    Utils.replace(local?.testPageSubmittedAt,
                        [Utils.date(submission.submittedAt)]),
                    style: const TextStyle(
                        fontSize: 13, color: LsColor.secondaryLabel)),
              ],
            )),
            const SizedBox(width: 12),
            CircularPercentIndicator(
              radius: 36,
              lineWidth: 4,
              percent: submission.score / submission.total,
              progressColor: LsColor.green,
              center: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Text("${submission.score}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(
                        Utils.replace(
                            local?.testPageFrom, ["${submission.total}"]),
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: LsColor.secondaryLabel)),
                  ],
                ),
              ),
            )
          ],
        )
      ];
      if (!isPassed) {
        result.addAll([
          const SizedBox(height: 14),
          Container(color: LsColor.divider, height: 1),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () => delegate.resubmitTest(),
            child: Text(
              local?.testPageRepeat ?? "",
              style: const TextStyle(
                  color: LsColor.brand,
                  fontWeight: FontWeight.w500,
                  fontSize: 17),
            ),
          )
        ]);
      }

      return result;
    }

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          decoration:
              const BoxDecoration(color: LsColor.background, boxShadow: [
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
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: columns(),
          ),
        ));
  }
}
