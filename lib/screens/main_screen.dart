import 'package:flutter/material.dart';

import '../constants/layout_constants.dart';
import '../utils/layout_utils.dart';
import '../widgets/custom_bottomNavigationBar.dart';
import '../widgets/custom_navigationRail.dart';
import 'home_screen.dart';
import 'note_overview_screen.dart';
import 'options_screen.dart';
import 'tasklist_overview_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page = getSelectedPage(selectedIndex);

    return LayoutBuilder(
      builder: (context, constraints) {
        if (LayoutUtils.isLandscapeMode(constraints)) {
          return Scaffold(
            body: Row(
              children: [
                SafeArea(
                  child: CustomNavigationRail(
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                    extended: CustomNavigationRail.isRailExtended(
                      constraints,
                      railThreshold,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: page,
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: page,
            bottomNavigationBar: CustomBottomNavigationBar(
              selectedIndex: selectedIndex,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
          );
        }
      },
    );
  }

  Widget getSelectedPage(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return NoteOverviewScreen();
      case 2:
        return TaskListOverviewScreen();
      case 3:
        return OptionsScreen();
      default:
        throw UnimplementedError('No widget for index $index');
    }
  }
}