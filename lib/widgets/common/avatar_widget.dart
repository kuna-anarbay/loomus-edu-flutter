import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loomus_app/utilities/ls_color.dart';

import '../../utilities/utils.dart';

class AvatarWidget extends StatelessWidget {
  final String? path;
  final double size;

  const AvatarWidget(this.path, this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    final path = this.path;
    if (path != null) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(size / 2),
          child: CachedNetworkImage(
            imageUrl: Utils.image(path),
            placeholder: (context, url) => Center(
              child: SizedBox(
                height: 24,
                width: 24,
                child: Platform.isIOS
                    ? const CupertinoActivityIndicator(color: LsColor.brand)
                    : const CircularProgressIndicator(color: LsColor.brand),
              ),
            ),
            errorWidget: (context, url, error) => Image.asset(
                "assets/images/user.placeholder.png",
                height: size,
                width: size),
            height: size,
            width: size,
            fit: BoxFit.cover,
          ));
    }

    return ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: Image.asset("assets/images/user.placeholder.png",
            height: size, width: size));
  }
}
