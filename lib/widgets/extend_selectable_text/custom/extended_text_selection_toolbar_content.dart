import 'package:flutter/cupertino.dart';
import 'package:flutter_chat/widgets/extend_selectable_text/constant/constant.dart';

import 'extended_text_selection_toolbar_items.dart';

class ExtendedTextSelectionToolbarContent extends StatefulWidget {
  const ExtendedTextSelectionToolbarContent({
    Key key,
    @required this.children,
    @required this.isArrowPointingDown,
  })  : assert(children != null),
        // This ignore is used because .isNotEmpty isn't compatible with const.
        assert(children.length > 0), // ignore: prefer_is_empty
        super(key: key);

  final List<Widget> children;
  final bool isArrowPointingDown;

  @override
  _ExtendedTextSelectionToolbarContentState createState() =>
      _ExtendedTextSelectionToolbarContentState();
}

class _ExtendedTextSelectionToolbarContentState
    extends State<ExtendedTextSelectionToolbarContent>
    with TickerProviderStateMixin {
  // Controls the fading of the buttons within the menu during page transitions.
  AnimationController _controller;
  int _page = 0;
  int _nextPage;

  void _handleNextPage() {
    _controller.reverse();
    _controller.addStatusListener(_statusListener);
    _nextPage = _page + 1;
  }

  void _handlePreviousPage() {
    _controller.reverse();
    _controller.addStatusListener(_statusListener);
    _nextPage = _page - 1;
  }

  void _statusListener(AnimationStatus status) {
    if (status != AnimationStatus.dismissed) {
      return;
    }

    setState(() {
      _page = _nextPage;
      _nextPage = null;
    });
    _controller.forward();
    _controller.removeStatusListener(_statusListener);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 1.0,
      vsync: this,
      // This was eyeballed on a physical iOS device running iOS 13.
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void didUpdateWidget(ExtendedTextSelectionToolbarContent oldWidget) {
    // If the children are changing, the current page should be reset.
    if (widget.children != oldWidget.children) {
      _page = 0;
      _nextPage = null;
      _controller.forward();
      _controller.removeStatusListener(_statusListener);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets arrowPadding = widget.isArrowPointingDown
        ? EdgeInsets.only(bottom: kDefaultToolbarArrowSize.height)
        : EdgeInsets.only(top: kDefaultToolbarArrowSize.height);

    return DecoratedBox(
      decoration: const BoxDecoration(color: kDefaultToolbarDividerColor),
      child: FadeTransition(
        opacity: _controller,
        // child: ExtendedTextSelectionToolbarItems(
        child: ExtendedTextSelectionToolbarItems(
          page: _page,
          backButton: CupertinoButton(
            borderRadius: null,
            color: kDefaultToolbarBackgroundColor,
            minSize: kDefaultToolbarHeight,
            onPressed: _handlePreviousPage,
            padding: arrowPadding,
            pressedOpacity: 0.7,
            child: const Text('◀', style: kDefaultToolbarButtonFontStyle),
          ),
          dividerWidth: 1.0 / MediaQuery.of(context).devicePixelRatio,
          nextButton: CupertinoButton(
            borderRadius: null,
            color: kDefaultToolbarBackgroundColor,
            minSize: kDefaultToolbarHeight,
            onPressed: _handleNextPage,
            padding: arrowPadding,
            pressedOpacity: 0.7,
            child: const Text('▶', style: kDefaultToolbarButtonFontStyle),
          ),
          nextButtonDisabled: CupertinoButton(
            borderRadius: null,
            color: kDefaultToolbarBackgroundColor,
            disabledColor: kDefaultToolbarBackgroundColor,
            minSize: kDefaultToolbarHeight,
            onPressed: null,
            padding: arrowPadding,
            pressedOpacity: 1.0,
            child:
                const Text('▶', style: kDefaultToolbarButtonDisabledFontStyle),
          ),
          children: widget.children,
        ),
      ),
    );
  }
}
