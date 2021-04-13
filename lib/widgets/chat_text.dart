import 'package:flutter/material.dart';

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
      // style: widget.style,
      // enableInteractiveSelection: true,
      // shouldShowSelectionToolbar: false,
      // onTap: () => {print("触发点击事件")},
      // onLongTap: () => {print("触发长按事件")},
      // onDoubleTap: () => {print("触发双击事件")},
    );
  }
}
