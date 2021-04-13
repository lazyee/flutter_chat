import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/chat_text.dart';

import '../r.dart';

class MsgSenderItem extends StatefulWidget {
  MsgSenderItem({Key key}) : super(key: key);

  @override
  _MsgSenderItemState createState() => _MsgSenderItemState();
}

class _MsgSenderItemState extends State<MsgSenderItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.fromLTRB(10, 10, 15, 10),
          constraints: BoxConstraints(
              minWidth: 10,
              maxWidth: MediaQuery.of(context).size.width * 0.6,
              minHeight: 20,
              maxHeight: double.infinity),
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(R.assetsImgIcChatSender),
                  centerSlice: Rect.fromLTRB(9, 5, 10, 12))),
          child: ChatText(
            "这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文;,,,!!!",
            style: TextStyle(fontSize: 16),
          ),
        )
      ],
    );
  }
}
