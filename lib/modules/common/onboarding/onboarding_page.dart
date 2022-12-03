import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:loomus_app/components/expanded_page_view.dart';
import 'package:loomus_app/components/ls_button.dart';
import 'package:loomus_app/components/page_control.dart';
import 'package:loomus_app/modules/auth/register/register_view_model.dart';
import 'package:loomus_app/modules/common/onboarding/onboarding_view_model.dart';
import 'package:loomus_app/utilities/ls_color.dart';
import 'package:loomus_app/utilities/ls_router.dart';
import 'package:loomus_app/widgets/onboarding/onboarding_widget.dart';
import 'package:provider/provider.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingViewModel viewModel = context.watch<OnboardingViewModel>();
    final AppLocalizations? local = AppLocalizations.of(context);

    Widget bottomNavigation() {
      if (viewModel.currentPage == 2) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: LsButton(
                    title: "Sign In",
                    isLoading: false,
                    onPressed: () {
                      LsRouter(context).openLogin();
                    })),
            const SizedBox(width: 12),
            Expanded(
                child: LsButton(
                    title: "Sign Up",
                    isLoading: false,
                    backgroundColor: LsColor.secondaryBackground,
                    titleColor: LsColor.brand,
                    onPressed: () {
                      LsRouter(context).openRegister(RegisterDataSource(null));
                    })),
          ],
        );
      } else {
        return Row(
          children: [
            PageControl(controller: viewModel.pageController, itemCount: 3),
            const Spacer(),
            GestureDetector(
                onTap: viewModel.onChangePage,
                child: Text("Next",
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: LsColor.brand))),
          ],
        );
      }
    }

    return PlatformScaffold(
        backgroundColor: LsColor.background,
        appBar: PlatformAppBar(
          cupertino: (_, __) => CupertinoNavigationBarData(
            border: const Border(bottom: BorderSide(color: Colors.transparent)),
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text("Loomus",
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: LsColor.brand),
                              textAlign: TextAlign.center),
                          SizedBox(height: 10),
                          Text("app",
                              style: TextStyle(fontSize: 17),
                              textAlign: TextAlign.center),
                        ],
                      )),
                  const SizedBox(height: 32),
                  SizedBox(
                      height: MediaQuery.of(context).size.width,
                      child: ExpandablePageView(
                          itemCount: 3,
                          controller: viewModel.pageController,
                          onPageChanged: viewModel.onPageChanged,
                          itemBuilder: (context, index) => OnboardingWidget(
                              image: "assets/images/onboarding.png",
                              title: "Sign in",
                              description: "Sign in"))),
                ],
              ),
              const Spacer(),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: bottomNavigation())
            ],
          ),
        )));
  }
}
