import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:loomus_app/components/ls_button.dart';
import 'package:loomus_app/modules/auth/phone_verification/phone_verification_view_model.dart';
import 'package:loomus_app/utilities/ls_color.dart';
import 'package:provider/provider.dart';

import '../../../widgets/auth/auth_header_widget.dart';

class PhoneVerificationPage extends StatelessWidget {
  const PhoneVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PhoneVerificationViewModel viewModel =
        context.watch<PhoneVerificationViewModel>();
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
                                hintText: "Phone number",
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {
                                  viewModel.phone = value;
                                },
                                cupertino: (_, __) => CupertinoTextFieldData(
                                    placeholderStyle: const TextStyle(
                                        color:
                                        LsColor.secondaryLabel),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: LsColor.divider, width: 1),
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                material: (_, __) => MaterialTextFieldData(
                                    decoration: InputDecoration(
                                        hintStyle: const TextStyle(
                                            color:
                                            LsColor.secondaryLabel),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 12),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))))),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 46,
                            child: PlatformTextField(
                                hintText: "Code",
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
                                            color: LsColor.divider, width: 1),
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                material: (_, __) => MaterialTextFieldData(
                                    decoration: InputDecoration(
                                        hintStyle: const TextStyle(
                                            color:
                                            LsColor.secondaryLabel),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 12),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))))),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      LsButton(
                          isLoading: viewModel.isLoading,
                          onPressed: viewModel.onClickSubmit(),
                          title: "Confirm phone")
                    ],
                  )
                ],
              )
            ],
          ),
        )));
  }
}
