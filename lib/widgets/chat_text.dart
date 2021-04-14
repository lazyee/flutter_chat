import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/extend_selectable_text/extended_toolbar_options.dart';

import 'extend_selectable_text/extended_selectable_text.dart';

class ChatText extends StatefulWidget {
  final String text;
  final TextStyle style;
  ChatText(this.text, {Key key, this.style}) : super(key: key);

  @override
  _ChatTextState createState() => _ChatTextState();
}

class _ChatTextState extends State<ChatText> {
  @override
  Widget build(BuildContext context) {
    return ExtendedSelectableText(
      widget.text,
      toolbarOptions: [
        ExtendedToolbarCopyOption(label: "复制"),
        ExtendedToolbarOption(label: "复制1", onPress: () {}),
        ExtendedToolbarOption(label: "复制2", onPress: () {}),
        ExtendedToolbarOption(label: "复制3", onPress: () {})
      ],
    );
  }
}
