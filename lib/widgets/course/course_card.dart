import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loomus_app/models/course/member_course.dart';
import 'package:loomus_app/modules/course/course_view_model.dart';
import 'package:loomus_app/modules/demo/demo_view_model.dart';
import 'package:loomus_app/services/analytics_service.dart';
import 'package:loomus_app/utilities/ls_router.dart';
import 'package:loomus_app/utilities/utils.dart';
import 'package:loomus_app/widgets/common/image_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../utilities/ls_color.dart';

class CourseCard extends StatelessWidget {
  final MemberCourse course;
  final CourseDelegate courseDelegate;

  const CourseCard(this.course, this.courseDelegate, {super.key});

  String progress() {
    final progress = course.progress;
    if (progress == null) return "0";
    if (progress.total == 0) return "0";

    final result = (progress.count * 100 / progress.total).toStringAsFixed(1);

    if (result.characters.lastOrNull == "0") {
      return result.substring(0, result.length - 2);
    }

    return result;
  }

  double linearProgress() {
    final progress = course.progress;
    if (progress == null) return 0;
    if (progress.total == 0) return 0;

    return progress.count / progress.total;
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? local = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: GestureDetector(
        onTap: () {
          if (course.isDemo) {
            AnalyticsService.pressOpenPageDemo(course.course.id);
            LsRouter(context).openDemo(DemoDataSource(course));
          } else {
            if (course.staff == null && course.student == null) {
              String url =
                  "https://api.whatsapp.com/send?phone=77066308907&text=%D2%9A%D0%B0%D0%B9%D1%8B%D1%80%D0%BB%D1%8B+%D0%BA%D2%AF%D0%BD%21+%D0%9A%D1%83%D1%80%D1%81+%D0%B6%D0%B0%D0%B9%D0%BB%D1%8B+%D1%82%D0%BE%D0%BB%D1%8B%D2%93%D1%8B%D1%80%D0%B0%D2%9B+%D0%B1%D1%96%D0%BB%D0%B3%D1%96%D0%BC+%D0%BA%D0%B5%D0%BB%D0%B5%D0%B4%D1%96.";
              launchUrlString(url, mode: LaunchMode.externalApplication);

              return;
            }

            AnalyticsService.pressOpenPageCourse(course.course.id);
            LsRouter(context)
                .openCourse(CourseDataSource(course, false), courseDelegate);
          }
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: LsColor.background,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: LsColor.secondaryDivider),
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
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: SizedBox(
                              height: 80,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                      child: Text(course.course.name,
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600))),
                                  const SizedBox(height: 4),
                                  RichText(
                                      text: TextSpan(
                                          text: local?.homePageFrom ?? "",
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: LsColor.secondaryLabel),
                                          children: [
                                        TextSpan(
                                            text: course.authorName,
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: LsColor.brand))
                                      ])),
                                ],
                              ),
                            )),
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: LsColor.lightDivider),
                                  borderRadius: BorderRadius.circular(8)),
                              child: ImageWidget(course.course.banner?.path,
                                  height: 80,
                                  width: 80,
                                  borderRadius: 8,
                                  fit: BoxFit.cover),
                            )
                          ],
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: LinearProgressIndicator(
                                value: linearProgress(),
                                color: LsColor.brand,
                                backgroundColor: LsColor.secondaryDivider)),
                        const SizedBox(height: 4),
                        Text(
                            Utils.replace(
                                local?.homePagePassed, ["${progress()}"]),
                            style: const TextStyle(
                                fontSize: 12, color: LsColor.secondaryLabel))
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}
