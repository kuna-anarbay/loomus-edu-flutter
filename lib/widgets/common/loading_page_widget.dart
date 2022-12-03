import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utilities/ls_color.dart';

class LoadingPageWidget extends StatelessWidget {
  const LoadingPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? local = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: Platform.isIOS
                  ? const CupertinoActivityIndicator(color: LsColor.brand)
                  : const CircularProgressIndicator(color: LsColor.brand),
            ),
            const SizedBox(height: 12),
            Text(local?.loadingWidgetTitle ?? "",
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: LsColor.label))
          ],
        ),
      ),
    );
  }
}
