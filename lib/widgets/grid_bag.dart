import 'package:flutter/material.dart';

class GridBag extends StatelessWidget {
  final int rows;
  final int cols;
  final List<Widget> children;

  final double? maxHeight; // max height for each cell
  final double? maxWidth; // max width for each cell
  final double? cellHeight; // alias for maxHeight
  final double? cellWidth; // alias for maxWidth

  final EdgeInsets? padding;
  final double spacing;

  const GridBag({
    super.key,
    required this.rows,
    required this.cols,
    required this.children,
    this.maxHeight,
    this.maxWidth,
    this.cellHeight,
    this.cellWidth,
    this.padding,
    this.spacing = 0,
  });

  @override
  Widget build(BuildContext context) {
    final int totalCells = rows * cols;

    final double availableWidth =
        MediaQuery.of(context).size.width - (padding?.horizontal ?? 0);
    final double availableHeight = MediaQuery.of(context).size.height;

    final double usedMaxWidth =
        cellWidth ?? maxWidth ?? (availableWidth / cols);
    final double usedMaxHeight =
        cellHeight ?? maxHeight ?? (availableHeight / 2);

    final double calculatedCellWidth =
        ((availableWidth - (spacing * (cols - 1))) / cols)
            .clamp(0, usedMaxWidth);
    final double calculatedCellHeight = usedMaxHeight;

    List<Widget> finalChildren = List<Widget>.from(children);
    while (finalChildren.length < totalCells) {
      finalChildren.add(Container());
    }

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: List.generate(totalCells, (index) {
          return SizedBox(
            width: calculatedCellWidth,
            height: calculatedCellHeight,
            child: finalChildren[index],
          );
        }),
      ),
    );
  }
}
