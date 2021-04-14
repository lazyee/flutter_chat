import 'package:flutter/material.dart';
import 'package:flutter_chat/models/msg_model.dart';

import '../r.dart';

class MsgSenderItem extends StatefulWidget {
  final MsgModel msg;
  MsgSenderItem({Key key, this.msg}) : super(key: key);

  @override
  _MsgSenderItemState createState() => _MsgSenderItemState();
}

class _MsgSenderItemState extends State<MsgSenderItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
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
          child: SelectableText(
            widget.msg.text,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              R.assetsImgMeinv1,
              width: 45,
              height: 45,
            )),
        SizedBox(width: 10)
      ],
    );
  }
}
