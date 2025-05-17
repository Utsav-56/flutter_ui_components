class GridBreakpoints {
  final Map<int, int> breakpoints;

  GridBreakpoints(this.breakpoints);

  /// Return the value that corresponds to the nearest lower breakpoint
  int resolve(double width, int defaultValue) {
    int closest = -1;
    for (int bp in breakpoints.keys) {
      if (width >= bp && bp > closest) {
        closest = bp;
      }
    }
    return closest != -1 ? breakpoints[closest]! : defaultValue;
  }
}
