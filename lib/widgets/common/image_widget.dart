import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utilities/ls_color.dart';
import '../../utilities/utils.dart';

class ImageWidget extends StatelessWidget {
  final String? path;
  final double? height;
  final double? width;
  final double? borderRadius;
  final BoxFit? fit;

  const ImageWidget(this.path,
      {super.key, this.height, this.width, this.borderRadius, this.fit});

  @override
  Widget build(BuildContext context) {
    final path = this.path;
    if (path != null) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          child: CachedNetworkImage(
              imageUrl: Utils.image(path),
              placeholder: (context, url) => Center(
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: Platform.isIOS
                          ? const CupertinoActivityIndicator(
                              color: LsColor.brand)
                          : const CircularProgressIndicator(
                              color: LsColor.brand),
                    ),
                  ),
              errorWidget: (context, url, error) => Image.asset(
                  "assets/images/placeholder.png",
                  height: height,
                  width: width),
              height: height,
              width: width,
              fit: fit));
    }

    return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        child: Image.asset("assets/images/placeholder.png",
            fit: fit, height: height, width: width));
  }
}
