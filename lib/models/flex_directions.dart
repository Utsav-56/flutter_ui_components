import 'package:flutter/material.dart';

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
