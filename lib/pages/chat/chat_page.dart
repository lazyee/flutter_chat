import 'package:flutter/material.dart';
import 'package:flutter_chat/items/msg_receiver_item.dart';
import 'package:flutter_chat/items/msg_sender_item.dart';
import 'package:flutter_chat/models/contact_model.dart';
import 'package:flutter_chat/models/msg_model.dart';
import 'package:flutter_chat/r.dart';
import 'package:flutter_chat/widgets/chat_input_bar.dart';

class ChatPage extends StatefulWidget {
  final ContactModel contact;
  ChatPage({Key key, this.contact}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ScrollController _scrollController;
  List<MsgModel> msgList = [];
  ContactModel user;
  @override
  void initState() {
    user = ContactModel();
    user.image = R.assetsImgMeinv1;

    _scrollController = ScrollController();

    for (var i = 0; i < 10; i++) {
      var isSender = i % 2 == 0;
      msgList.add(MsgModel.text("这个是正文这个是正文这个😯😯😯😯😯😯",
          isSender ? user : widget.contact, isSender));
    }
    super.initState();

    chatListScrollToEnd();
  }

  void chatListScrollToEnd({int delayMilliseconds = 0}) {
    Future.delayed(Duration(milliseconds: delayMilliseconds), () {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("聊天界面")),
      backgroundColor: Colors.white,
      body: Column(children: [
        Expanded(
            child: ListView.builder(
          controller: _scrollController,
          itemBuilder: (context, index) => msgList[index].isSender
              ? MsgSenderItem(msg: msgList[index])
              : MsgReceiverItem(msg: msgList[index]),
          itemCount: msgList.length,
        )),
        ChatInputBar(
          onSubmitChatMsg: (text) {
            setState(() {
              msgList.add(MsgModel.text(text, user, true));
            });
            //必须延迟一下,否则无法滑动到底部
            chatListScrollToEnd(delayMilliseconds: 50);
          },
          onShowKeyboard: () {
            chatListScrollToEnd();
          },
        )
      ]),
    );
  }
}
