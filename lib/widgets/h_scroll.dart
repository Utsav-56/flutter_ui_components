import 'package:up_ui/models/border_model.dart';
import 'package:flutter/material.dart';

class _ScrollableBox extends StatelessWidget {
  final Axis scrollDirection;
  final List<Widget> children;
  final EdgeInsets? padding;
  final BorderModel? borderModel;
  final double? gap;
  final Widget? separator;

  const _ScrollableBox({
    required this.scrollDirection,
    required this.children,
    this.padding,
    this.borderModel,
    this.gap,
    this.separator,
  });

  List<Widget> buildChildrenWithSpacing() {
    if (children.isEmpty) return [];

    final List<Widget> output = [];
    for (int i = 0; i < children.length; i++) {
      output.add(children[i]);

      if (gap != null && gap! > 0) {
        output.add(SizedBox(
          width: scrollDirection == Axis.horizontal ? gap : 0,
          height: scrollDirection == Axis.vertical ? gap : 0,
        ));
      }

      if (i < children.length - 1) {}
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    final isVertical = scrollDirection == Axis.vertical;

    return Container(
      padding: padding ?? EdgeInsets.zero,
      decoration: BoxDecoration(border: borderModel?.toBorder()),
      child: SingleChildScrollView(
        scrollDirection: scrollDirection,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: isVertical ? 0 : 0,
            // Don't use infinity for minHeight
            minHeight: isVertical ? 0 : 0,
            maxWidth: double.infinity,
            maxHeight: double.infinity,
          ),
          child: isVertical
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: buildChildrenWithSpacing(),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: buildChildrenWithSpacing(),
                ),
        ),
      ),
    );
  }
}

class VScroll extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? padding;
  final BorderModel? borderModel;
  final double? gap;
  final Widget? separator;

  const VScroll({
    super.key,
    required this.children,
    this.padding,
    this.borderModel,
    this.gap,
    this.separator,
  });

  @override
  Widget build(BuildContext context) {
    return _ScrollableBox(
      scrollDirection: Axis.vertical,
      padding: padding,
      borderModel: borderModel,
      gap: gap,
      separator: separator,
      children: children,
    );
  }
}

class HScroll extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? padding;
  final BorderModel? borderModel;
  final double? gap;
  final Widget? separator;

  const HScroll({
    super.key,
    required this.children,
    this.padding,
    this.borderModel,
    this.gap,
    this.separator,
  });

  @override
  Widget build(BuildContext context) {
    return _ScrollableBox(
      scrollDirection: Axis.horizontal,
      padding: padding,
      borderModel: borderModel,
      gap: gap,
      separator: separator,
      children: children,
    );
  }
}
