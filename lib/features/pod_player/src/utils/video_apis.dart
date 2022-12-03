import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../models/vimeo_models.dart';

String podErrorString(String val) {
  return '*\n------error------\n\n$val\n\n------end------\n*';
}

class VideoApis {
  static Future<List<VideoQualityUrl>?> getYoutubeVideoQualityUrls(
    String youtubeIdOrUrl,
    bool live,
  ) async {
    try {
      final yt = YoutubeExplode();
      final urls = <VideoQualityUrl>[];
      if (live) {
        final url = await yt.videos.streamsClient.getHttpLiveStreamUrl(
          VideoId(youtubeIdOrUrl),
        );
        urls.add(
          VideoQualityUrl(
            quality: 360,
            url: url,
          ),
        );
      } else {
        final manifest =
            await yt.videos.streamsClient.getManifest(youtubeIdOrUrl);
        urls.addAll(
          manifest.muxed.map(
            (element) => VideoQualityUrl(
              quality: int.parse(element.qualityLabel.split('p')[0]),
              url: element.url.toString(),
            ),
          ),
        );
      }
      // Close the YoutubeExplode's http client.
      yt.close();
      return urls;
    } catch (error) {
      if (error.toString().contains('XMLHttpRequest')) {
        log(
          podErrorString(
            '(INFO) To play youtube video in WEB, Please enable CORS in your browser',
          ),
        );
      }
      debugPrint('===== YOUTUBE API ERROR: $error ==========');
      rethrow;
    }
  }
}
