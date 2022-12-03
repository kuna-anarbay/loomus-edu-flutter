import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:loomus_app/modules/homework/homework/homework_view_model.dart';
import 'package:loomus_app/modules/homework/homework_terms/homework_terms_view_model.dart';
import 'package:loomus_app/services/analytics_service.dart';
import 'package:loomus_app/utilities/ls_router.dart';
import 'package:provider/provider.dart';

import '../../../components/ls_button.dart';
import '../../../utilities/ls_color.dart';

class HomeworkTermsPage extends StatelessWidget {
  const HomeworkTermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeworkTermsViewModel viewModel =
        context.watch<HomeworkTermsViewModel>();
    final AppLocalizations? local = AppLocalizations.of(context);

    return PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text(local?.homeworkTermsPageTitle ?? "",
              style: const TextStyle(color: LsColor.label)),
          material: (_, __) => MaterialAppBarData(
              shadowColor: const Color.fromRGBO(37, 37, 37, 0.1)),
        ),
        backgroundColor: LsColor.background,
        body: Column(
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
                                  text: local?.homeworkTermsPageTerm1,
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
                                  text: local?.homeworkTermsPageTerm2,
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
                                  text: local?.homeworkTermsPageTerm3,
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
                                  text: local?.homeworkTermsPageTerm4,
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
                                          local?.homeworkTermsPageDontShow ??
                                              "",
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
                title: local?.homeworkTermsPageSubmit ?? "",
                onPressed: () {
                  viewModel.onHideHomework();
                  AnalyticsService.pressOpenPageHomework(
                      viewModel.homework.courseId,
                      viewModel.homework.id,
                      "homework_instructions");
                  LsRouter(context).openHomework(
                      HomeworkDataSource(
                          viewModel.homework, viewModel.isHomeworkAvailable),
                      viewModel.delegate);
                },
              ),
            ),
          ],
        ));
  }
}
