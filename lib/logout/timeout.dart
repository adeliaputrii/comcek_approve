import 'dart:async';

enum SessionTimeoutState {userTimeout }

class SessionConfig {
  /// Immediately invalidates the sesion after [invalidateSessionForTime] duration of user inactivity
  ///
  /// If null, never invalidates the session for user inactivity
  final DateTime? invalidateSessionForTime;

 
  SessionConfig({
    this.invalidateSessionForTime,
  });

  final _controller = StreamController<SessionTimeoutState>();

  /// Stream yields Map if session is valid, else null
  Stream<SessionTimeoutState> get stream => _controller.stream;

  /// invalidate session and pass [SessionTimeoutState.userTimeout] through stream
  void pushUserTimeout() {
    _controller.sink.add(SessionTimeoutState.userTimeout);
  }

  /// call dispose method to close the stream
  /// usually SessionConfig.stream should keep running until the app is terminated.
  /// But if your usecase requires closing the stream, call the dispose method
  void dispose() {
    _controller.close();
  }
}