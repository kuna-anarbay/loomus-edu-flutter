class PodPlayerLabels {
  final String? fullscreen;
  final String? exitFullScreen;
  final String playbackSpeed;
  final String quality;
  final String error;

  /// Labels displayed in the video player progress bar and when an error occurs
  const PodPlayerLabels({
    this.fullscreen,
    this.exitFullScreen,
    this.playbackSpeed = 'Playback speed',
    this.error = 'Error while playing video',
    this.quality = 'Quality'
  });
}
