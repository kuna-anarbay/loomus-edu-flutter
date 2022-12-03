import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:loomus_app/modules/edit_profile/edit_profile_view_model.dart';
import 'package:loomus_app/modules/profile/profile_view_model.dart';
import 'package:loomus_app/services/analytics_service.dart';
import 'package:loomus_app/utilities/ls_color.dart';
import 'package:loomus_app/utilities/ls_router.dart';
import 'package:provider/provider.dart';

import '../../widgets/common/avatar_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel viewModel = context.watch<ProfileViewModel>();
    final AppLocalizations? local = AppLocalizations.of(context);

    return PlatformScaffold(
        backgroundColor: LsColor.background,
        appBar: PlatformAppBar(
            title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Expanded(
                  child: Text(local?.profilePageTitle ?? "",
                      style: const TextStyle(color: LsColor.label))),
              GestureDetector(
                onTap: () {
                  AnalyticsService.pressOpenPageEditProfile(viewModel.user.id);
                  LsRouter(context).openEditProfile(
                      EditProfileDataSource(viewModel.user), viewModel);
                },
                child: Center(
                    child: Text(local?.profilePageEdit ?? "",
                        style: const TextStyle(
                            color: LsColor.brand,
                            fontSize: 17,
                            fontWeight: FontWeight.normal))),
              )
            ],
          ),
        )),
        body: Container(
            color: LsColor.secondaryBackground,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: LsColor.background,
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(37, 37, 37, 0.02),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 2))
                      ],
                      border: Border(
                          bottom: BorderSide(color: LsColor.secondaryDivider))),
                  child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AvatarWidget(viewModel.user.avatarUrl, 56),
                          const SizedBox(width: 16),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(viewModel.user.fullName,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              Text(viewModel.user.email,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: LsColor.secondaryLabel))
                            ],
                          ))
                        ],
                      )),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: viewModel
                            .sections(local)
                            .map((section) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Visibility(
                                        visible: section.title != null,
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16, bottom: 8),
                                            child: Text(section.title ?? "",
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w600)))),
                                    Visibility(
                                        visible: section.items.isNotEmpty,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: LsColor.background,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: LsColor.lightDivider)),
                                          child: Column(
                                              children: section.items
                                                  .map(
                                                      (item) => GestureDetector(
                                                          onTap: () {
                                                            viewModel
                                                                .onClickOnCell(
                                                                    context,
                                                                    local,
                                                                    section
                                                                        .index,
                                                                    item.index);
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                border: Border(
                                                                    top: BorderSide(
                                                                        color: item.index ==
                                                                                0
                                                                            ? Colors.transparent
                                                                            : LsColor.secondaryDivider))),
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      16,
                                                                  vertical: 10),
                                                              child: Row(
                                                                children: [
                                                                  Image.asset(
                                                                      item
                                                                          .image,
                                                                      width: 24,
                                                                      height:
                                                                          24,
                                                                      color: LsColor
                                                                          .brand),
                                                                  const SizedBox(
                                                                      width: 8),
                                                                  Expanded(
                                                                      child: Text(
                                                                          item
                                                                              .title,
                                                                          style:
                                                                              const TextStyle(fontSize: 17))),
                                                                  Visibility(
                                                                      visible:
                                                                          item.details !=
                                                                              null,
                                                                      child: Text(
                                                                          item.details ??
                                                                              "",
                                                                          style: const TextStyle(
                                                                              fontSize: 17,
                                                                              color: LsColor.secondaryLabel))),
                                                                  const SizedBox(
                                                                      width: 8),
                                                                  Image.asset(
                                                                      "assets/images/chevron.right.png",
                                                                      color: LsColor
                                                                          .gray,
                                                                      height:
                                                                          14,
                                                                      width: 14)
                                                                ],
                                                              ),
                                                            ),
                                                          )))
                                                  .toList()),
                                        ))
                                  ],
                                )))
                            .toList(),
                      )),
                ))
              ],
            )));
  }
}
