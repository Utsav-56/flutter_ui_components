import 'package:flutter/material.dart';
import 'package:up_ui/models/border_model.dart';
import 'package:flutter/material.dart';

enum OverflowBehavior {
  contain,
  autoResize,
  hide,
  scroll,
}

class ShadowModel {
  final Color color;
  final double opacity;
  final double blur;
  final Offset offset;

  const ShadowModel({
    this.color = Colors.black,
    this.opacity = 0.2,
    this.blur = 6.0,
    this.offset = const Offset(0, 2),
  });

  BoxShadow toBoxShadow() {
    return BoxShadow(
      color: color.withOpacity(opacity),
      blurRadius: blur,
      offset: offset,
    );
  }
}

class Div extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? padding;
  final BorderModel? border;
  final bool scrollable;
  final Axis scrollDirection;
  final Axis contentDirection;
  final double gap;
  final Color? backgroundColor;
  final DecorationImage? backgroundImage;
  final BorderRadius? borderRadius;
  final ShadowModel? shadow;
  final VoidCallback? onTap;
  final double scale;

  // Size constraints
  final double? height; // alias to minHeight
  final double? width; // alias to minWidth
  final double? minHeight;
  final double? maxHeight;
  final double? minWidth;
  final double? maxWidth;

  //Overflow behavior
  final OverflowBehavior overflow;

  const Div({
    super.key,
    required this.children,
    this.padding,
    this.border,
    this.scrollable = true,
    this.scrollDirection = Axis.vertical,
    this.contentDirection = Axis.vertical,
    this.gap = 0.0,
    this.backgroundColor,
    this.backgroundImage,
    this.borderRadius,
    this.shadow,
    this.onTap,
    this.scale = 1.0,
    this.height,
    this.width,
    this.minHeight,
    this.maxHeight,
    this.minWidth,
    this.maxWidth,
    this.overflow = OverflowBehavior.contain, // default
  });

  @override
  Widget build(BuildContext context) {
    final spacedChildren = _addGaps(children);

    final constraints = BoxConstraints(
      minHeight: minHeight ?? height ?? 0,
      maxHeight: maxHeight ?? double.infinity,
      minWidth: minWidth ?? width ?? 0,
      maxWidth: maxWidth ?? double.infinity,
    );

    Widget childContent = _buildContent(spacedChildren);

    // Apply padding, decoration, etc.
    Widget baseContainer = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        image: backgroundImage,
        border: border?.toBorder(),
        borderRadius: borderRadius,
        boxShadow: shadow != null ? [shadow!.toBoxShadow()] : null,
      ),
      child: childContent,
    );

    // Apply scaling
    Widget scaled = Transform.scale(
      scale: scale,
      alignment: Alignment.topLeft,
      child: baseContainer,
    );

    // Handle overflow behavior
    Widget result;

    switch (overflow) {
      case OverflowBehavior.autoResize:
        result = FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.topLeft,
          child: ConstrainedBox(
            constraints: constraints,
            child: scaled,
          ),
        );
        break;

      case OverflowBehavior.hide:
        result = ClipRect(
          child: ConstrainedBox(
            constraints: constraints,
            child: scaled,
          ),
        );
        break;

      case OverflowBehavior.scroll:
        result = SingleChildScrollView(
          scrollDirection: scrollDirection,
          child: ConstrainedBox(
            constraints: constraints,
            child: scaled,
          ),
        );
        break;

      case OverflowBehavior.contain:
      default:
        result = ConstrainedBox(
          constraints: constraints,
          child: scrollable
              ? SingleChildScrollView(
                  scrollDirection: scrollDirection,
                  child: scaled,
                )
              : scaled,
        );
        break;
    }

    return onTap != null
        ? GestureDetector(onTap: onTap, child: result)
        : result;
  }

  Widget _buildContent(List<Widget> children) {
    return contentDirection == Axis.vertical
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          );
  }

  List<Widget> _addGaps(List<Widget> children) {
    if (children.isEmpty || gap == 0) return children;

    List<Widget> spaced = [];
    for (int i = 0; i < children.length; i++) {
      spaced.add(children[i]);
      if (i != children.length - 1) {
        spaced.add(SizedBox(
          width: contentDirection == Axis.horizontal ? gap : 0,
          height: contentDirection == Axis.vertical ? gap : 0,
        ));
      }
    }
    return spaced;
  }
}
