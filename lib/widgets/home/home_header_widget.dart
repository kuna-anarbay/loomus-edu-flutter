import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../utilities/ls_color.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: LsColor.background,
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(37, 37, 37, 0.02),
                spreadRadius: 0,
                blurRadius: 4,
                offset: Offset(0, 2))
          ],
          border: Border(bottom: BorderSide(color: LsColor.lightDivider))),
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RichText(
                  text: const TextSpan(
                      text: "Привет, ",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: LsColor.label),
                      children: [
                    TextSpan(
                        text: "Мика",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: LsColor.brand))
                  ])),
              const SizedBox(height: 2),
              Text("День обещает быть увлекательным ✌️",
                  style: const TextStyle(
                      fontSize: 15, color: LsColor.secondaryLabel))
            ],
          )),
    );
  }
}
