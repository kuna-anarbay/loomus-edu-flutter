import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:loomus_app/components/ls_button.dart';
import 'package:loomus_app/modules/homework/homework/homework_view_model.dart';
import 'package:loomus_app/widgets/homework/homework_resource_widget.dart';
import 'package:loomus_app/widgets/homework/student_work_widget.dart';
import 'package:provider/provider.dart';

import '../../../utilities/ls_color.dart';

class HomeworkPage extends StatelessWidget {
  const HomeworkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeworkViewModel viewModel = context.watch<HomeworkViewModel>();
    final AppLocalizations? local = AppLocalizations.of(context);

    List<Widget> columns() {
      final resource = viewModel.homework.resource;
      List<Widget> result = [
        Container(height: 1, color: LsColor.secondaryDivider),
        const SizedBox(height: 16),
        Text(
          viewModel.homework.value,
          style: const TextStyle(fontSize: 17),
        )
      ];
      if (resource != null) {
        result.addAll([
          const SizedBox(height: 10),
          HomeworkResourceWidget(
              resource, viewModel.isResourceLoading, viewModel)
        ]);
      }

      return result;
    }

    return PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text(local?.homeworkPageTitle ?? "",
              style: const TextStyle(color: LsColor.label)),
          material: (_, __) => MaterialAppBarData(
              shadowColor: const Color.fromRGBO(37, 37, 37, 0.1)),
        ),
        backgroundColor: LsColor.highlightBackground,
        body: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                              color: LsColor.background,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(16)),
                              boxShadow: [
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: columns(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        StudentWorkWidget(viewModel.value, viewModel.file,
                            viewModel.isHomeworkAvailable, viewModel)
                      ],
                    ))),
            Visibility(
                visible: viewModel.isHomeworkAvailable &&
                    viewModel.submission == null,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
                  decoration: const BoxDecoration(
                      color: LsColor.background,
                      border: Border(top: BorderSide(color: LsColor.divider))),
                  child: LsButton(
                    isLoading: viewModel.isSubmitting,
                    title: local?.homeworkPageSubmit ?? "",
                    onPressed: () {
                      viewModel.submitHomework().then((value) {
                        viewModel.showToast(local?.homeworkPageSuccess ?? "");
                      });
                    },
                  ),
                ))
          ],
        ));
  }
}
