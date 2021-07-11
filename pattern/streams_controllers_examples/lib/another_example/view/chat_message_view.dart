import 'package:flutter/material.dart';
import 'package:streams_controllers/another_example/controller/message_controller.dart';
import 'package:streams_controllers/another_example/model/message.dart';

class ChatMessageView extends StatefulWidget {
  @override
  _ChatMessageViewState createState() => _ChatMessageViewState();
}

class _ChatMessageViewState extends State<ChatMessageView> {
  MessageController _messageController;

  @override
  void initState() {
    super.initState();
    _messageController = MessageController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            StreamBuilder(
              stream: _messageController.messagesStreaming,
              builder: (ctx, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error'),
                  );
                } else if (!snapshot.hasData) {
                  return Center(
                    child: Text('There is no data at this moment!'),
                  );
                } else {
                  List<Message> _messages = snapshot.data;
                  return Flexible(
                    child: ListView.builder(
                      itemCount: _messages.length,
                      itemBuilder: (ctx, indx) {
                        return ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          onTap: () {
                            _messageController.deleteMessageController
                                .add(_messages[indx]);
                          },
                          leading: CircleAvatar(
                            backgroundColor: _messages[indx].photoColor,
                            radius: 30,
                          ),
                          title:
                              Text('messageFrom:<${_messages[indx].sender}>'),
                          subtitle: Text(
                              'messageContent: <${_messages[indx].messageContent}>'),
                        );
                      },
                    ),
                  );
                }
              },
            ),
            Container(
              margin: const EdgeInsets.all(15),
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(Icons.add),
                onPressed: () {
                  _messageController.addMessageController.add(
                    Message(
                        sender: 'Hossam',
                        photoColor: Colors.teal,
                        messageContent: 'Hello bro. How are u?'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
