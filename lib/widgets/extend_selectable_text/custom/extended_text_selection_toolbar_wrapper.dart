import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/extend_selectable_text/constant/constant.dart';
import 'package:flutter_chat/widgets/extend_selectable_text/extended_toolbar_options.dart';

import '../extended_text_selection.dart';
import 'extended_text_selection_toolbar.dart';
import 'extended_text_selection_toolbar_content.dart';

class ExtendedTextSelectionToolbarWrapper extends StatefulWidget {
  final double arrowTipX;
  final double barTopY;
  final ExtendedClipboardStatusNotifier clipboardStatus;
  // final VoidCallback handleCopy;
  final List<ExtendedToolbarOption> toolbarOptions;
  final bool isArrowPointingDown;

  ExtendedTextSelectionToolbarWrapper({
    Key key,
    this.arrowTipX,
    this.barTopY,
    this.clipboardStatus,
    // this.handleCopy,
    this.toolbarOptions,
    this.isArrowPointingDown,
  }) : super(key: key);

  @override
  _ExtendedTextSelectionToolbarWrapperState createState() =>
      _ExtendedTextSelectionToolbarWrapperState();
}

class _ExtendedTextSelectionToolbarWrapperState
    extends State<ExtendedTextSelectionToolbarWrapper> {
  ExtendedClipboardStatusNotifier _clipboardStatus;

  void _onChangedClipboardStatus() {
    setState(() {
      // Inform the widget that the value of clipboardStatus has changed.
    });
  }

  @override
  void initState() {
    super.initState();
    _clipboardStatus = widget.clipboardStatus ?? ClipboardStatusNotifier();
    _clipboardStatus.addListener(_onChangedClipboardStatus);
    _clipboardStatus.update();
  }

  @override
  void didUpdateWidget(ExtendedTextSelectionToolbarWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.clipboardStatus == null && widget.clipboardStatus != null) {
      _clipboardStatus.removeListener(_onChangedClipboardStatus);
      _clipboardStatus.dispose();
      _clipboardStatus = widget.clipboardStatus;
    } else if (oldWidget.clipboardStatus != null) {
      if (widget.clipboardStatus == null) {
        _clipboardStatus = ExtendedClipboardStatusNotifier();
        _clipboardStatus.addListener(_onChangedClipboardStatus);
        oldWidget.clipboardStatus.removeListener(_onChangedClipboardStatus);
      } else if (widget.clipboardStatus != oldWidget.clipboardStatus) {
        _clipboardStatus = widget.clipboardStatus;
        _clipboardStatus.addListener(_onChangedClipboardStatus);
        oldWidget.clipboardStatus.removeListener(_onChangedClipboardStatus);
      }
    }
    // if (widget.handlePaste != null) {
    //   _clipboardStatus.update();
    // }
  }

  @override
  void dispose() {
    super.dispose();
    // When used in an Overlay, this can be disposed after its creator has
    // already disposed _clipboardStatus.
    if (!_clipboardStatus.disposed) {
      _clipboardStatus.removeListener(_onChangedClipboardStatus);
      if (widget.clipboardStatus == null) {
        _clipboardStatus.dispose();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = <Widget>[];
    final CupertinoLocalizations localizations =
        CupertinoLocalizations.of(context);
    final EdgeInsets arrowPadding = widget.isArrowPointingDown
        ? EdgeInsets.only(bottom: kDefaultToolbarArrowSize.height)
        : EdgeInsets.only(top: kDefaultToolbarArrowSize.height);
    final Widget onePhysicalPixelVerticalDivider =
        SizedBox(width: 1.0 / MediaQuery.of(context).devicePixelRatio);

    void addToolbarButton(
      String text,
      VoidCallback onPressed,
    ) {
      if (items.isNotEmpty) {
        items.add(onePhysicalPixelVerticalDivider);
      }

      items.add(CupertinoButton(
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: kDefaultToolbarButtonFontStyle,
        ),
        borderRadius: null,
        color: kDefaultToolbarBackgroundColor,
        minSize: kToolbarHeight,
        onPressed: onPressed,
        padding: kDefaultToolbarButtonPadding.add(arrowPadding),
        pressedOpacity: 0.7,
      ));
    }

    //根据配置加载功能item
    if (widget.toolbarOptions != null && widget.toolbarOptions.isNotEmpty) {
      widget.toolbarOptions.forEach((element) {
        if (element.runtimeType == ExtendedToolbarCopyOption) {
          addToolbarButton(
              element.label ?? localizations.copyButtonLabel, element.onPress);
        } else {
          addToolbarButton(element.label, element.onPress);
        }
      });
    }
    // if (widget.handleCut != null) {
    //   addToolbarButton(localizations.cutButtonLabel, widget.handleCut);
    // }
    // if (widget.handleCopy != null) {
    //   addToolbarButton(localizations.copyButtonLabel, widget.handleCopy);
    // }
    // if (widget.handlePaste != null &&
    //     _clipboardStatus.value == ClipboardStatus.pasteable) {
    //   addToolbarButton(localizations.pasteButtonLabel, widget.handlePaste);
    // }
    // if (widget.handleSelectAll != null) {
    //   addToolbarButton(
    //       localizations.selectAllButtonLabel, widget.handleSelectAll);
    // }

    return ExtendedTextSelectionToolbar(
      barTopY: widget.barTopY,
      arrowTipX: widget.arrowTipX,
      isArrowPointingDown: widget.isArrowPointingDown,
      child: items.isEmpty
          ? null
          : ExtendedTextSelectionToolbarContent(
              isArrowPointingDown: widget.isArrowPointingDown,
              children: items,
            ),
    );
  }
}
