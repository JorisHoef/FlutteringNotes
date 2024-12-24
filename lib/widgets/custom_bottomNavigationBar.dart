import 'package:flutter/material.dart';

import '../constants/navigation_constants.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTap,
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