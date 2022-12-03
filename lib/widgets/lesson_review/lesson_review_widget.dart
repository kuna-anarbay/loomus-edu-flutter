import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utilities/ls_color.dart';

mixin LessonReviewWidgetDelegate {
  void rateLesson(int rating);

  void editRating();
}

class LessonReviewItem {
  final int rating;
  final String image;
  final String value;

  LessonReviewItem(this.rating, this.image, this.value);
}

class LessonReviewWidget extends StatelessWidget {
  final int? rating;
  final LessonReviewWidgetDelegate delegate;

  const LessonReviewWidget(this.rating, this.delegate, {super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? local = AppLocalizations.of(context);

    final List<LessonReviewItem> items = [
      LessonReviewItem(2, "assets/images/thumbs-up.png",
          local?.lessonPageReviewPositive ?? ""),
      LessonReviewItem(1, "assets/images/thumbs-down.png",
          local?.lessonPageReviewNegative ?? "")
    ];
    List<Widget> columns() {
      final item =
          items.firstWhereOrNull((element) => element.rating == rating);
      final isReviewed = item != null;

      List<Widget> result = [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
                isReviewed
                    ? local?.lessonPageReviewedTitle ?? ""
                    : local?.lessonPageReviewTitle ?? "",
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Text(
                isReviewed
                    ? local?.lessonPageReviewedSubtitle ?? ""
                    : local?.lessonPageReviewSubtitle ?? "",
                style: const TextStyle(
                    fontSize: 13, color: LsColor.secondaryLabel)),
          ],
        ),
        const SizedBox(height: 16),
      ];

      if (item == null) {
        result.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: items
              .map((item) => GestureDetector(
                    onTap: () => delegate.rateLesson(item.rating),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 42,
                            width: 42,
                            decoration: BoxDecoration(
                                color: item.rating == 2
                                    ? LsColor.green
                                    : LsColor.red,
                                borderRadius: BorderRadius.circular(21)),
                            child: Center(
                              child: Image.asset(item.image,
                                  height: 24, width: 24, color: LsColor.white),
                            )),
                        const SizedBox(height: 8),
                        Text(item.value, style: const TextStyle(fontSize: 15))
                      ],
                    ),
                  ))
              .toList(),
        ));
      } else {
        result.add(Row(
          children: [
            Image.asset(item.image,
                height: 24,
                width: 24,
                color: item.rating == 2 ? LsColor.green : LsColor.red),
            const SizedBox(width: 8),
            Text(item.value, style: const TextStyle(fontSize: 17)),
            const Spacer(),
            GestureDetector(
              onTap: () => delegate.editRating(),
              child: Text(local?.lessonPageReviewEdit ?? "",
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: LsColor.brand)),
            ),
          ],
        ));
      }

      return result;
    }

    return Container(
      decoration: BoxDecoration(
          color: LsColor.background,
          borderRadius: BorderRadius.circular(16),
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: columns(),
      ),
    );
  }
}
