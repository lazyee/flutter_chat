import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_chat/widgets/extend_selectable_text/constant/constant.dart';

class ExtendedTextSelectionToolbar extends SingleChildRenderObjectWidget {
  const ExtendedTextSelectionToolbar({
    Key key,
    double barTopY,
    double arrowTipX,
    bool isArrowPointingDown,
    Widget child,
  })  : _barTopY = barTopY,
        _arrowTipX = arrowTipX,
        _isArrowPointingDown = isArrowPointingDown,
        super(key: key, child: child);

  // The y-coordinate of toolbar's top edge, in global coordinate system.
  final double _barTopY;

  // The y-coordinate of the tip of the arrow, in global coordinate system.
  final double _arrowTipX;

  // Whether the arrow should point down and be attached to the bottom
  // of the toolbar, or point up and be attached to the top of the toolbar.
  final bool _isArrowPointingDown;

  @override
  _ToolbarRenderBox createRenderObject(BuildContext context) =>
      _ToolbarRenderBox(_barTopY, _arrowTipX, _isArrowPointingDown, null);

  @override
  void updateRenderObject(
      BuildContext context, _ToolbarRenderBox renderObject) {
    renderObject
      ..barTopY = _barTopY
      ..arrowTipX = _arrowTipX
      ..isArrowPointingDown = _isArrowPointingDown;
  }
}

class _ToolbarParentData extends BoxParentData {
  // The x offset from the tip of the arrow to the center of the toolbar.
  // Positive if the tip of the arrow has a larger x-coordinate than the
  // center of the toolbar.
  double arrowXOffsetFromCenter;
  @override
  String toString() =>
      'offset=$offset, arrowXOffsetFromCenter=$arrowXOffsetFromCenter';
}

class _ToolbarRenderBox extends RenderShiftedBox {
  _ToolbarRenderBox(
    this._barTopY,
    this._arrowTipX,
    this._isArrowPointingDown,
    RenderBox child,
  ) : super(child);

  @override
  bool get isRepaintBoundary => true;

  double _barTopY;
  set barTopY(double value) {
    if (_barTopY == value) {
      return;
    }
    _barTopY = value;
    markNeedsLayout();
    markNeedsSemanticsUpdate();
  }

  double _arrowTipX;
  set arrowTipX(double value) {
    if (_arrowTipX == value) {
      return;
    }
    _arrowTipX = value;
    markNeedsLayout();
    markNeedsSemanticsUpdate();
  }

  bool _isArrowPointingDown;
  set isArrowPointingDown(bool value) {
    if (_isArrowPointingDown == value) {
      return;
    }
    _isArrowPointingDown = value;
    markNeedsLayout();
    markNeedsSemanticsUpdate();
  }

  final BoxConstraints heightConstraint =
      const BoxConstraints.tightFor(height: kDefaultToolbarHeight);

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! _ToolbarParentData) {
      child.parentData = _ToolbarParentData();
    }
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    size = constraints.biggest;

    if (child == null) {
      return;
    }
    final BoxConstraints enforcedConstraint = constraints
        .deflate(const EdgeInsets.symmetric(
            horizontal: kDefaultToolbarScreenPadding))
        .loosen();

    child.layout(
      heightConstraint.enforce(enforcedConstraint),
      parentUsesSize: true,
    );
    final _ToolbarParentData childParentData =
        child.parentData as _ToolbarParentData;

    // The local x-coordinate of the center of the toolbar.
    final double lowerBound =
        child.size.width / 2 + kDefaultToolbarScreenPadding;
    final double upperBound =
        size.width - child.size.width / 2 - kDefaultToolbarScreenPadding;
    final double adjustedCenterX =
        _arrowTipX.clamp(lowerBound, upperBound) as double;

    childParentData.offset =
        Offset(adjustedCenterX - child.size.width / 2, _barTopY);
    childParentData.arrowXOffsetFromCenter = _arrowTipX - adjustedCenterX;
  }

  // The path is described in the toolbar's coordinate system.
  Path _clipPath() {
    final _ToolbarParentData childParentData =
        child.parentData as _ToolbarParentData;
    final Path rrect = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Offset(
                0,
                _isArrowPointingDown ? 0 : kDefaultToolbarArrowSize.height,
              ) &
              Size(child.size.width,
                  child.size.height - kDefaultToolbarArrowSize.height),
          kDefaultToolbarBorderRadius,
        ),
      );

    final double arrowTipX =
        child.size.width / 2 + childParentData.arrowXOffsetFromCenter;

    final double arrowBottomY = _isArrowPointingDown
        ? child.size.height - kDefaultToolbarArrowSize.height
        : kDefaultToolbarArrowSize.height;

    final double arrowTipY = _isArrowPointingDown ? child.size.height : 0;

    final Path arrow = Path()
      ..moveTo(arrowTipX, arrowTipY)
      ..lineTo(arrowTipX - kDefaultToolbarArrowSize.width / 2, arrowBottomY)
      ..lineTo(arrowTipX + kDefaultToolbarArrowSize.width / 2, arrowBottomY)
      ..close();

    return Path.combine(PathOperation.union, rrect, arrow);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) {
      return;
    }

    final _ToolbarParentData childParentData =
        child.parentData as _ToolbarParentData;
    context.pushClipPath(
      needsCompositing,
      offset + childParentData.offset,
      Offset.zero & child.size,
      _clipPath(),
      (PaintingContext innerContext, Offset innerOffset) =>
          innerContext.paintChild(child, innerOffset),
    );
  }

  // Paint _debugPaint;

  // @override
  // void debugPaintSize(PaintingContext context, Offset offset) {
  //   assert(() {
  //     if (child == null) {
  //       return true;
  //     }

  //     _debugPaint ??= Paint()
  //       ..shader = ui.Gradient.linear(
  //         const Offset(0.0, 0.0),
  //         const Offset(10.0, 10.0),
  //         <Color>[
  //           const Color(0x00000000),
  //           const Color(0xFFFF00FF),
  //           const Color(0xFFFF00FF),
  //           const Color(0x00000000)
  //         ],
  //         <double>[0.25, 0.25, 0.75, 0.75],
  //         TileMode.repeated,
  //       )
  //       ..strokeWidth = 2.0
  //       ..style = PaintingStyle.stroke;

  //     final _ToolbarParentData childParentData =
  //         child.parentData as _ToolbarParentData;
  //     context.canvas.drawPath(
  //         _clipPath().shift(offset + childParentData.offset), _debugPaint);
  //     return true;
  //   }());
  // }
}
