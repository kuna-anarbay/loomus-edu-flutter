import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:loomus_app/features/pod_player/src/widgets/core/overlays/mobile_overlay.dart';

import '../../../controllers/pod_getx_video_controller.dart';
import '../../../models/overlay_options.dart';
import '../../pod_progress_bar.dart';

class VideoOverlays extends StatelessWidget {
  final String tag;

  const VideoOverlays({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _podCtr = Get.find<PodGetXVideoController>(tag: tag);
    if (_podCtr.overlayBuilder != null) {
      return GetBuilder<PodGetXVideoController>(
        id: 'update-all',
        tag: tag,
        builder: (_podCtr) {
          ///Custom overlay
          final _progressBar = PodProgressBar(
            tag: tag,
            podProgressBarConfig: _podCtr.podProgressBarConfig,
          );
          final overlayOptions = OverLayOptions(
            podVideoState: _podCtr.podVideoState,
            videoDuration: _podCtr.videoDuration,
            videoPosition: _podCtr.videoPosition,
            isFullScreen: _podCtr.isFullScreen,
            isOverlayVisible: _podCtr.isOverlayVisible,
            isMute: _podCtr.isMute,
            autoPlay: _podCtr.autoPlay,
            currentVideoPlaybackSpeed: _podCtr.currentPaybackSpeed,
            videoPlayBackSpeeds: _podCtr.videoPlaybackSpeeds,
            videoPlayerType: _podCtr.videoPlayerType,
            podProgresssBar: _progressBar,
          );

          /// Returns the custom overlay, otherwise returns the default
          /// overlay with gesture detector
          return _podCtr.overlayBuilder!(overlayOptions);
        },
      );
    } else {
      ///Built in overlay
      return GetBuilder<PodGetXVideoController>(
        tag: tag,
        id: 'overlay',
        builder: (_podCtr) {
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _podCtr.isOverlayVisible ? 1 : 0,
            child: Stack(
              fit: StackFit.passthrough,
              children: [MobileOverlay(tag: tag)],
            ),
          );
        },
      );
    }
  }
}
