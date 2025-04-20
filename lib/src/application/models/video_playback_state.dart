sealed class VideoPlaybackState {
  const VideoPlaybackState();
}

class Idle extends VideoPlaybackState {
  const Idle();
}

class Loading extends VideoPlaybackState {
  const Loading();
}

class Buffering extends VideoPlaybackState {
  const Buffering();
}

class Playing extends VideoPlaybackState {
  const Playing();
}

class Paused extends VideoPlaybackState {
  const Paused();
}

class ErrorState extends VideoPlaybackState {
  final String message;
  const ErrorState(this.message);
}
