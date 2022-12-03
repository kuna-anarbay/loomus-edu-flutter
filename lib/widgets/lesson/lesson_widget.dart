import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loomus_app/models/course/member_course.dart';
import 'package:loomus_app/modules/lesson/lesson_view_model.dart';
import 'package:loomus_app/services/analytics_service.dart';
import 'package:loomus_app/utilities/ls_router.dart';
import 'package:loomus_app/utilities/utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../models/program/lesson.dart';
import '../../utilities/ls_color.dart';
import '../common/toast_widget.dart';

mixin LessonWidgetDelegate {
  bool isLessonAvailable(Lesson lesson);

  void setLessonPassed(Lesson lesson);
}

class LessonWidget extends StatelessWidget with LessonDelegate {
  final Lesson lesson;
  final MemberCourse memberCourse;
  final LessonWidgetDelegate delegate;

  const LessonWidget(this.lesson, this.memberCourse, this.delegate,
      {super.key});

  @override
  void setLessonPassed(Lesson lesson) {
    delegate.setLessonPassed(lesson);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? local = AppLocalizations.of(context);

    return GestureDetector(
      onTap: () {
        // Check if staff
        if (memberCourse.role != "STUDENT") {
          AnalyticsService.pressOpenPageLesson(
              lesson.courseId, lesson.id, "course");
          LsRouter(context)
              .openLesson(LessonDataSource(memberCourse, lesson), this);
          return;
        }

        // Check is demo lessons
        if (memberCourse.isDemo) {
          String url =
              "https://api.whatsapp.com/send?phone=77066308907&text=%D2%9A%D0%B0%D0%B9%D1%8B%D1%80%D0%BB%D1%8B+%D0%BA%D2%AF%D0%BD%21+%D0%9A%D1%83%D1%80%D1%81+%D0%B6%D0%B0%D0%B9%D0%BB%D1%8B+%D1%82%D0%BE%D0%BB%D1%8B%D2%93%D1%8B%D1%80%D0%B0%D2%9B+%D0%B1%D1%96%D0%BB%D0%B3%D1%96%D0%BC+%D0%BA%D0%B5%D0%BB%D0%B5%D0%B4%D1%96.";
          launchUrlString(url, mode: LaunchMode.externalApplication);
          return;
        }

        // Check if lesson is available
        if (!lesson.isAvailable) {
          const url =
              "https://api.whatsapp.com/send?phone=77066308907&text=%D0%9C%D0%B5%D0%BD+%D0%BA%D1%83%D1%80%D1%81%D1%82%D1%8B+%D0%BE%D2%9B%D1%83%D0%B4%D1%8B+%D0%B6%D0%B0%D0%BB%D2%93%D0%B0%D1%81%D1%82%D1%8B%D1%80%D2%93%D1%8B%D0%BC+%D0%BA%D0%B5%D0%BB%D0%B5%D0%B4%D1%96+%F0%9F%9A%80.+%D0%A2%D0%BE%D0%BB%D1%8B%D2%93%D1%8B%D1%80%D0%B0%D2%9B+%D0%B0%D0%B9%D1%82%D1%8B%D0%BF+%D0%B1%D0%B5%D1%80%D0%B5%D1%81%D1%96%D0%B7%D0%B1%D0%B5%3F";
          launchUrlString(url, mode: LaunchMode.externalApplication);
          return;
        }

        // Check if lesson is active
        if (lesson.status != "ACTIVE") {
          ToastWidget.showToastWidget(
              local?.coursePageLessonNotActive ?? "", context, true);
          return;
        }

        // Check if lesson is available
        if (!delegate.isLessonAvailable(lesson)) {
          ToastWidget.showToastWidget(
              local?.coursePageModuleClosed ?? "", context, true);
          return;
        }

        // Open lesson
        AnalyticsService.pressOpenPageLesson(
            lesson.courseId, lesson.id, "course");
        LsRouter(context)
            .openLesson(LessonDataSource(memberCourse, lesson), this);
      },
      child: Container(
        decoration: BoxDecoration(
            border: lesson.index == 1
                ? null
                : const Border(
                    top: BorderSide(color: LsColor.secondaryDivider))),
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
                RichText(
                    text: TextSpan(
                        text: Utils.replace(
                            local?.coursePageLessonIndex, ["${lesson.index}"]),
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: LsColor.label),
                        children: [
                      TextSpan(
                          text: lesson.name,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                              color: LsColor.label))
                    ])),
                const SizedBox(height: 2),
                Text(
                    Utils.replace(local?.coursePageLessonReadTime,
                        ["${lesson.duration}"]),
                    style: const TextStyle(
                        fontSize: 13, color: LsColor.secondaryLabel))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
