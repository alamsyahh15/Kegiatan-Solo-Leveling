import 'dart:async';

StreamSubscription mainStreamChat;
Stream<Map<String, dynamic>> subsStreamChat;

abstract class ChatRealtimeService {
  StreamController<Map<String, dynamic>> _streamChatController =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream get chatServiceStram => _streamChatController.stream;

  void addNewMessage(Map<String, dynamic> payload) {
    _streamChatController.add(payload);
    subsStreamChat = _streamChatController.stream;
  }

  void onListenNewMessage(Function(Map<String, dynamic> payload) onEvent) {
    mainStreamChat = subsStreamChat?.listen((event) {
      onEvent(event);
    });
  }

  void disposeStream() {
    mainStreamChat?.cancel();
  }
}
