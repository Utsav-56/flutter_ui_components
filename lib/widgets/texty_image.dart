import 'package:flutter/material.dart';

// Reusing the CircularImage and BorderModel (assumed you already have them)
import 'circular_image.dart'; // your previously created widget
import '../models/border_model.dart';

enum LabelAlign {
  topLeft,
  topRight,
  center,
  left,
  right,
}

class TextyImage extends StatelessWidget {
  final String? imageUri;
  final double? imageHeight;
  final double? imageWidth;
  final BorderModel? border;
  final Color? backgroundColor;
  final EdgeInsets? padding;

  final String? labelText;
  final LabelAlign labelAlign;
  final double fontSize;
  final Color textColor;
  final EdgeInsets? labelMargin;

  const TextyImage({
    super.key,
    required this.imageUri,
    this.imageHeight,
    this.imageWidth,
    this.border,
    this.backgroundColor,
    this.padding,
    this.labelText,
    this.labelAlign = LabelAlign.right,
    this.fontSize = 12,
    this.textColor = Colors.white,
    this.labelMargin,
  });

  Alignment _getTextAlignment() {
    switch (labelAlign) {
      case LabelAlign.topLeft:
        return Alignment.topLeft;
      case LabelAlign.topRight:
        return Alignment.topRight;
      case LabelAlign.center:
        return Alignment.center;
      case LabelAlign.left:
        return Alignment.centerLeft;
      case LabelAlign.right:
        return Alignment.centerRight;
    }
  }

  EdgeInsets _clampedMargin(double width, double height) {
    if (labelMargin == null) return EdgeInsets.zero;

    double clamp(double value, double max) => value > max ? max * 0.75 : value;

    return EdgeInsets.only(
      left: clamp(labelMargin!.left, width),
      right: clamp(labelMargin!.right, width),
      top: clamp(labelMargin!.top, height),
      bottom: clamp(labelMargin!.bottom, height),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = imageHeight ?? 50;
    final double width = imageWidth ?? 50;
    final double adjustedHeight =
        (imageHeight != null && imageHeight! > height) ? height * 0.95 : height;

    return Stack(
      alignment: _getTextAlignment(),
      children: [
        CircularImage(
          assetUrl: imageUri,
          height: adjustedHeight,
          width: width,
          border: border,
          backgroundColor: backgroundColor,
          padding: padding,
        ),
        if (labelText != null)
          Container(
            margin: _clampedMargin(width, adjustedHeight),
            child: Text(
              labelText!,
              style: TextStyle(
                fontSize: fontSize,
                color: textColor,
                backgroundColor: Colors.black45,
              ),
            ),
          ),
      ],
    );
  }
}
