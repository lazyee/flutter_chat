import 'package:flutter/material.dart';
import 'package:flutter_chat/tabs/tab_contact_list_page.dart';
import 'package:flutter_chat/tabs/tab_recent_chat_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Chat'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  List<Widget> tabs = [
    ///默认先把第一个加进去
    TabRecentChatListPage(),
    SizedBox(),
  ];

  @override
  void initState() {
    super.initState();
  }

  void showTargetIndex(int index) {
    setState(() {
      currentIndex = index;
      if (tabs[index].runtimeType == SizedBox && index == 1) {
        tabs[index] = TabContactListPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: showTargetIndex,
        currentIndex: currentIndex,
        items: [
          getBottomNavigationBarItem("最近"),
          getBottomNavigationBarItem("通讯录"),
        ],
      ),
    );
  }

  BottomNavigationBarItem getBottomNavigationBarItem(String label) {
    return BottomNavigationBarItem(
        icon: Icon(Icons.ac_unit),
        activeIcon: Icon(Icons.ac_unit_outlined),
        label: label);
  }
}
