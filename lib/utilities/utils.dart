import 'dart:math';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:loomus_app/utilities/constants.dart';

class Utils {
  static int seconds(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch ~/ 1000;
  }

  static String image(String path) {
    return Constants.mediaBaseUrl + path;
  }

  static String replace(String? value, List<String> args) {
    String result = value ?? "";
    for (var element in args) {
      result = result.replaceFirst("%@", element);
    }

    return result;
  }

  static String fileSize(int size) {
    if (size == 0) return "0 B";

    const k = 1024;
    const sizes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    final i = (log(size) / log(k)).floor();

    return "${(size / pow(k, i)).toStringAsFixed(2)} ${sizes[i]}";
  }

  static String date(int? seconds, [String format = "dd.MM.yyyy, HH:mm"]) {
    if (seconds == null) return "";
    final dateTime = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
    return DateFormat(format).format(dateTime);
  }

  static String getFilePath(String path) {
    final component = path.toLowerCase().split("?").first;
    if (component.toLowerCase().endsWith("doc") ||
        component.toLowerCase().endsWith("docx")) {
      return "assets/images/file.doc.png";
    }
    if (component.toLowerCase().endsWith("pdf")) {
      return "assets/images/file.pdf.png";
    }
    if (component.toLowerCase().endsWith("ppt") ||
        component.toLowerCase().endsWith("pptx")) {
      return "assets/images/file.presentation.png";
    }
    if (component.toLowerCase().endsWith("xls") ||
        component.toLowerCase().endsWith("xlsx")) {
      return "assets/images/file.sheets.png";
    }
    if (component.toLowerCase().endsWith("zip")) {
      return "assets/images/file.zip.png";
    }
    const imageFileExtensions = ["jpeg", "jpg", "png", "gif"];
    const videoFileExtensions = [
      "mp4", // MP4, Apple
      "mov", // MOV, Apple
      "wmv", // WMV, Microsoft
      "flv", // FLV, Adobe
      "avi", // AVI, Microsoft
      "webm", // WebM, Google
      "mkv" // MKV, Matroska
    ];
    final filenameComponents = component.split(".");
    if (filenameComponents.isNotEmpty &&
        imageFileExtensions
            .contains(filenameComponents[filenameComponents.length - 1])) {
      return "assets/images/file.image.png";
    }
    if (component.toLowerCase().endsWith("webp")) {
      return "assets/images/file.image.png";
    }

    if (filenameComponents.isNotEmpty &&
        videoFileExtensions
            .contains(filenameComponents[filenameComponents.length - 1])) {
      return "assets/images/file.video.png";
    }

    return "assets/images/file.unknown.png";
  }
}
