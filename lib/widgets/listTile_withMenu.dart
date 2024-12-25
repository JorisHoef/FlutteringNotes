import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_strings.dart';
import '../providers/theme_provider.dart';
import 'custom_listTile.dart';

class ListTileWithMenu extends StatelessWidget {
  final String title;
  final String? subTitle;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final Widget? leadingWidget;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;

  const ListTileWithMenu({
    super.key,
    required this.title,
    this.subTitle,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.leadingWidget,
    this.titleStyle,
    this.subTitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    TextTheme textTheme = themeProvider.themeData.textTheme;

    return CustomListTile(
      title: title,
      subTitle: subTitle,
      onTapCallback: onTap ?? () {},
      leadingWidget: leadingWidget,
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
      textStyleTitle: titleStyle,
      textStyleSubTitle: subTitleStyle,
    );
  }
}