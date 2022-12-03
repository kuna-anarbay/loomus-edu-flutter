import 'dart:ui';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loomus_app/models/program/module.dart';
import 'package:loomus_app/utilities/extensions.dart';
import 'package:loomus_app/utilities/utils.dart';
import 'package:loomus_app/widgets/lesson/lesson_widget.dart';

import '../../models/course/member_course.dart';
import '../../utilities/ls_color.dart';

mixin ModuleWidgetDelegate {
  ModuleStatus getModuleStatus(Module module);
}

class ModuleWidget extends StatelessWidget {
  final Module module;
  final MemberCourse memberCourse;
  final ModuleWidgetDelegate delegate;
  final LessonWidgetDelegate lessonDelegate;

  const ModuleWidget(
      this.module, this.memberCourse, this.delegate, this.lessonDelegate,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? local = AppLocalizations.of(context);

    Widget icon() {
      final status = delegate.getModuleStatus(module);
      switch (status) {
        case ModuleStatus.current:
          return Image.asset("assets/images/mappin.png",
              height: 14, width: 14, color: LsColor.brand);
        case ModuleStatus.closed:
          return Image.asset("assets/images/lock.png",
              height: 14, width: 14, color: LsColor.secondaryLabel);
        case ModuleStatus.passed:
          return Image.asset("assets/images/checkmark.fill.png",
              height: 14, width: 14, color: LsColor.brand);
      }
    }

    Color textColor() {
      final status = delegate.getModuleStatus(module);
      switch (status) {
        case ModuleStatus.current:
          return LsColor.brand;
        case ModuleStatus.closed:
          return LsColor.secondaryLabel;
        case ModuleStatus.passed:
          return LsColor.brand;
      }
    }

    Color borderColor() {
      final status = delegate.getModuleStatus(module);
      switch (status) {
        case ModuleStatus.current:
          return LsColor.brand;
        case ModuleStatus.closed:
          return LsColor.divider;
        case ModuleStatus.passed:
          return LsColor.brand;
      }
    }

    return ExpandableNotifier(
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 20.5,
                height: 12,
                child: Container(
                    color: borderColor(), width: 1.5)),
            Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Expandable(
                    collapsed: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                        child: ExpandableButton(
                            theme: const ExpandableThemeData(useInkWell: false),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                  color: LsColor.background,
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
                                  borderRadius: BorderRadius.circular(14)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            children: [
                                              icon(),
                                              const SizedBox(width: 4),
                                              Text(
                                                  Utils.replace(
                                                      local?.coursePageModuleIndex,
                                                      ["${module.index}"])
                                                      .toLowerCase(),
                                                  style: TextStyle(
                                                      fontFeatures: const [
                                                        FontFeature.enable("smcp")
                                                      ],
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w600,
                                                      color: textColor()))
                                            ],
                                          ),
                                          Text(module.name,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: LsColor.label)),
                                          Text(
                                              Utils.replace(
                                                  local?.coursePageModulePassed, [
                                                "${module.lessons.where((element) => element.isPassed).length}",
                                                "${module.lessons.length}"
                                              ]),
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: LsColor.secondaryLabel))
                                        ],
                                      )),
                                  const SizedBox(width: 4),
                                  Image.asset("assets/images/chevron.down.png",
                                      height: 14, width: 14, color: LsColor.gray)
                                ],
                              ),
                            ))),
                    expanded: Container(
                      decoration: BoxDecoration(
                          color: LsColor.background,
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
                          borderRadius: BorderRadius.circular(14)),
                      child: Column(
                        children: [
                          Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(14),
                              child: ExpandableButton(
                                  theme:
                                  const ExpandableThemeData(useInkWell: false),
                                  child: Container(
                                    padding: const EdgeInsets.all(14),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: LsColor.secondaryDivider))),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                              children: [
                                                Row(
                                                  children: [
                                                    icon(),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                        Utils.replace(
                                                            local
                                                                ?.coursePageModuleIndex,
                                                            [
                                                              "${module.index}"
                                                            ]).toLowerCase(),
                                                        style: TextStyle(
                                                            fontFeatures: const [
                                                              FontFeature.enable("smcp")
                                                            ],
                                                            fontSize: 13,
                                                            fontWeight: FontWeight.w600,
                                                            color: textColor()))
                                                  ],
                                                ),
                                                Text(module.name,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w600,
                                                        color: LsColor.label)),
                                                Text(
                                                    Utils.replace(
                                                        local?.coursePageModulePassed, [
                                                      "${module.lessons.where((element) => element.isPassed).length}",
                                                      "${module.lessons.length}"
                                                    ]),
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: LsColor.secondaryLabel))
                                              ],
                                            )),
                                        const SizedBox(width: 4),
                                        Image.asset("assets/images/chevron.up.png",
                                            height: 14,
                                            width: 14,
                                            color: LsColor.gray)
                                      ],
                                    ),
                                  ))),
                          Column(
                              children: module.lessons
                                  .ascendingBy((e) => e.index)
                                  .map((lesson) => LessonWidget(
                                  lesson, memberCourse, lessonDelegate))
                                  .toList())
                        ],
                      ),
                    )))
          ],
        ));
  }
}
