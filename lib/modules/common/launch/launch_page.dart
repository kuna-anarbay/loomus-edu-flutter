import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:loomus_app/utilities/ls_color.dart';

class LaunchPage extends StatelessWidget {
  const LaunchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: const Color(0xFF2B353A),
      body: Center(
        child: Image.asset("assets/images/loomus.png",
            width: 256, color: LsColor.white),
      ),
    );
  }
}
