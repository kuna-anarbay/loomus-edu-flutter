import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:loomus_app/components/ls_button.dart';
import 'package:loomus_app/modules/auth/login/login_view_model.dart';
import 'package:loomus_app/modules/auth/register/register_view_model.dart';
import 'package:loomus_app/modules/auth/reset_password/reset_password_view_model.dart';
import 'package:loomus_app/modules/home/home_view_model.dart';
import 'package:loomus_app/services/analytics_service.dart';
import 'package:loomus_app/utilities/ls_color.dart';
import 'package:loomus_app/utilities/ls_router.dart';
import 'package:loomus_app/widgets/auth/auth_header_widget.dart';
import 'package:provider/provider.dart';

import '../../../provider/app_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginViewModel viewModel = context.watch<LoginViewModel>();
    final AppLocalizations? local = AppLocalizations.of(context);

    return PlatformScaffold(
        backgroundColor: LsColor.background,
        appBar: PlatformAppBar(
          cupertino: (_, __) => CupertinoNavigationBarData(
            border: const Border(bottom: BorderSide(color: Colors.transparent)),
          ),
        ),
        cupertino: (_, __) =>
            CupertinoPageScaffoldData(resizeToAvoidBottomInset: true),
        material: (_, __) =>
            MaterialScaffoldData(resizeToAvoidBottomInset: true),
        body: LayoutBuilder(
          builder: (context, constraint) => SafeArea(
              child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight - 48),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          AuthHeaderWidget(
                              title: local?.signInPageTitle,
                              description: local?.signInPageSlogan),
                          const SizedBox(height: 32),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  SizedBox(
                                      height: 46,
                                      child: PlatformTextField(
                                        hintText: local?.signInPageEmail ?? "",
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onChanged: (value) {
                                          viewModel.email = value;
                                        },
                                        cupertino: (_, __) =>
                                            CupertinoTextFieldData(
                                                placeholderStyle:
                                                    const TextStyle(
                                                        color: LsColor
                                                            .secondaryLabel),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: LsColor.divider,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8))),
                                        material: (_,
                                                __) =>
                                            MaterialTextFieldData(
                                                decoration: InputDecoration(
                                                    hintStyle: const TextStyle(
                                                        color: LsColor
                                                            .secondaryLabel),
                                                    contentPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            vertical: 5,
                                                            horizontal: 12),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)))),
                                      )),
                                  const SizedBox(height: 12),
                                  SizedBox(
                                      height: 46,
                                      child: PlatformTextField(
                                          hintText:
                                              local?.signInPagePassword ?? "",
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          onChanged: (value) {
                                            viewModel.password = value;
                                          },
                                          cupertino: (_, __) => CupertinoTextFieldData(
                                              placeholderStyle: const TextStyle(
                                                  color:
                                                      LsColor.secondaryLabel),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: LsColor.divider,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8))),
                                          material: (_, __) => MaterialTextFieldData(
                                              decoration: InputDecoration(
                                                  hintStyle: const TextStyle(
                                                      color: LsColor.secondaryLabel),
                                                  contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)))))),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          AnalyticsService
                                              .pressOpenPageResetPassword();
                                          LsRouter(context).openResetPassword(
                                              ResetPasswordDataSource(
                                                  viewModel.email));
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6),
                                          child: Text(
                                              local?.signInPageForgotPassword ??
                                                  "",
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  color:
                                                      LsColor.secondaryLabel)),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 16),
                              LsButton(
                                  isLoading: viewModel.isLoadingEmail,
                                  onPressed: () {
                                    viewModel.onSignIn().then((user) {
                                      if (user != null) {
                                        context
                                            .read<AppProvider>()
                                            .setLocale(Locale(user.language));
                                        LsRouter(context)
                                            .openHome(HomeDataSource(user));
                                      }
                                    });
                                  },
                                  title: local?.signInPageButtonTitle ?? "")
                            ],
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(local?.signInPageDontHaveAccount ?? "",
                                  style: const TextStyle(
                                      fontSize: 15, color: LsColor.label)),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  AnalyticsService.pressOpenPageSignUp();
                                  LsRouter(context).openRegister(
                                      RegisterDataSource(viewModel.email));
                                },
                                child: Text(
                                    local?.signInPageCreateAccount ?? "",
                                    style: const TextStyle(
                                        color: LsColor.brand,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              )
                            ],
                          )
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Visibility(
                              visible: Platform.isIOS,
                              child: LsButton(
                                  isLoading: viewModel.isLoadingApple,
                                  fontSize: 16,
                                  height: 42,
                                  fontWeight: FontWeight.w500,
                                  borderRadius: 7,
                                  borderColor: LsColor.divider,
                                  backgroundColor: LsColor.background,
                                  titleColor: LsColor.label,
                                  icon: Image.asset(
                                      "assets/images/apple-logo.png",
                                      height: 18,
                                      width: 18),
                                  onPressed: () {
                                    viewModel.onSignInWithApple().then((user) {
                                      if (user != null) {
                                        context
                                            .read<AppProvider>()
                                            .setLocale(Locale(user.language));
                                        LsRouter(context)
                                            .openHome(HomeDataSource(user));
                                      }
                                    });
                                  },
                                  title:
                                      local?.signInPageSignInWithApple ?? "")),
                          Visibility(
                              visible: Platform.isIOS,
                              child: const SizedBox(height: 12)),
                          LsButton(
                              isLoading: viewModel.isLoadingGoogle,
                              fontSize: 16,
                              height: 42,
                              fontWeight: FontWeight.w500,
                              borderRadius: 7,
                              borderColor: LsColor.divider,
                              backgroundColor: LsColor.background,
                              titleColor: LsColor.label,
                              icon: Image.asset("assets/images/google-logo.png",
                                  height: 18, width: 18),
                              onPressed: () {
                                viewModel.onSignInWithGoogle().then((user) {
                                  if (user != null) {
                                    context
                                        .read<AppProvider>()
                                        .setLocale(Locale(user.language));
                                    LsRouter(context)
                                        .openHome(HomeDataSource(user));
                                  }
                                });
                              },
                              title: local?.signInPageSignInWithGoogle ?? "")
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
        ));
  }
}
