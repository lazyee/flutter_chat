import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import 'package:flutter_chat/widgets/extend_selectable_text/constant/constant.dart';
import 'package:flutter_chat/widgets/extend_selectable_text/extended_toolbar_options.dart';

import '../extended_text_selection.dart';
import 'extended_text_selection_toolbar_wrapper.dart';

/// Text selection controls that follows iOS design conventions.
final ExtendedTextSelectionControls extendedCustomTextSelectionControls =
    // _ExtendedCupertinoTextSelectionControls();
    ExtendedCustomTextSelectionControls();

class ExtendedCustomTextSelectionControls
    extends ExtendedTextSelectionControls {
  /// Returns the size of the Cupertino handle.
  @override
  Size getHandleSize(double textLineHeight) {
    return Size(
      kDefaultSelectionHandleRadius * 2,
      textLineHeight +
          kDefaultSelectionHandleRadius * 2 -
          kDefaultSelectionHandleOverlap,
    );
  }

  /// Builder for iOS-style copy/paste text selection toolbar.
  @override
  Widget buildToolbar(
    BuildContext context,
    Rect globalEditableRegion,
    double textLineHeight,
    Offset position,
    List<TextSelectionPoint> endpoints,
    List<ExtendedToolbarOption> toolbarOptions,
    TextSelectionDelegate delegate,
    ExtendedClipboardStatusNotifier clipboardStatus,
  ) {
    assert(debugCheckHasMediaQuery(context));
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    // The toolbar should appear below the TextField when there is not enough
    // space above the TextField to show it, assuming there's always enough space
    // at the bottom in this case.
    final double toolbarHeightNeeded = mediaQuery.padding.top +
        kDefaultToolbarScreenPadding +
        kDefaultToolbarHeight +
        kDefaultToolbarContentDistance;
    final double availableHeight =
        globalEditableRegion.top + endpoints.first.point.dy - textLineHeight;
    final bool isArrowPointingDown = toolbarHeightNeeded <= availableHeight;

    final double arrowTipX = (position.dx + globalEditableRegion.left).clamp(
      kDefaultArrowScreenPadding + mediaQuery.padding.left,
      mediaQuery.size.width -
          mediaQuery.padding.right -
          kDefaultArrowScreenPadding,
    ) as double;

    // The y-coordinate has to be calculated instead of directly quoting position.dy,
    // since the caller (TextSelectionOverlay._buildToolbar) does not know whether
    // the toolbar is going to be facing up or down.
    final double localBarTopY = isArrowPointingDown
        ? endpoints.first.point.dy -
            textLineHeight -
            kDefaultToolbarContentDistance -
            kDefaultToolbarHeight
        : endpoints.last.point.dy + kDefaultToolbarContentDistance;
    // handleCopy(delegate, clipboardStatus);
    ExtendedToolbarCopyOption copyOption = toolbarOptions.firstWhere(
        (element) => element.runtimeType == ExtendedToolbarCopyOption,
        orElse: () => null);
    print("copyOption:$copyOption");
    if (copyOption != null) {
      copyOption.onPress = (canCopy(delegate)
          ? () => handleCopy(delegate, clipboardStatus)
          : null);
    }
    return ExtendedTextSelectionToolbarWrapper(
      arrowTipX: arrowTipX,
      barTopY: localBarTopY + globalEditableRegion.top,
      clipboardStatus: clipboardStatus,
      toolbarOptions: toolbarOptions,
      // handleCut: canCut(delegate) ? () => handleCut(delegate) : null,
      // handleCopy: canCopy(delegate) ? () => handleCopy(delegate, clipboardStatus) : null,
      // handlePaste: canPaste(delegate) ? () => handlePaste(delegate) : null,
      // handleSelectAll:
      // canSelectAll(delegate) ? () => handleSelectAll(delegate) : null,
      isArrowPointingDown: isArrowPointingDown,
    );
  }

  /// Builder for iOS text selection edges.
  @override
  Widget buildHandle(BuildContext context, TextSelectionHandleType type,
      double textLineHeight) {
    // We want a size that's a vertical line the height of the text plus a 18.0
    // padding in every direction that will constitute the selection drag area.
    final Size desiredSize = getHandleSize(textLineHeight);

    final Widget handle = SizedBox.fromSize(
      size: desiredSize,
      child: CustomPaint(
        painter: _TextSelectionHandlePainter(
            CupertinoTheme.of(context).primaryColor),
      ),
    );

    // [buildHandle]'s widget is positioned at the selection cursor's bottom
    // baseline. We transform the handle such that the SizedBox is superimposed
    // on top of the text selection endpoints.
    switch (type) {
      case TextSelectionHandleType.left:
        return handle;
      case TextSelectionHandleType.right:
        // Right handle is a vertical mirror of the left.
        return Transform(
          transform: Matrix4.identity()
            ..translate(desiredSize.width / 2, desiredSize.height / 2)
            ..rotateZ(math.pi)
            ..translate(-desiredSize.width / 2, -desiredSize.height / 2),
          child: handle,
        );
      // iOS doesn't draw anything for collapsed selections.
      case TextSelectionHandleType.collapsed:
        return const SizedBox();
    }
    assert(type != null);
    return null;
  }

  /// Gets anchor for cupertino-style text selection handles.
  ///
  /// See [TextSelectionControls.getHandleAnchor].
  @override
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight) {
    final Size handleSize = getHandleSize(textLineHeight);
    switch (type) {
      // The circle is at the top for the left handle, and the anchor point is
      // all the way at the bottom of the line.
      case TextSelectionHandleType.left:
        return Offset(
          handleSize.width / 2,
          handleSize.height,
        );
      // The right handle is vertically flipped, and the anchor point is near
      // the top of the circle to give slight overlap.
      case TextSelectionHandleType.right:
        return Offset(
          handleSize.width / 2,
          handleSize.height -
              2 * kDefaultSelectionHandleRadius +
              kDefaultSelectionHandleOverlap,
        );
      // A collapsed handle anchors itself so that it's centered.
      default:
        return Offset(
          handleSize.width / 2,
          textLineHeight + (handleSize.height - textLineHeight) / 2,
        );
    }
  }
}

/// Draws a single text selection handle with a bar and a ball.
class _TextSelectionHandlePainter extends CustomPainter {
  const _TextSelectionHandlePainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const double halfStrokeWidth = 1.0;
    final Paint paint = Paint()..color = color;
    final Rect circle = Rect.fromCircle(
      center: const Offset(
          kDefaultSelectionHandleRadius, kDefaultSelectionHandleRadius),
      radius: kDefaultSelectionHandleRadius,
    );
    final Rect line = Rect.fromPoints(
      const Offset(
        kDefaultSelectionHandleRadius - halfStrokeWidth,
        2 * kDefaultSelectionHandleRadius - kDefaultSelectionHandleOverlap,
      ),
      Offset(kDefaultSelectionHandleRadius + halfStrokeWidth, size.height),
    );
    final Path path = Path()
      ..addOval(circle)
      // Draw line so it slightly overlaps the circle.
      ..addRect(line);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_TextSelectionHandlePainter oldPainter) =>
      color != oldPainter.color;
}
