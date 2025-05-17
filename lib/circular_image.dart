import 'package:flutter/material.dart';
import 'package:up_ui/models/border_model.dart';

class CircularImage extends StatelessWidget {
  final String? networkUrl;
  final String? assetUrl;
  final double? height;
  final double? width;
  final BorderModel? border;
  final Color? backgroundColor;
  final EdgeInsets? padding;

  const CircularImage({
    super.key,
    this.networkUrl,
    this.assetUrl,
    this.height,
    this.width,
    this.border,
    this.backgroundColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final double finalHeight =
        height ?? MediaQuery.of(context).size.height * 0.5;
    final double finalWidth = width ?? MediaQuery.of(context).size.width * 0.5;

    Widget imageWidget;

    if (networkUrl != null && networkUrl!.isNotEmpty) {
      imageWidget = Image.network(
        networkUrl!,
        fit: BoxFit.cover,
      );
    } else if (assetUrl != null && assetUrl!.isNotEmpty) {
      imageWidget = Image.asset(
        assetUrl!,
        fit: BoxFit.cover,
      );
    } else {
      imageWidget = const Center(
        child: Text(
          "Null image given",
          style: TextStyle(fontSize: 12),
        ),
      );
    }

    return Container(
      height: finalHeight,
      width: finalWidth,
      padding: padding ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        shape: BoxShape.circle,
        border: border != null
            ? Border.all(
                color: border!.color,
                width: border!.size,
                style: border!.style,
              )
            : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: ClipOval(child: imageWidget),
    );
  }
}
