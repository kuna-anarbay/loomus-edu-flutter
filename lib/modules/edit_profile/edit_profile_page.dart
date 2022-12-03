import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:loomus_app/components/ls_button.dart';
import 'package:loomus_app/modules/edit_profile/edit_profile_view_model.dart';
import 'package:loomus_app/utilities/ls_router.dart';
import 'package:loomus_app/widgets/common/avatar_widget.dart';
import 'package:provider/provider.dart';

import '../../utilities/ls_color.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final EditProfileViewModel viewModel =
        context.watch<EditProfileViewModel>();
    final AppLocalizations? local = AppLocalizations.of(context);

    return PlatformScaffold(
        backgroundColor: LsColor.secondaryBackground,
        appBar: PlatformAppBar(
          title: Text(local?.editProfilePageTitle ?? "",
              style: const TextStyle(color: LsColor.label)),
          material: (_, __) => MaterialAppBarData(
              shadowColor: const Color.fromRGBO(37, 37, 37, 0.1)),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(64),
                          border: Border.all(color: LsColor.secondaryDivider)),
                      child: AvatarWidget(viewModel.user.avatarUrl, 128),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                        onTap: () => viewModel.onEditAvatar(context, local),
                        child: Text(local?.editProfilePageEditAvatar ?? "",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: LsColor.brand)))
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 46,
                  child: PlatformTextField(
                      controller: viewModel.firstNameEditingController,
                      hintText: local?.editProfilePageFirstName,
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        viewModel.user.firstName = value;
                      },
                      cupertino: (_, __) => CupertinoTextFieldData(
                          placeholderStyle:
                              const TextStyle(color: LsColor.secondaryLabel),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: LsColor.divider, width: 1),
                              borderRadius: BorderRadius.circular(8),
                              color: LsColor.background)),
                      material: (_, __) => MaterialTextFieldData(
                          decoration: InputDecoration(
                              hintStyle: const TextStyle(
                                  color: LsColor.secondaryLabel),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 12),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))))),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 46,
                  child: PlatformTextField(
                      controller: viewModel.lastNameEditingController,
                      hintText: local?.editProfilePageLastName,
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        viewModel.user.lastName = value;
                      },
                      cupertino: (_, __) => CupertinoTextFieldData(
                          placeholderStyle:
                              const TextStyle(color: LsColor.secondaryLabel),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: LsColor.divider, width: 1),
                              borderRadius: BorderRadius.circular(8),
                              color: LsColor.background)),
                      material: (_, __) => MaterialTextFieldData(
                          decoration: InputDecoration(
                              hintStyle: const TextStyle(
                                  color: LsColor.secondaryLabel),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 12),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))))),
                ),
                const SizedBox(height: 16),
                LsButton(
                    isLoading: viewModel.isEditingAccount,
                    onPressed: () {
                      viewModel.onEditProfile().then((value) {
                        if (value) {
                          viewModel
                              .showToast(local?.editProfilePageSuccess ?? "");
                        }
                      });
                    },
                    title: local?.editProfilePageSave ?? ""),
                SizedBox(height: MediaQuery.of(context).size.height / 4),
                LsButton(
                    isLoading: viewModel.isLoggingOut,
                    backgroundColor: LsColor.background,
                    height: 44,
                    borderRadius: 6,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    borderColor: LsColor.secondaryDivider,
                    titleColor: LsColor.label,
                    onPressed: () {
                      viewModel.onLogOut().then((value) {
                        LsRouter(context).openLogin();
                      });
                    },
                    title: local?.editProfilePageLogout ?? ""),
                const SizedBox(height: 12),
                LsButton(
                    isLoading: viewModel.isDeletingAccount,
                    backgroundColor: LsColor.background,
                    height: 44,
                    borderRadius: 6,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    titleColor: LsColor.red,
                    borderColor: LsColor.secondaryDivider,
                    onPressed: () {
                      viewModel.onDeleteAccount().then((value) {
                        LsRouter(context).openLogin();
                      });
                    },
                    title: local?.editProfilePageDeleteAccount ?? ""),
              ],
            ),
          ),
        )));
  }
}
