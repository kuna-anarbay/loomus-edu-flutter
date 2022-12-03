import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../utilities/ls_color.dart';

class CourseHeaderWidget extends StatelessWidget {
  const CourseHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: LsColor.background,
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(37, 37, 37, 0.02),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0, 2))
            ],
            borderRadius: BorderRadius.circular(14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                color: LsColor.background,
                height: MediaQuery.of(context).padding.top),
            AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                    "assets/images/user.placeholder.png",
                    fit: BoxFit.cover)),
            Container(
                color: LsColor.background,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.stretch,
                  children: [
                    Text("Интернет-маркетинг от Поток",
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(height: 2),
                    RichText(
                        text: const TextSpan(
                            text: "from ",
                            style: TextStyle(
                                fontSize: 15,
                                color: LsColor.secondaryLabel),
                            children: [
                              TextSpan(
                                  text: "Аяна Султан",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: LsColor.brand))
                            ])),
                    const SizedBox(height: 12),
                    const ClipRRect(
                        borderRadius: BorderRadius.all(
                            Radius.circular(10)),
                        child: LinearProgressIndicator(
                            value: 0.25,
                            color: LsColor.brand,
                            backgroundColor:
                            LsColor.secondaryBackground)),
                    const SizedBox(height: 4),
                    Text("Вы прошли курс на 25% ",
                        style: const TextStyle(
                            fontSize: 12,
                            color: LsColor.secondaryLabel)),
                    const SizedBox(height: 12),
                    Container(
                        color: LsColor.secondaryDivider,
                        height: 1),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                                "Подробнее о курсе ",
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: LsColor.brand))),
                        Icon(
                            PlatformIcons(context).rightChevron,
                            size: 20,
                            color: LsColor.brand)
                      ],
                    )
                  ],
                ))
          ],
        ));
  }

}