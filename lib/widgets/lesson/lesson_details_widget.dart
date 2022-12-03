import 'package:flutter/cupertino.dart';
import 'package:loomus_app/models/program/lesson.dart';
import 'package:loomus_app/utilities/ls_color.dart';
import 'package:loomus_app/widgets/lesson_resource/lesson_resource_widget.dart';

class LessonDetailsWidget extends StatelessWidget {
  final Lesson lesson;
  final List<int> loadingResources;
  final LessonResourceWidgetDelegate resourceDelegate;

  const LessonDetailsWidget(this.lesson, this.loadingResources, this.resourceDelegate, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> columns() {
      List<Widget> result = [
        Text(lesson.name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700))
      ];
      if (lesson.description != null) {
        result.addAll([
          const SizedBox(height: 8),
          Text(lesson.description ?? "", style: const TextStyle(fontSize: 17)),
        ]);
      }

      if (lesson.resources.isNotEmpty) {
        result.addAll([
          const SizedBox(height: 12),
          Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: lesson.resources
                  .map((resource) =>
                      LessonResourceWidget(resource, loadingResources.contains(resource.id), resourceDelegate))
                  .toList())
        ]);
      }

      return result;
    }

    return Container(
      decoration: const BoxDecoration(
          color: LsColor.background,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16))),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: columns(),
      ),
    );
  }
}
