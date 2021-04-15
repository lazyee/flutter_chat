import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../r.dart';

typedef SubmitChatMsgCallback = void Function(String text);

class ChatInputBar extends StatefulWidget {
  final VoidCallback onShowKeyboard;
  final VoidCallback onDismissKeyboard;
  final SubmitChatMsgCallback onSubmitChatMsg;

  ChatInputBar({
    Key key,
    this.onShowKeyboard,
    this.onDismissKeyboard,
    this.onSubmitChatMsg,
  }) : super(key: key);

  @override
  ChatInputBarState createState() => ChatInputBarState();
}

class ChatInputBarState extends State<ChatInputBar>
    with WidgetsBindingObserver {
  bool isKeyboardActived = false;
  TextEditingController _textEditController = TextEditingController();
  FocusNode chatTextFieldFocusNode = FocusNode();

  void dismissKeyboard() {
    chatTextFieldFocusNode.unfocus();
  }

  bool isShowKeyboard() {
    return chatTextFieldFocusNode.hasFocus;
  }

  @override
  void initState() {
    _textEditController.addListener(() {});

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // print("bottom:${MediaQuery.of(context).viewInsets.bottom}");
      print("addPostFrameCallback:${chatTextFieldFocusNode.hasFocus}");
      // isKeyboardActived = !isKeyboardActived;
      if (isKeyboardActived && !chatTextFieldFocusNode.hasFocus) {
        if (widget.onDismissKeyboard != null) {
          widget.onDismissKeyboard();
          isKeyboardActived = false;
        }
      } else {
        if (widget.onShowKeyboard != null) {
          widget.onShowKeyboard();
          isKeyboardActived = true;
        }
      }
    });
  }

  void onSubmitted(String value) {
    if (value.isEmpty) return;
    _textEditController.clear();
    if (widget.onSubmitChatMsg != null) {
      widget.onSubmitChatMsg(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.fromLTRB(left, top, right, bottom),

      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Color(0x9000000), offset: Offset(0, -2))
      ]),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      constraints: BoxConstraints(minHeight: 50, maxHeight: 200),
      child: Row(
        children: [
          InkWell(
            child: Image.asset(
              R.assetsImgIcChatVoice,
              width: 28,
              height: 28,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
              child: Container(
            constraints: BoxConstraints(minHeight: 32, maxHeight: 138),
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: TextField(
              controller: _textEditController,
              focusNode: chatTextFieldFocusNode,
              style: TextStyle(),
              // onSubmitted: onSubmitted,
              onEditingComplete: () => onSubmitted(_textEditController.text),
              textInputAction: Platform.isIOS
                  ? TextInputAction.send
                  : TextInputAction.newline,
              //将maxLines设置为null和keyboardType设置为TextInputType.multiline可以动态调节高度
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration.collapsed(hintText: "请输入内容"),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xFFF6F8F9),
            ),
          )),
          SizedBox(width: 10),
          InkWell(
              child: Image.asset(
            R.assetsImgIcChatEmoji,
            width: 28,
            height: 28,
          )),
          SizedBox(width: 10),
          Stack(
            children: [
              InkWell(
                child: Image.asset(
                  R.assetsImgIcChatAdd,
                  width: 28,
                  height: 28,
                ),
              ),
              if (Platform.isAndroid && _textEditController.text.isNotEmpty)
                InkWell(child: Text("发送")),
            ],
          )
        ],
      ),
    );
  }
}
