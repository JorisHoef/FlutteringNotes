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
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      extended: extended,
      selectedIconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        size: 28.0,
      ),
      unselectedIconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.onSecondaryContainer,
        size: 24.0,
      ),
      selectedLabelTextStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      unselectedLabelTextStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onSecondaryContainer,
      ),
      destinations: navigationDestinations
          .map(
            (destination) => NavigationRailDestination(
          icon: destination.icon,
          label: Text(destination.label),
        ),
      ).toList(),
    );
  }

  static bool isRailExtended(BoxConstraints constraints, double threshold) {
    double normalizedAspectRatio = LayoutUtils.getNormalizedAspectRatio(constraints);
    return LayoutUtils.isLandscapeMode(constraints) && normalizedAspectRatio > threshold;
  }
}