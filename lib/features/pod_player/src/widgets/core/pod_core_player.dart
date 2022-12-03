import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loomus_app/features/pod_player/pod_player.dart';
import 'package:loomus_app/features/pod_player/src/widgets/core/overlays/overlays.dart';

import '../../controllers/pod_getx_video_controller.dart';

class PodCoreVideoPlayer extends StatelessWidget {
  final VideoPlayerController videoPlayerCtr;
  final double videoAspectRatio;
  final String tag;

  const PodCoreVideoPlayer({
    Key? key,
    required this.videoPlayerCtr,
    required this.videoAspectRatio,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final podCtr = Get.find<PodGetXVideoController>(tag: tag);
    return Builder(
      builder: (ctrx) {
        return RawKeyboardListener(
          autofocus: true,
          focusNode:
              (podCtr.isFullScreen ? FocusNode() : podCtr.keyboardFocusWeb) ??
                  FocusNode(),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: videoAspectRatio,
                  child: VideoPlayer(videoPlayerCtr),
                ),
              ),
              GetBuilder<PodGetXVideoController>(
                tag: tag,
                id: 'podVideoState',
                builder: (_) => GetBuilder<PodGetXVideoController>(
                  tag: tag,
                  id: 'video-progress',
                  builder: (podCtr) {
                    if (podCtr.videoThumbnail == null) {
                      return const SizedBox();
                    }

                    if (podCtr.podVideoState == PodVideoState.paused &&
                        podCtr.videoPosition == Duration.zero) {
                      return SizedBox.expand(
                        child: TweenAnimationBuilder<double>(
                          builder: (context, value, child) => Opacity(
                            opacity: value,
                            child: child,
                          ),
                          tween: Tween<double>(begin: 0.7, end: 1),
                          duration: const Duration(milliseconds: 400),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              image: podCtr.videoThumbnail,
                            ),
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
              VideoOverlays(tag: tag),
              IgnorePointer(
                child: GetBuilder<PodGetXVideoController>(
                  tag: tag,
                  id: 'podVideoState',
                  builder: (podCtr) {
                    final loadingWidget = podCtr.onLoading?.call(context) ??
                        const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.transparent,
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        );

                    if (podCtr.podVideoState == PodVideoState.loading) {
                      return loadingWidget;
                    }
                    return const SizedBox();
                  },
                ),
              ),
              GetBuilder<PodGetXVideoController>(
                tag: tag,
                id: 'full-screen',
                builder: (podCtr) => podCtr.isFullScreen
                    ? const SizedBox()
                    : GetBuilder<PodGetXVideoController>(
                        tag: tag,
                        id: 'overlay',
                        builder: (_podCtr) => _podCtr.isOverlayVisible ||
                                !_podCtr.alwaysShowProgressBar
                            ? const SizedBox()
                            : Align(
                                alignment: Alignment.bottomCenter,
                                child: PodProgressBar(
                                  tag: tag,
                                  alignment: Alignment.bottomCenter,
                                  podProgressBarConfig:
                                      _podCtr.podProgressBarConfig,
                                ),
                              ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
