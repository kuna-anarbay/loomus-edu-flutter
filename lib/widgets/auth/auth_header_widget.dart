import 'package:flutter/cupertino.dart';

class AuthHeaderWidget extends StatelessWidget {
  final String? title;
  final String? description;

  const AuthHeaderWidget(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(title ?? "",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        const SizedBox(height: 10),
        Text(description ?? "",
            style: const TextStyle(fontSize: 17), textAlign: TextAlign.center),
      ],
    );
  }
}
