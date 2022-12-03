import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loomus_app/models/program/section.dart';
import 'package:loomus_app/utilities/extensions.dart';
import 'package:loomus_app/utilities/ls_color.dart';
import 'package:loomus_app/widgets/common/image_widget.dart';
import 'package:loomus_app/widgets/lesson/lesson_widget.dart';
import 'package:loomus_app/widgets/module/module_widget.dart';

import '../../models/course/member_course.dart';

mixin SectionWidgetDelegate {
  bool isSectionPassed(Section section);
}

class SectionWidget extends StatelessWidget {
  final Section section;
  final MemberCourse memberCourse;
  final SectionWidgetDelegate delegate;
  final ModuleWidgetDelegate moduleDelegate;
  final LessonWidgetDelegate lessonDelegate;

  const SectionWidget(this.section, this.memberCourse, this.delegate,
      this.moduleDelegate, this.lessonDelegate,
      {super.key});

  @override
  Widget build(BuildContext context) {
    Color borderColor() {
      return delegate.isSectionPassed(section) ? LsColor.brand : LsColor.divider;
    }

    return Stack(
      children: [
        Positioned(
            bottom: 0,
            left: 32.5,
            height: 30,
            child: Container(color: borderColor(), width: 1.5)),
        Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(boxShadow: [
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
                  child: AspectRatio(
                      aspectRatio: 2,
                      child: ImageWidget(section.banner?.path,
                          fit: BoxFit.cover, width: double.infinity)),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: section.modules
                          .ascendingBy((e) => e.index)
                          .map((module) => ModuleWidget(module, memberCourse,
                              moduleDelegate, lessonDelegate))
                          .toList(),
                    ))
              ],
            ))
      ],
    );
  }
}
