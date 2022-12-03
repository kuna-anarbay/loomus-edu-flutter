import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:loomus_app/components/ls_button.dart';
import 'package:loomus_app/modules/auth/reset_password/reset_password_view_model.dart';
import 'package:loomus_app/modules/home/home_view_model.dart';
import 'package:loomus_app/utilities/ls_color.dart';
import 'package:provider/provider.dart';

import '../../../utilities/ls_router.dart';
import '../../../widgets/auth/auth_header_widget.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ResetPasswordViewModel viewModel =
        context.watch<ResetPasswordViewModel>();
    final AppLocalizations? local = AppLocalizations.of(context);

    return PlatformScaffold(
        backgroundColor: LsColor.background,
        appBar: PlatformAppBar(
          cupertino: (_, __) => CupertinoNavigationBarData(
            border: const Border(bottom: BorderSide(color: Colors.transparent)),
          ),
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        AuthHeaderWidget(
                            title: local?.resetPasswordPageTitle,
                            description: local?.resetPasswordPageSlogan),
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
                                        hintText:
                                            local?.resetPasswordPageEmail ?? "",
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onChanged: (value) {
                                          viewModel.email = value;
                                        },
                                        cupertino: (_, __) => CupertinoTextFieldData(
                                            placeholderStyle: const TextStyle(
                                                color:
                                                LsColor.secondaryLabel),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: LsColor.divider,
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(8))),
                                        material: (_, __) => MaterialTextFieldData(
                                            decoration: InputDecoration(
                                                hintStyle: const TextStyle(
                                                    color:
                                                    LsColor.secondaryLabel),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 12),
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(8)))))),
                                const SizedBox(height: 12),
                                SizedBox(
                                  height: 46,
                                  child: PlatformTextField(
                                      hintText:
                                          local?.resetPasswordPagePassword ??
                                              "",
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      onChanged: (value) {
                                        viewModel.password = value;
                                      },
                                      cupertino: (_, __) => CupertinoTextFieldData(
                                          placeholderStyle: const TextStyle(
                                              color:
                                              LsColor.secondaryLabel),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: LsColor.divider,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                      material: (_, __) => MaterialTextFieldData(
                                          decoration: InputDecoration(
                                              hintStyle: const TextStyle(
                                                  color:
                                                  LsColor.secondaryLabel),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 12),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8))))),
                                ),
                                Visibility(
                                  visible: viewModel.codeSent,
                                  child: const SizedBox(height: 12),
                                ),
                                Visibility(
                                    visible: viewModel.codeSent,
                                    child: SizedBox(
                                        height: 46,
                                        child: PlatformTextField(
                                            hintText: local?.resetPasswordPageCode ??
                                                "",
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              viewModel.code = value;
                                            },
                                            cupertino: (_, __) => CupertinoTextFieldData(
                                                placeholderStyle: const TextStyle(
                                                    color:
                                                    LsColor.secondaryLabel),
                                                padding: const EdgeInsets.symmetric(
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
                                                        color:
                                                        LsColor.secondaryLabel),
                                                    contentPadding:
                                                        const EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 12),
                                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)))))))
                              ],
                            ),
                            const SizedBox(height: 16),
                            LsButton(
                                isLoading: viewModel.isLoading,
                                onPressed: () {
                                  if (viewModel.codeSent) {
                                    viewModel.onResetPassword().then((user) => {
                                          if (user != null)
                                            {
                                              LsRouter(context).openHome(
                                                  HomeDataSource(user))
                                            }
                                        });
                                  } else {
                                    viewModel.onGetVerificationCode();
                                  }
                                },
                                title: viewModel.codeSent
                                    ? local?.resetPasswordPageReset ?? ""
                                    : local?.resetPasswordPageRequestCode ?? "")
                          ],
                        )
                      ],
                    )
                  ],
                ))));
  }
}
