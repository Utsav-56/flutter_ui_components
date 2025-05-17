import 'package:flutter/material.dart';
import 'package:up_ui/models/border_model.dart';

class TextShadowModel {
  final Color color;
  final Offset offset;
  final double blurRadius;

  TextShadowModel({
    this.color = Colors.black26,
    this.offset = const Offset(1, 1),
    this.blurRadius = 2.0,
  });

  Shadow toTextShadow() => Shadow(
        color: color,
        offset: offset,
        blurRadius: blurRadius,
      );
}

class StrokeModel {
  final double width;
  final Color color;

  StrokeModel({this.width = 1.0, this.color = Colors.black});
}

enum HeadingLevel { h1, h2, h3, h4, h5, h6 }

class Heading extends StatelessWidget {
  final HeadingLevel level;
  final String text;

  final double? fontSize;
  final Color? color;
  final Color? backgroundColor;
  final TextShadowModel? shadow;
  final StrokeModel? stroke;

  final EdgeInsetsGeometry? padding;
  final BorderModel? border;
  final double scale;

  final String? tooltip;

  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;

  final Widget? contentBefore;
  final Widget? contentAfter;

  const Heading({
    super.key,
    required this.text,
    this.level = HeadingLevel.h1,
    this.fontSize,
    this.color,
    this.backgroundColor,
    this.shadow,
    this.stroke,
    this.padding,
    this.border,
    this.scale = 1.0,
    this.tooltip,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.contentBefore,
    this.contentAfter,
  });

  double _getDefaultFontSize() {
    switch (level) {
      case HeadingLevel.h1:
        return 32;
      case HeadingLevel.h2:
        return 28;
      case HeadingLevel.h3:
        return 24;
      case HeadingLevel.h4:
        return 20;
      case HeadingLevel.h5:
        return 18;
      case HeadingLevel.h6:
        return 16;
    }
  }

  FontWeight _getFontWeight() {
    switch (level) {
      case HeadingLevel.h1:
        return FontWeight.bold;
      case HeadingLevel.h2:
        return FontWeight.w700;
      case HeadingLevel.h3:
        return FontWeight.w600;
      case HeadingLevel.h4:
        return FontWeight.w500;
      case HeadingLevel.h5:
        return FontWeight.w400;
      case HeadingLevel.h6:
        return FontWeight.w400;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: fontSize ?? _getDefaultFontSize(),
        fontWeight: _getFontWeight(),
        color: color ?? Colors.black,
        backgroundColor: backgroundColor,
        shadows: shadow != null ? [shadow!.toTextShadow()] : null,
        foreground: stroke != null
            ? (Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = stroke!.width
              ..color = stroke!.color)
            : null,
      ),
    );

    final wrappedContent = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (contentBefore != null) contentBefore!,
        Flexible(child: textWidget),
        if (contentAfter != null) contentAfter!,
      ],
    );

    Widget finalWidget = Container(
      padding: padding,
      decoration: BoxDecoration(
        border: border?.toBorder(),
        color: backgroundColor,
      ),
      child: Transform.scale(
        scale: scale,
        alignment: Alignment.centerLeft,
        child: wrappedContent,
      ),
    );

    if (tooltip != null) {
      finalWidget = Tooltip(
          message: tooltip!,
          waitDuration: const Duration(milliseconds: 500),
          child: finalWidget);
    }

    if (onTap != null || onDoubleTap != null || onLongPress != null) {
      finalWidget = GestureDetector(
        onTap: onTap,
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
        child: finalWidget,
      );
    }

    return finalWidget;
  }
}
