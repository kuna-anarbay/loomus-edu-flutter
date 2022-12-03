import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loomus_app/models/program/lesson_resource.dart';

import '../../utilities/ls_color.dart';
import '../../utilities/utils.dart';

mixin LessonResourceWidgetDelegate {
  void downloadLessonResource(LessonResource resource);
}

class LessonResourceWidget extends StatelessWidget {
  final LessonResource resource;
  final bool isLoading;
  final LessonResourceWidgetDelegate delegate;

  const LessonResourceWidget(this.resource, this.isLoading, this.delegate,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => delegate.downloadLessonResource(resource),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Utils.getFilePath(resource.name),
                fit: BoxFit.cover, height: 32, width: 24),
            const SizedBox(width: 8),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(resource.name,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                            color: LsColor.label)),
                    const SizedBox(height: 2),
                    Text(Utils.fileSize(resource.size),
                        style: const TextStyle(
                            fontSize: 12, color: LsColor.secondaryLabel))
                  ],
                )),
            Visibility(
                visible: isLoading,
                child: Platform.isIOS
                    ? const CupertinoActivityIndicator(color: LsColor.brand)
                    : const  CircularProgressIndicator(
                    color: LsColor.brand, strokeWidth: 3))
          ],
        ),
      ),
    );
  }
}
