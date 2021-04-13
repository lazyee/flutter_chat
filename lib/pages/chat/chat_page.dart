import 'package:flutter/material.dart';
import 'package:flutter_chat/items/msg_receiver_item.dart';
import 'package:flutter_chat/items/msg_sender_item.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("聊天界面")),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemBuilder: (context, index) =>
            index % 2 == 0 ? MsgSenderItem() : MsgReceiverItem(),
        itemCount: 10,
      ),
    );
  }
}
