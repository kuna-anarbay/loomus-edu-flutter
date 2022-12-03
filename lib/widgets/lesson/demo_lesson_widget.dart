import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loomus_app/models/course/member_course.dart';
import 'package:loomus_app/modules/lesson/lesson_view_model.dart';
import 'package:loomus_app/services/analytics_service.dart';
import 'package:loomus_app/utilities/ls_router.dart';
import 'package:loomus_app/utilities/utils.dart';
import 'package:loomus_app/widgets/common/toast_widget.dart';

import '../../models/program/lesson.dart';
import '../../utilities/ls_color.dart';

mixin DemoLessonWidgetDelegate {
  bool isLessonAvailable(Lesson lesson);

  void setLessonPassed(Lesson lesson);
}

class DemoLessonWidget extends StatelessWidget with LessonDelegate {
  final Lesson lesson;
  final MemberCourse memberCourse;
  final DemoLessonWidgetDelegate delegate;

  const DemoLessonWidget(this.lesson, this.memberCourse, this.delegate,
      {super.key});

  @override
  void setLessonPassed(Lesson lesson) {
    delegate.setLessonPassed(lesson);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? local = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: GestureDetector(
        onTap: () {
          if (!delegate.isLessonAvailable(lesson)) {
            ToastWidget.showToastWidget(
                local?.coursePageModuleClosed ?? "", context, true);
            return;
          }
          AnalyticsService.pressOpenPageLesson(
              lesson.courseId, lesson.id, "demo");
          LsRouter(context)
              .openLesson(LessonDataSource(memberCourse, lesson), this);
        },
        child: Container(
          decoration: BoxDecoration(
              color: LsColor.background,
              border: Border.all(color: LsColor.secondaryDivider),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                  lesson.isPassed
                      ? "assets/images/checkmark.fill.png"
                      : "assets/images/circle.png",
                  height: 20,
                  width: 20,
                  color: lesson.isPassed ? LsColor.brand : LsColor.divider),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                      Utils.replace(
                              local?.demoPageLessonIndex, ["${lesson.index}"])
                          .toLowerCase(),
                      style: const TextStyle(
                          fontFeatures: [FontFeature.enable("smcp")],
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: LsColor.brand)),
                  Text(lesson.name,
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          color: LsColor.label)),
                  const SizedBox(height: 2),
                  Text(
                      Utils.replace(local?.demoPageLessonReadTime,
                          ["${lesson.duration}"]),
                      style: const TextStyle(
                          fontSize: 13, color: LsColor.secondaryLabel))
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
