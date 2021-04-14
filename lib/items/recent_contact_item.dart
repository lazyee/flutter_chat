import 'package:flutter/material.dart';
import 'package:flutter_chat/models/contact_model.dart';
import 'package:flutter_chat/pages/chat/chat_page.dart';

class RecentContactItem extends StatefulWidget {
  final ContactModel contact;
  RecentContactItem({Key key, @required this.contact}) : super(key: key);

  @override
  _RecentContactItemState createState() => _RecentContactItemState();
}

class _RecentContactItemState extends State<RecentContactItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatPage(
                  contact: widget.contact,
                )));
      },
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(5.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        widget.contact.image,
                        width: 50,
                        height: 50,
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.contact.name,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(widget.contact.lastMessage ?? "")
                    ],
                  ),
                ],
              )),
          Divider(height: 1)
        ],
      ),
    );
  }
}
