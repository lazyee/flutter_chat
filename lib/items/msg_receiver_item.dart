import 'package:flutter/material.dart';
import 'package:flutter_chat/models/msg_model.dart';
import '../r.dart';

class MsgReceiverItem extends StatefulWidget {
  final MsgModel msg;
  MsgReceiverItem({Key key, this.msg}) : super(key: key);

  @override
  _MsgReceiverItemState createState() => _MsgReceiverItemState();
}

class _MsgReceiverItemState extends State<MsgReceiverItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 10),
        ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              widget.msg.contact.image,
              width: 45,
              height: 45,
            )),
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
            widget.msg.text,
            style: TextStyle(fontSize: 16),
          ),
        )
      ],
    );
  }
}
