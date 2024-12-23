import 'package:flutter/material.dart';

class LayoutUtils {
  static bool isLandscapeMode(BoxConstraints constraints) {
    bool isLandscape = constraints.maxWidth > constraints.maxHeight;
    return isLandscape;
  }

  static double getNormalizedAspectRatio(BoxConstraints constraints) {
    double aspectRatio = constraints.maxWidth / constraints.maxHeight;
    double minAspectRatio = 0.5;
    double maxAspectRatio = 2.0;

    return (aspectRatio - minAspectRatio) / (maxAspectRatio - minAspectRatio);
  }
}