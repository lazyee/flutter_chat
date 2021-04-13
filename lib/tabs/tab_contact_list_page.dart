import 'package:flutter/material.dart';
import 'package:flutter_chat/items/recent_contact_item.dart';
import 'package:flutter_chat/models/contact_model.dart';

import '../r.dart';

class TabContactListPage extends StatefulWidget {
  TabContactListPage({Key key}) : super(key: key);

  @override
  _TabContactListPageState createState() => _TabContactListPageState();
}

class _TabContactListPageState extends State<TabContactListPage> {
  List<ContactModel> recentContactList = List<ContactModel>();
  @override
  void initState() {
    for (var i = 1; i <= 6; i++) {
      ContactModel contact = ContactModel();
      contact.id = i.toString();
      contact.image = "assets/img/meinv_$i.jpg";
      contact.name = "美女$i";
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
