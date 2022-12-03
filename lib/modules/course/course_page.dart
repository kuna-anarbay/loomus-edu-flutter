import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:loomus_app/modules/course/course_view_model.dart';
import 'package:loomus_app/utilities/extensions.dart';
import 'package:loomus_app/widgets/common/image_widget.dart';
import 'package:loomus_app/widgets/common/loading_page_widget.dart';
import 'package:loomus_app/widgets/lesson/continue_learning_widget.dart';
import 'package:loomus_app/widgets/section/section_widget.dart';
import 'package:provider/provider.dart';

import '../../utilities/ls_color.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    final CourseViewModel viewModel = context.watch<CourseViewModel>();

    Widget continueLearning() {
      final lesson = viewModel.currentLesson();
      if (lesson == null) return Container();

      return Positioned(
          left: 12,
          right: 12,
          bottom: 39,
          child: ContinueLearningWidget(
              viewModel.memberCourse, lesson, viewModel));
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
                fit: BoxFit.cover
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
        body: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: viewModel.isLoading
                    ? const LoadingPageWidget()
                    : Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 150),
                        child: Column(
                            children: viewModel.sections
                                .ascendingBy((e) => e.index)
                                .map((section) => SectionWidget(
                                section,
                                viewModel.memberCourse,
                                viewModel,
                                viewModel,
                                viewModel))
                                .toList())),
              ),
            ),
            continueLearning()
          ],
        ));
  }
}
