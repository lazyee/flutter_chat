import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/chat_text.dart';

import '../r.dart';

class MsgReceiverItem extends StatefulWidget {
  MsgReceiverItem({Key key}) : super(key: key);

  @override
  _MsgReceiverItemState createState() => _MsgReceiverItemState();
}

class _MsgReceiverItemState extends State<MsgReceiverItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.fromLTRB(17, 10, 10, 10),
          constraints: BoxConstraints(
              minWidth: 10,
              maxWidth: MediaQuery.of(context).size.width * 0.6,
              minHeight: 20,
              maxHeight: double.infinity),
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(R.assetsImgIcChatReceiver),
                  centerSlice: Rect.fromLTRB(15, 10, 16, 11))),
          child: SelectableText(
            "这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文",
            style: TextStyle(fontSize: 16),
          ),
        )
      ],
    );
  }
}
