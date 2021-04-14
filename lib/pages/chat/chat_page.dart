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
  GlobalKey<ChatInputBarState> chatInputBarStateKey =
      GlobalKey<ChatInputBarState>();
  @override
  void initState() {
    user = ContactModel();
    user.image = R.assetsImgMeinv1;
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (isPanDown) {
        chatInputBarStateKey.currentState.dismissKeyboard();
        chatListScrollToEnd();
        isPanDown = false;
      }
    });

    for (var i = 0; i < 10; i++) {
      var isSender = i % 2 == 0;
      msgList.add(MsgModel.text("这个是正文这个是正文这个😯😯😯😯😯😯",
          isSender ? user : widget.contact, isSender));
    }
    super.initState();

    chatListScrollToEnd();
  }

  void chatListScrollToEnd(
      {Duration delayDuration = const Duration(seconds: 0),
      bool animation = false,
      Duration animDuration}) {
    Future.delayed(delayDuration, () {
      if (animation) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: animDuration, curve: Curves.linear);
      } else {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  bool isPanDown = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("聊天界面")),
      backgroundColor: Colors.white,
      body: Column(children: [
        Expanded(
            child: GestureDetector(
                onPanDown: (details) => isPanDown = true,
                child: ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (context, index) => msgList[index].isSender
                      ? MsgSenderItem(msg: msgList[index])
                      : MsgReceiverItem(msg: msgList[index]),
                  itemCount: msgList.length,
                ))),
        ChatInputBar(
          key: chatInputBarStateKey,
          onSubmitChatMsg: (text) {
            setState(() {
              msgList.add(MsgModel.text(text, user, true));
            });
            //必须延迟一下,否则无法滑动到底部
            chatListScrollToEnd(
                delayDuration: Duration(milliseconds: 50),
                animation: true,
                animDuration: Duration(milliseconds: 200));
          },
          onShowKeyboard: () {
            chatListScrollToEnd();
          },
        )
      ]),
    );
  }
}
