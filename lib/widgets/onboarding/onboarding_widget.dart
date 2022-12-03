import 'package:flutter/cupertino.dart';

class OnboardingWidget extends StatelessWidget {
  final String image;
  final String? title;
  final String? description;

  OnboardingWidget({super.key,
    required this.image,
    required this.title,
    required this.description
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width,
            child: AspectRatio(aspectRatio: 1,
                child: Image.asset(image)),
          ),
          Text(title ?? "",
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text(description ?? "",
              style: const TextStyle(fontSize: 15),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}