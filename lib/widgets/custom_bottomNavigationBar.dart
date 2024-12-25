import 'package:flutter/material.dart';

import '../constants/navigation_constants.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTap,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      selectedItemColor: Theme.of(context).colorScheme.onPrimaryContainer,
      unselectedItemColor: Theme.of(context).colorScheme.onSecondaryContainer,
      items: navigationDestinations
          .map(
            (destination) => BottomNavigationBarItem(
          icon: destination.icon,
          label: destination.label,
        ),
      ).toList(),
    );
  }
}