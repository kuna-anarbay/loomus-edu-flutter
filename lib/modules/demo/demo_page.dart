import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:loomus_app/modules/demo/demo_view_model.dart';
import 'package:loomus_app/utilities/extensions.dart';
import 'package:loomus_app/widgets/common/image_widget.dart';
import 'package:loomus_app/widgets/common/loading_page_widget.dart';
import 'package:loomus_app/widgets/course/view_demo_course_widget.dart';
import 'package:loomus_app/widgets/lesson/demo_lesson_widget.dart';
import 'package:provider/provider.dart';

import '../../utilities/ls_color.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DemoViewModel viewModel = context.watch<DemoViewModel>();
    final AppLocalizations? local = AppLocalizations.of(context);

    Widget continueLearning() {
      return Positioned(
          left: 12,
          right: 12,
          bottom: 16,
          child: ViewDemoCourseWidget(
              viewModel.memberCourse, viewModel, viewModel));
    }

    return PlatformScaffold(
        backgroundColor: LsColor.highlightBackground,
        appBar: PlatformAppBar(
          title: Row(
            children: [
              ImageWidget(
                viewModel.memberCourse.course.banner?.path,
                height: 32,
                width: 32,
                borderRadius: 6,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 12),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(viewModel.memberCourse.course.name,
                      maxLines: 1,
                      style: const TextStyle(color: LsColor.label)),
                  Text(viewModel.memberCourse.authorName,
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: LsColor.secondaryLabel))
                ],
              ))
            ],
          ),
          material: (_, __) => MaterialAppBarData(
              shadowColor: const Color.fromRGBO(37, 37, 37, 0.1)),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: viewModel.isLoading
                          ? const LoadingPageWidget()
                          : Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                  children: viewModel.lessons
                                      .ascendingBy((e) => e.index)
                                      .map((section) => DemoLessonWidget(
                                          section,
                                          viewModel.memberCourse,
                                          viewModel))
                                      .toList())),
                    ),
                  )
                ],
              ),
              continueLearning()
            ],
          ),
        ));
  }
}
