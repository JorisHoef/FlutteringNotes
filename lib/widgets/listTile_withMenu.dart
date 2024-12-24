import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_strings.dart';
import '../themes/theme_provider.dart';
import 'custom_listTile.dart';

class ListTileWithMenu extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ListTileWithMenu({
    super.key,
    required this.title,
    required this.subTitle,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    TextTheme textTheme = themeProvider.themeData.textTheme;

    return CustomListTile(
      title: title,
      subTitle: subTitle,
      onTapCallback: onEdit ?? () {},
      menuItems: [
        if (onEdit != null)
          PopupMenuItem<String>(
            value: AppStrings.editText,
            child: Text(
              AppStrings.editText,
              style: textTheme.bodySmall?.copyWith(
                color: themeProvider.themeData.colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        if (onDelete != null)
          PopupMenuItem<String>(
            value: AppStrings.deleteText,
            child: Text(
              AppStrings.deleteText,
              style: textTheme.bodySmall?.copyWith(
                color: themeProvider.themeData.colorScheme.onPrimaryContainer,
              ),
            ),
          ),
      ],
      onMenuItemSelected: (value) {
        if (value == AppStrings.editText && onEdit != null) {
          onEdit!();
        } else if (value == AppStrings.deleteText && onDelete != null) {
          onDelete!();
        }
      },
    );
  }
}