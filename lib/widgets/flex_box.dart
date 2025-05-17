import 'package:flutter/material.dart';
import 'package:up_ui/models/border_model.dart';

enum FlexDirection {
  row,
  column,
}

enum AlignHorizontal {
  start,
  center,
  end,
  spaceBetween,
  spaceAround,
  spaceEvenly,
}

enum AlignVertical {
  start,
  center,
  end,
  stretch,
}

MainAxisAlignment mapMainAxisAlignment(AlignHorizontal align) {
  switch (align) {
    case AlignHorizontal.center:
      return MainAxisAlignment.center;
    case AlignHorizontal.end:
      return MainAxisAlignment.end;
    case AlignHorizontal.spaceBetween:
      return MainAxisAlignment.spaceBetween;
    case AlignHorizontal.spaceAround:
      return MainAxisAlignment.spaceAround;
    case AlignHorizontal.spaceEvenly:
      return MainAxisAlignment.spaceEvenly;
    default:
      return MainAxisAlignment.start;
  }
}

CrossAxisAlignment mapCrossAxisAlignment(AlignVertical align) {
  switch (align) {
    case AlignVertical.center:
      return CrossAxisAlignment.center;
    case AlignVertical.end:
      return CrossAxisAlignment.end;
    case AlignVertical.stretch:
      return CrossAxisAlignment.stretch;
    default:
      return CrossAxisAlignment.start;
  }
}

class FlexBox extends StatelessWidget {
  final List<Widget> children;
  final double gap;
  final FlexDirection direction;
  final CrossAxisAlignment alignItems;
  final MainAxisAlignment justifyContent;
  final EdgeInsets? padding;
  final BorderModel? border;
  final bool flexWrap;

  const FlexBox({
    super.key,
    required this.children,
    this.gap = 0.0,
    this.direction = FlexDirection.row,
    this.alignItems = CrossAxisAlignment.start,
    this.justifyContent = MainAxisAlignment.start,
    this.padding,
    this.border,
    this.flexWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    final decoratedContainer = Container(
      padding: padding,
      decoration: BoxDecoration(
        border: border?.toBorder(),
      ),
      child: _buildFlexContent(),
    );

    return decoratedContainer;
  }

  Widget _buildFlexContent() {
    final spacedChildren = _addGaps(children);

    if (flexWrap) {
      return Wrap(
        direction:
            direction == FlexDirection.row ? Axis.horizontal : Axis.vertical,
        alignment: _getWrapAlignment(justifyContent),
        runAlignment: _getWrapAlignment(alignItems),
        spacing: gap,
        runSpacing: gap,
        children: children,
      );
    } else {
      if (direction == FlexDirection.row) {
        return Row(
          mainAxisAlignment: justifyContent,
          crossAxisAlignment: alignItems,
          children: spacedChildren,
        );
      } else {
        return Column(
          mainAxisAlignment: justifyContent,
          crossAxisAlignment: alignItems,
          children: spacedChildren,
        );
      }
    }
  }

  /// Adds spacing (gap) between children
  List<Widget> _addGaps(List<Widget> children) {
    if (children.isEmpty || gap == 0) return children;

    List<Widget> spaced = [];
    for (int i = 0; i < children.length; i++) {
      spaced.add(children[i]);
      if (i != children.length - 1) {
        spaced.add(SizedBox(
          width: direction == FlexDirection.row ? gap : 0,
          height: direction == FlexDirection.column ? gap : 0,
        ));
      }
    }
    return spaced;
  }

  WrapAlignment _getWrapAlignment(dynamic alignment) {
    switch (alignment) {
      case MainAxisAlignment.center:
        return WrapAlignment.center;
      case MainAxisAlignment.end:
        return WrapAlignment.end;
      case MainAxisAlignment.spaceBetween:
        return WrapAlignment.spaceBetween;
      case MainAxisAlignment.spaceAround:
        return WrapAlignment.spaceAround;
      case MainAxisAlignment.spaceEvenly:
        return WrapAlignment.spaceEvenly;
      case MainAxisAlignment.start:
      default:
        return WrapAlignment.start;
    }
  }
}
