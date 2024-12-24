import 'package:flutter/material.dart';

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
    return ListTile(
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: true,
      ),
      subtitle: Text(
        subTitle,
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: true,
      ),
      onTap: onTapCallback,
      trailing: PopupMenuButton<String>(
        icon: Icon(Icons.more_vert),
        onSelected: onMenuItemSelected,
        itemBuilder: (BuildContext context) => menuItems,
      ),
    );
  }
}