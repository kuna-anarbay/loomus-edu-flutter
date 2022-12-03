import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loomus_app/models/homework/homework_submission_resource.dart';

import '../../utilities/ls_color.dart';
import '../../utilities/utils.dart';

class HomeworkSubmissionResourceWidget extends StatelessWidget {
  final HomeworkSubmissionResource resource;

  const HomeworkSubmissionResourceWidget(this.resource, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
          ))
        ],
      ),
    );
  }
}
