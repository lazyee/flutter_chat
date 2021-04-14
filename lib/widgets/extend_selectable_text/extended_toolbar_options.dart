import 'package:flutter/material.dart';

/// Toolbar configuration for [EditableText].
///
/// Toolbar is a context menu that will show up when user right click or long
/// press the [EditableText]. It includes several options: cut, copy, paste,
/// and select all.
///
/// [EditableText] and its derived widgets have their own default [ToolbarOptions].
/// Create a custom [ToolbarOptions] if you want explicit control over the toolbar
/// option.
class ExtendedToolbarOption {
  ExtendedToolbarOption({
    this.label = "",
    this.onPress,
    // this.cut = false,
    // this.paste = false,
    // this.selectAll = false,
  });
  // final copy;
  final String label;
  VoidCallback onPress;
}

//复制选项
class ExtendedToolbarCopyOption extends ExtendedToolbarOption {
  ExtendedToolbarCopyOption({this.label}) : super(label: label);
  final String label;
}

final defaultToolbarOptions = [ExtendedToolbarCopyOption()];
