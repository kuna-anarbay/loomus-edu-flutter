import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../controllers/pod_getx_video_controller.dart';
import '../../material_icon_button.dart';
import '../../pod_progress_bar.dart';

class MobileBottomSheet extends StatelessWidget {
  final String tag;

  const MobileBottomSheet({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PodGetXVideoController>(
      tag: tag,
      builder: (_podCtr) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_podCtr.vimeoOrVideoUrls.isNotEmpty)
              _bottomSheetTiles(
                title: _podCtr.podPlayerLabels.quality,
                icon: Icons.video_settings_rounded,
                subText: '${_podCtr.vimeoPlayingVideoQuality}p',
                onTap: () {
                  Navigator.of(context).pop();
                  Timer(const Duration(milliseconds: 100), () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => _VideoQualitySelectorMob(
                        tag: tag,
                        onTap: null,
                      ),
                    );
                  });
                  // await Future.delayed(
                  //   const Duration(milliseconds: 100),
                  // );
                },
              ),
            _bottomSheetTiles(
              title: _podCtr.podPlayerLabels.playbackSpeed,
              icon: Icons.slow_motion_video_rounded,
              subText: _podCtr.currentPaybackSpeed,
              onTap: () {
                Navigator.of(context).pop();
                Timer(const Duration(milliseconds: 100), () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => _VideoPlaybackSelectorMob(
                      tag: tag,
                      onTap: null,
                    ),
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  ListTile _bottomSheetTiles({
    required String title,
    required IconData icon,
    String? subText,
    void Function()? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      onTap: onTap,
      title: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Text(
              title,
            ),
            if (subText != null) const SizedBox(width: 6),
            if (subText != null)
              const SizedBox(
                height: 4,
                width: 4,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            if (subText != null) const SizedBox(width: 6),
            if (subText != null)
              Text(
                subText,
                style: const TextStyle(color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}

class _VideoQualitySelectorMob extends StatelessWidget {
  final void Function()? onTap;
  final String tag;

  const _VideoQualitySelectorMob({
    Key? key,
    required this.onTap,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _podCtr = Get.find<PodGetXVideoController>(tag: tag);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _podCtr.vimeoOrVideoUrls
              .map(
                (e) => ListTile(
                  title: Text('${e.quality}p'),
                  onTap: () {
                    onTap != null ? onTap!() : Navigator.of(context).pop();

                    _podCtr.changeVideoQuality(e.quality);
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _VideoPlaybackSelectorMob extends StatelessWidget {
  final void Function()? onTap;
  final String tag;

  const _VideoPlaybackSelectorMob({
    Key? key,
    required this.onTap,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _podCtr = Get.find<PodGetXVideoController>(tag: tag);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _podCtr.videoPlaybackSpeeds
              .map(
                (e) => ListTile(
                  title: Text(e),
                  onTap: () {
                    onTap != null ? onTap!() : Navigator.of(context).pop();
                    _podCtr.setVideoPlayBack(e);
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class MobileOverlayBottomController extends StatelessWidget {
  final String tag;

  const MobileOverlayBottomController({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const durationTextStyle = TextStyle(color: Colors.white70, fontSize: 13);
    const itemColor = Colors.white;

    return GetBuilder<PodGetXVideoController>(
      tag: tag,
      id: 'full-screen',
      builder: (_podCtr) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 16),
              GetBuilder<PodGetXVideoController>(
                tag: tag,
                id: 'video-progress',
                builder: (_podCtr) {
                  return Row(
                    children: [
                      Text(
                        _podCtr.calculateVideoDuration(_podCtr.videoPosition),
                        style: const TextStyle(color: itemColor, fontSize: 13),
                      ),
                      const Text(
                        ' / ',
                        style: durationTextStyle,
                      ),
                      Text(
                        _podCtr.calculateVideoDuration(_podCtr.videoDuration),
                        style: durationTextStyle,
                      ),
                    ],
                  );
                },
              ),
              const Spacer(),
              MaterialIconButton(
                color: itemColor,
                onPressed: () {
                  if (_podCtr.isOverlayVisible) {
                    if (_podCtr.isFullScreen) {
                      _podCtr.disableFullScreen(context, tag);
                    } else {
                      _podCtr.enableFullScreen(tag);
                    }
                  } else {
                    _podCtr.toggleVideoOverlay();
                  }
                },
                child: Icon(
                  _podCtr.isFullScreen
                      ? Icons.fullscreen_exit
                      : Icons.fullscreen,
                ),
              ),
            ],
          ),
          GetBuilder<PodGetXVideoController>(
            tag: tag,
            id: 'overlay',
            builder: (_podCtr) {
              if (_podCtr.isFullScreen) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                      16, 0, 16, MediaQuery.of(context).padding.bottom + 20),
                  child: Visibility(
                    visible: _podCtr.isOverlayVisible,
                    child: PodProgressBar(
                      tag: tag,
                      alignment: Alignment.topCenter,
                      podProgressBarConfig: _podCtr.podProgressBarConfig,
                    ),
                  ),
                );
              }
              return PodProgressBar(
                tag: tag,
                alignment: Alignment.bottomCenter,
                podProgressBarConfig: _podCtr.podProgressBarConfig,
              );
            },
          ),
        ],
      ),
    );
  }
}
