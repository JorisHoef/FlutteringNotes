import 'package:flutter/material.dart';
import 'package:fluttering_notes/constants/theme_constants.dart';
import 'package:provider/provider.dart';

import '../themes/theme_provider.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onTapCallback;
  final List<PopupMenuEntry<String>> menuItems;
  final void Function(String) onMenuItemSelected;

  const CustomListTile({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.onTapCallback,
    required this.menuItems,
    required this.onMenuItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<ThemeProvider>(context).themeData;
    final colorScheme = themeData.colorScheme;
    final textTheme = themeData.textTheme;

    return ListTile(
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: true,
        style: TextStyle(
          color: colorScheme.onSecondaryContainer,
          fontSize: ThemeConstants.fontSizeMedium
        ),
      ),
      subtitle: Text(
        subTitle,
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: true,
        style: TextStyle(
          color: colorScheme.onSecondaryContainer,
          fontSize: ThemeConstants.fontSizeSmall,
        ),
      ),
      onTap: onTapCallback,
      trailing: PopupMenuButton<String>(
        icon: Icon(
          Icons.more_vert,
          color: colorScheme.onSecondaryContainer,
        ),
        onSelected: onMenuItemSelected,
        itemBuilder: (BuildContext context) => menuItems,
      ),
    );
  }
}