import 'package:streams_controllers/another_example/contrasts/disposable.dart';
import 'package:streams_controllers/another_example/model/message.dart';
import 'dart:async';

class MessageController implements Disposable {
  // stream consists of 4 maijor things => [stream(container) - streamController(guard)
  // - data(water) - dispose(controllerKiller)].

  List<Message> _messages; // 1 => data

  final StreamController<List<Message>> _messageController =
      StreamController<List<Message>>(); // 2 => streamController
  Stream<List<Message>> get messagesStreaming =>
      _messageController.stream; // to give data from the stream
  StreamSink<List<Message>> get messageSinking =>
      _messageController.sink; // to add or modify data at the stream

  //controller operations....

  final StreamController<Message> _addMessageController =
      StreamController<Message>();
  StreamSink<Message> get addMessageController => _addMessageController.sink;

  final StreamController<Message> _deleteMessageController =
      StreamController<Message>();
  StreamSink<Message> get deleteMessageController =>
      _deleteMessageController.sink;
  // final StreamController<Message> _modifyMessageController =
  //     StreamController<Message>();
  // StreamSink<Message> get modifyMessageController => _modifyMessageController.sink;

  MessageController() {
    _messages = [];
    _messageController
        .add(_messages); // that is stream the controller will controlled.
    _addMessageController.stream.listen(
        (_addMessage)); //make the controller listen to any change at the stream that is relevant to a specific method.
    _deleteMessageController.stream.listen((_deleteMessage));
  }

  void _addMessage(Message message) {
    _messages.add(message);
    _messageController
        .add(_messages); // notify the controller to update the stream state
  }

  void _deleteMessage(Message message) {
    _messages.remove(message);
    _messageController
        .add(_messages); // notify the controller to update the stream state
  }

  // void _modifyMessage(int index){
  //   _messages.elementAt(index);
  // }

  @override
  void dispose() {
    // to avoid memory leak...
    _messageController.close();
    _addMessageController.close();
    _deleteMessageController.close();
  }
}
