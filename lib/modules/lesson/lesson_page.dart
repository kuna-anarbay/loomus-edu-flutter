import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:loomus_app/features/pod_player/pod_player.dart';
import 'package:loomus_app/modules/lesson/lesson_view_model.dart';
import 'package:loomus_app/utilities/ls_router.dart';
import 'package:loomus_app/widgets/common/loading_page_widget.dart';
import 'package:loomus_app/widgets/homework/homework_widget.dart';
import 'package:loomus_app/widgets/lesson/lesson_details_widget.dart';
import 'package:loomus_app/widgets/lesson_question/lesson_question_widget.dart';
import 'package:loomus_app/widgets/lesson_review/lesson_review_widget.dart';
import 'package:loomus_app/widgets/test/test_widget.dart';
import 'package:provider/provider.dart';

import '../../features/pod_player/src/pod_player.dart';
import '../../utilities/ls_color.dart';

class LessonPage extends StatelessWidget {
  const LessonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? local = AppLocalizations.of(context);
    final LessonViewModel viewModel = context.watch<LessonViewModel>();

    List<Widget> components() {
      final test = viewModel.lessonDetails?.test;
      final homework = viewModel.lessonDetails?.homework;
      final canAskQuestion = viewModel.lessonDetails?.canAskQuestion ?? false;
      final question = viewModel.lessonDetails?.question?.value;

      List<Widget> components = [];
      components.add(LessonDetailsWidget(
          viewModel.lesson, viewModel.loadingResources, viewModel));
      if (viewModel.isLoading) {
        components.add(const LoadingPageWidget());
      }
      if (!viewModel.isLoading &&
          viewModel.lesson.videos.isNotEmpty &&
          viewModel.memberCourse.student != null) {
        components.addAll([
          const SizedBox(height: 20),
          LessonReviewWidget(viewModel.lessonDetails?.rating, viewModel),
        ]);
      }
      if (test != null) {
        components.addAll([
          const SizedBox(height: 20),
          TestWidget(
              test,
              viewModel.memberCourse.student?.testAgreementHidden ?? false,
              viewModel,
              viewModel)
        ]);
      }
      if (homework != null) {
        components.addAll([
          const SizedBox(height: 20),
          HomeworkWidget(
              homework,
              viewModel.isDownloadingHomeworkResource,
              viewModel.memberCourse.student?.homeworkAgreementHidden ?? false,
              viewModel.memberCourse.student?.homeworkAvailable ?? false,
              viewModel,
              viewModel,
              viewModel)
        ]);
      }
      if (canAskQuestion || question != null) {
        components.addAll([
          const SizedBox(height: 20),
          LessonQuestionWidget(question ?? "", canAskQuestion, viewModel)
        ]);
      }
      components.add(const SizedBox(height: 56));

      return components;
    }

    return PlatformScaffold(
        backgroundColor: LsColor.highlightBackground,
        body: SizedBox(
          height: double.infinity,
          child: Column(
            children: [
              Container(
                color: viewModel.lesson.videos.isNotEmpty
                    ? LsColor.black
                    : LsColor.background,
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: viewModel.lesson.videos.isNotEmpty
                    ? null
                    : Container(
                        height: 44,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: LsColor.secondaryDivider))),
                        child: Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Text(viewModel.lesson.name,
                                  style: const TextStyle(
                                      color: LsColor.label,
                                      fontWeight: FontWeight.w600)),
                            )),
                            GestureDetector(
                              onTap: () {
                                LsRouter(context).pop();
                              },
                              child: Container(
                                height: 44,
                                width: 44,
                                padding: const EdgeInsets.all(6),
                                child: Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                      color: LsColor.transparentBackground,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/images/xmark.png",
                                      height: 20,
                                      width: 20,
                                      color: LsColor.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
              ),
              Expanded(
                  child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: viewModel.lesson.videos.isEmpty
                            ? 0
                            : MediaQuery.of(context).size.width / 16 * 9),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: components()),
                    ),
                  ),
                  Visibility(
                      visible: viewModel.lesson.videos.isNotEmpty,
                      child: Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: PodVideoPlayer(
                              controller: viewModel.controller,
                              videoTitle: Text(viewModel.lesson.name,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      color: LsColor.white, fontSize: 16)),
                              podPlayerLabels: PodPlayerLabels(
                                  playbackSpeed: local?.videoWidgetSpeed ?? "",
                                  quality: local?.videoWidgetQuality ?? "",
                                  error: local?.videoWidgetError ?? ""))))
                ],
              ))
            ],
          ),
        ));
  }
}

// PodVideoPlayer(
// controller: viewModel.controller,
// podProgressBarConfig: const PodProgressBarConfig(
// circleHandlerColor: LsColor.brand,
// playingBarColor: LsColor.brand,
// ))
