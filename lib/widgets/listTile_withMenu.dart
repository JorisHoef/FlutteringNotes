import 'package:flutter/material.dart';

import '../constants/app_strings.dart';
import 'custom_listTile.dart';

class ListTileWithMenu extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  //final List<VoidCallback> hank;

  const ListTileWithMenu({
    super.key,
    required this.title,
    required this.subTitle,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: title,
      subTitle: subTitle,
      onTapCallback: onEdit ?? () {},
      menuItems: [
        if (onEdit != null)
          PopupMenuItem<String>(
            value: AppStrings.editText,
            child: Text(AppStrings.editText),
          ),
        if (onDelete != null)
          PopupMenuItem<String>(
            value: AppStrings.deleteText,
            child: Text(AppStrings.deleteText),
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