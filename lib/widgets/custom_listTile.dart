import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../themes/theme_provider.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String? subTitle;
  final VoidCallback onTapCallback;
  final List<PopupMenuEntry<String>> menuItems;
  final void Function(String) onMenuItemSelected;
  final Widget? leadingWidget;
  final TextStyle? textStyleTitle;
  final TextStyle? textStyleSubTitle;

  const CustomListTile({
    Key? key,
    required this.title,
    this.subTitle,
    required this.onTapCallback,
    required this.menuItems,
    required this.onMenuItemSelected,
    this.leadingWidget,
    this.textStyleTitle,
    this.textStyleSubTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<ThemeProvider>(context).themeData;
    final colorScheme = themeData.colorScheme;
    final textTheme = themeData.textTheme;

    return ListTile(
      leading: leadingWidget,
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: true,
        style: textStyleTitle?.copyWith(
          color: colorScheme.onPrimaryContainer,
        )
      ),
      subtitle: subTitle != null
          ? Text(
        subTitle!,
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: true,
        style: textStyleSubTitle?.copyWith(
          color: colorScheme.onSecondaryContainer,
        ),
      )
          : null,
      onTap: onTapCallback,
      trailing: PopupMenuButton<String>(
        icon: Icon(
          Icons.more_vert,
          color: colorScheme.onPrimaryContainer,
        ),
        color: colorScheme.primaryContainer,
        onSelected: onMenuItemSelected,
        itemBuilder: (BuildContext context) => menuItems,
      ),
    );
  }
}