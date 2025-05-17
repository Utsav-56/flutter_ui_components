import 'package:flutter/material.dart';

class SplitScreen extends StatefulWidget {
  final Widget leftChild;
  final Widget rightChild;
  final double? leftWidth;
  final double? rightWidth;
  final double? height; // acts like minHeight
  final double? maxHeight;
  final double? responsiveHeight; // new
  final EdgeInsetsGeometry? padding;
  final double gap;

  const SplitScreen({
    super.key,
    required this.leftChild,
    required this.rightChild,
    this.leftWidth,
    this.rightWidth,
    this.height,
    this.maxHeight,
    this.responsiveHeight,
    this.padding,
    this.gap = 8.0,
  });

  @override
  State<SplitScreen> createState() => _SplitScreenState();
}

class _SplitScreenState extends State<SplitScreen> {
  final GlobalKey _leftKey = GlobalKey();
  final GlobalKey _rightKey = GlobalKey();
  double? _minHeight;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncHeights());
  }

  void _syncHeights() {
    final leftContext = _leftKey.currentContext;
    final rightContext = _rightKey.currentContext;

    if (leftContext != null && rightContext != null) {
      final leftHeight = leftContext.size?.height ?? 0;
      final rightHeight = rightContext.size?.height ?? 0;
      final newMinHeight = leftHeight < rightHeight ? leftHeight : rightHeight;

      if (_minHeight != newMinHeight && newMinHeight > 0) {
        setState(() {
          _minHeight = newMinHeight;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    double? calculatedHeight;

    if (widget.responsiveHeight != null) {
      double percentHeight = (widget.responsiveHeight!).clamp(0.0, 1.0);
      double viewHeight = screenHeight * percentHeight;

      if (_minHeight != null && _minHeight! < viewHeight) {
        calculatedHeight = _minHeight;
      } else {
        calculatedHeight = viewHeight;
      }
    } else {
      calculatedHeight = widget.height ?? _minHeight;
      if (widget.maxHeight != null && calculatedHeight != null) {
        calculatedHeight = calculatedHeight > widget.maxHeight!
            ? widget.maxHeight
            : calculatedHeight;
      }
    }

    return LayoutBuilder(builder: (context, constraints) {
      final totalWidth = constraints.maxWidth;

      double computedLeftWidth;
      double computedRightWidth;

      if (widget.leftWidth != null && widget.rightWidth != null) {
        debugPrint(
            '⚠️ Both leftWidth and rightWidth are provided. Falling back to 50/50 split.');
        computedLeftWidth = (totalWidth - widget.gap) / 2;
        computedRightWidth = (totalWidth - widget.gap) / 2;
      } else if (widget.leftWidth != null) {
        computedLeftWidth =
            widget.leftWidth!.clamp(0.0, totalWidth - widget.gap);
        computedRightWidth = totalWidth - computedLeftWidth - widget.gap;
      } else if (widget.rightWidth != null) {
        computedRightWidth =
            widget.rightWidth!.clamp(0.0, totalWidth - widget.gap);
        computedLeftWidth = totalWidth - computedRightWidth - widget.gap;
      } else {
        computedLeftWidth = (totalWidth - widget.gap) / 2;
        computedRightWidth = (totalWidth - widget.gap) / 2;
      }

      return Padding(
        padding: widget.padding ?? EdgeInsets.zero,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRect(
              child: SizedBox(
                width: computedLeftWidth,
                height: calculatedHeight,
                child: SingleChildScrollView(
                  child: Container(
                    key: _leftKey,
                    child: widget.leftChild,
                  ),
                ),
              ),
            ),
            SizedBox(width: widget.gap),
            ClipRect(
              child: SizedBox(
                width: computedRightWidth,
                height: calculatedHeight,
                child: SingleChildScrollView(
                  child: Container(
                    key: _rightKey,
                    child: widget.rightChild,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
