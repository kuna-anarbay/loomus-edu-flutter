import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loomus_app/modules/course/course_view_model.dart';
import 'package:loomus_app/modules/lesson/lesson_view_model.dart';
import 'package:loomus_app/services/analytics_service.dart';
import 'package:loomus_app/utilities/ls_color.dart';
import 'package:loomus_app/utilities/ls_router.dart';

import '../../models/course/member_course.dart';

class ViewDemoCourseWidget extends StatelessWidget {
  final MemberCourse memberCourse;
  final LessonDelegate lessonDelegate;
  final CourseDelegate delegate;

  const ViewDemoCourseWidget(
      this.memberCourse, this.delegate, this.lessonDelegate,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? local = AppLocalizations.of(context);

    return GestureDetector(
      onTap: () {
        AnalyticsService.pressOpenFullProgram(memberCourse.course.id);
        LsRouter(context)
            .openCourse(CourseDataSource(memberCourse, true), delegate);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: LsColor.secondaryBrand),
            borderRadius: BorderRadius.circular(12),
            color: LsColor.brand),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(local?.demoPageViewProgram ?? "",
                    style: const TextStyle(
                        fontSize: 12,
                        color: LsColor.white,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(local?.demoPageFullProgram ?? "",
                    style: const TextStyle(fontSize: 16, color: LsColor.white))
              ],
            )),
            const SizedBox(width: 8),
            Image.asset("assets/images/chevron.right.png",
                height: 15, width: 15, color: LsColor.white)
          ],
        ),
      ),
    );
  }
}
