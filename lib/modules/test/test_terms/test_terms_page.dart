import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:loomus_app/modules/test/test/test_view_model.dart';
import 'package:loomus_app/modules/test/test_terms/test_terms_view_model.dart';
import 'package:loomus_app/services/analytics_service.dart';
import 'package:loomus_app/utilities/ls_router.dart';
import 'package:loomus_app/utilities/utils.dart';
import 'package:provider/provider.dart';

import '../../../components/ls_button.dart';
import '../../../utilities/ls_color.dart';

class TestTermsPage extends StatelessWidget {
  const TestTermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TestTermsViewModel viewModel = context.watch<TestTermsViewModel>();
    final AppLocalizations? local = AppLocalizations.of(context);

    return PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text(local?.testTermsPageTitle ?? "",
              style: const TextStyle(color: LsColor.label)),
          material: (_, __) => MaterialAppBarData(
              shadowColor: const Color.fromRGBO(37, 37, 37, 0.1)),
        ),
        backgroundColor: LsColor.background,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RichText(
                            text: TextSpan(
                                text: "1. ",
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: LsColor.label),
                                children: [
                              TextSpan(
                                  text: local?.testTermsPageTerm1,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal,
                                      color: LsColor.label))
                            ])),
                        const SizedBox(height: 16),
                        RichText(
                            text: TextSpan(
                                text: "2. ",
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: LsColor.label),
                                children: [
                              TextSpan(
                                  text: local?.testTermsPageTerm2,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal,
                                      color: LsColor.label))
                            ])),
                        const SizedBox(height: 16),
                        RichText(
                            text: TextSpan(
                                text: "3. ",
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: LsColor.label),
                                children: [
                              TextSpan(
                                  text: Utils.replace(local?.testTermsPageTerm3,
                                      ["${viewModel.test.passingGrade}"]),
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal,
                                      color: LsColor.label))
                            ])),
                        const SizedBox(height: 16),
                        RichText(
                            text: TextSpan(
                                text: "4. ",
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: LsColor.label),
                                children: [
                              TextSpan(
                                  text: Utils.replace(local?.testTermsPageTerm4,
                                      ["${viewModel.test.passingGrade}"]),
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal,
                                      color: LsColor.label))
                            ])),
                        const SizedBox(height: 20),
                        GestureDetector(
                            onTap: () => viewModel.toggleAgreementHidden(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                          local?.testTermsPageDontShow ?? "",
                                          style:
                                              const TextStyle(fontSize: 17))),
                                  Image.asset(
                                      viewModel.isAgreementHidden
                                          ? "assets/images/checkbox.fill.png"
                                          : "assets/images/round.outline.png",
                                      height: 18,
                                      width: 18,
                                      color: LsColor.brand)
                                ],
                              ),
                            ))
                      ],
                    ))),
            Container(
              padding: EdgeInsets.fromLTRB(
                  16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
              decoration: const BoxDecoration(
                  color: LsColor.background,
                  border: Border(top: BorderSide(color: LsColor.divider))),
              child: LsButton(
                title: local?.testTermsPageSubmit ?? "",
                onPressed: () {
                  viewModel.onHideTest();
                  AnalyticsService.pressOpenPageTest(viewModel.test.courseId,
                      viewModel.test.id, "test_instructions", false);
                  LsRouter(context).openTest(
                      TestDataSource(viewModel.test), viewModel.delegate);
                },
              ),
            ),
          ],
        ));
  }
}
