import 'package:flutter/material.dart';

import '../constants/navigation_constants.dart';
import '../utils/layout_utils.dart';

class CustomNavigationRail extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final bool extended;

  const CustomNavigationRail({
    Key? key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.extended,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      extended: extended,
      destinations: navigationDestinations
          .map(
            (destination) => NavigationRailDestination(
          icon: destination.icon,
          label: Text(destination.label),
        ),
      ).toList(),
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
    );
  }

  static bool isRailExtended(BoxConstraints constraints, double threshold) {
    double normalizedAspectRatio = LayoutUtils.getNormalizedAspectRatio(constraints);
    return LayoutUtils.isLandscapeMode(constraints) && normalizedAspectRatio > threshold;
  }
}