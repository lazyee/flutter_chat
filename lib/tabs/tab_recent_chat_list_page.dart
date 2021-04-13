import 'package:flutter/material.dart';
import 'package:flutter_chat/items/recent_contact_item.dart';
import 'package:flutter_chat/models/contact_model.dart';

///最近联系人
class TabRecentChatListPage extends StatefulWidget {
  TabRecentChatListPage({Key key}) : super(key: key);

  @override
  _TabRecentChatListPageState createState() => _TabRecentChatListPageState();
}

class _TabRecentChatListPageState extends State<TabRecentChatListPage> {
  List<ContactModel> recentContactList = List<ContactModel>();
  @override
  void initState() {
    for (var i = 1; i <= 6; i++) {
      ContactModel contact = ContactModel();
      contact.id = i.toString();
      contact.image = "assets/img/meinv_$i.jpg";
      contact.name = "美女$i";
      contact.lastMessage = "最后的消息:$i";
      recentContactList.add(contact);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => RecentContactItem(
        contact: recentContactList[index],
      ),
      itemCount: recentContactList.length,
    );
  }
}
