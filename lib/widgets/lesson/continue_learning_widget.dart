import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loomus_app/models/program/lesson.dart';
import 'package:loomus_app/modules/lesson/lesson_view_model.dart';
import 'package:loomus_app/services/analytics_service.dart';
import 'package:loomus_app/utilities/ls_color.dart';
import 'package:loomus_app/utilities/ls_router.dart';
import 'package:loomus_app/utilities/utils.dart';

import '../../models/course/member_course.dart';

class ContinueLearningWidget extends StatelessWidget {
  final Lesson lesson;
  final MemberCourse memberCourse;
  final LessonDelegate delegate;

  const ContinueLearningWidget(this.memberCourse, this.lesson, this.delegate,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? local = AppLocalizations.of(context);

    return GestureDetector(
      onTap: () {
        AnalyticsService.pressContinueLearning(lesson.courseId, lesson.id);
        LsRouter(context)
            .openLesson(LessonDataSource(memberCourse, lesson), delegate);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: LsColor.secondaryBrand),
            borderRadius: BorderRadius.circular(14),
            color: LsColor.brand,
            boxShadow: const [
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
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(local?.coursePageContinueLearning ?? "",
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: LsColor.white)),
                const SizedBox(height: 2),
                Text(lesson.name,
                    style: const TextStyle(fontSize: 16, color: LsColor.white),
                    maxLines: 1),
                const SizedBox(height: 2),
                Text(
                    Utils.replace(local?.coursePageLessonReadTime,
                        ["${lesson.duration}"]),
                    style: TextStyle(
                        fontSize: 13, color: LsColor.white.withOpacity(0.7)))
              ],
            )),
            Image.asset("assets/images/chevron.right.png",
                height: 15, width: 15, color: LsColor.white)
          ],
        ),
      ),
    );
  }
}
