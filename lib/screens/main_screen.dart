import 'package:flutter/material.dart';

import '../constants/navigation_constants.dart';
import 'home_screen.dart';
import 'note_overview_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomeScreen();
        break;
      case 1:
        page = NoteOverviewScreen();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine which navigation to show based on the screen width
        if (constraints.maxWidth >= 600) {
          // Show NavigationRail for larger screens (e.g., tablets or desktop)
          return Scaffold(
            body: Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    extended: constraints.maxWidth >= 800,
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.home),
                        label: Text(homeRoute),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.note),
                        label: Text(notesRoute),
                      ),
                    ],
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
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
          // Show BottomNavigationBar for smaller screens (mobile devices)
          return Scaffold(
            body: page,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: homeRoute,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.note),
                  label: notesRoute,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}