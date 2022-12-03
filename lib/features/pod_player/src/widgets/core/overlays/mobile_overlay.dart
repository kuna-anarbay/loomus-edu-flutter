import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loomus_app/features/pod_player/src/widgets/animated_play_pause_icon.dart';
import 'package:loomus_app/features/pod_player/src/widgets/core/overlays/mobile_bottomsheet.dart';
import 'package:loomus_app/utilities/ls_router.dart';
import 'package:lottie/lottie.dart';

import '../../../controllers/pod_getx_video_controller.dart';
import '../../material_icon_button.dart';
import '../video_gesture_detector.dart';

class MobileOverlay extends StatelessWidget {
  final String tag;

  const MobileOverlay({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const overlayColor = Colors.black38;
    const itemColor = Colors.white;
    final _podCtr = Get.find<PodGetXVideoController>(tag: tag);
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: VideoGestureDetector(
                tag: tag,
                onDoubleTap: _podCtr.onLeftDoubleTap,
                child: ColoredBox(
                  color: overlayColor,
                  child: _LeftRightDoubleTapBox(
                    tag: tag,
                    isLeft: true,
                  ),
                ),
              ),
            ),
            VideoGestureDetector(
              tag: tag,
              child: ColoredBox(
                color: overlayColor,
                child: SizedBox(
                  height: double.infinity,
                  child: Center(
                    child: Row(
                      children: [
                        MaterialIconButton(
                          color: itemColor,
                          onPressed: () {
                            _podCtr.onLeftDoubleTap();
                          },
                          child: const Icon(
                            Icons.keyboard_double_arrow_left,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 24),
                        AnimatedPlayPauseIcon(tag: tag, size: 52),
                        const SizedBox(width: 24),
                        MaterialIconButton(
                          color: itemColor,
                          onPressed: () {
                            _podCtr.onRightDoubleTap();
                          },
                          child: const Icon(
                            Icons.keyboard_double_arrow_right,
                            size: 28,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: VideoGestureDetector(
                tag: tag,
                onDoubleTap: _podCtr.onRightDoubleTap,
                child: ColoredBox(
                  color: overlayColor,
                  child: _LeftRightDoubleTapBox(
                    tag: tag,
                    isLeft: false,
                  ),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: IgnorePointer(
                  child: _podCtr.videoTitle ?? const SizedBox(),
                ),
              ),
              MaterialIconButton(
                color: itemColor,
                onPressed: () {
                  if (_podCtr.isOverlayVisible) {
                    _bottomSheet(context);
                  } else {
                    _podCtr.toggleVideoOverlay();
                  }
                },
                child: const Icon(
                  Icons.more_vert_rounded,
                ),
              ),
              const SizedBox(width: 4),
              MaterialIconButton(
                color: itemColor,
                onPressed: () {
                  if (_podCtr.isFullScreen) {
                    _podCtr.disableFullScreen(context, tag);
                  } else {
                    LsRouter(context).pop();
                  }
                },
                child: const Icon(
                  Icons.close,
                ),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: MobileOverlayBottomController(tag: tag),
        ),
      ],
    );
  }

  void _bottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => MobileBottomSheet(tag: tag),
    );
  }
}

class _LeftRightDoubleTapBox extends StatelessWidget {
  final String tag;
  final bool isLeft;

  const _LeftRightDoubleTapBox({
    Key? key,
    required this.tag,
    required this.isLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PodGetXVideoController>(
      tag: tag,
      id: 'double-tap',
      builder: (podCtr) {
        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            opacity: podCtr.isLeftDbTapIconVisible && isLeft
                ? 1
                : podCtr.isRightDbTapIconVisible && !isLeft
                    ? 1
                    : 0,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Lottie.asset(
                    isLeft
                        ? "assets/lottie/forward_left.json"
                        : "assets/lottie/forward_right.json",
                  ),
                  if (isLeft
                      ? podCtr.isLeftDbTapIconVisible
                      : podCtr.isRightDbTapIconVisible)
                    Transform.translate(
                      offset: const Offset(0, 40),
                      child: Text(
                        '${podCtr.isLeftDbTapIconVisible ? podCtr.leftDoubleTapduration : podCtr.rightDubleTapduration} Sec',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
