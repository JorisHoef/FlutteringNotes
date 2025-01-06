import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import 'custom_animatedWidget.dart';

class CustomListTile extends StatefulWidget {
  final String title;
  final String? subTitle;
  final VoidCallback onTapCallback;
  final List<PopupMenuEntry<String>> menuItems;
  final void Function(String) onMenuItemSelected;
  final Widget? leadingWidget;
  final TextStyle? textStyleTitle;
  final TextStyle? textStyleSubTitle;

  const CustomListTile({
    super.key,
    required this.title,
    this.subTitle,
    required this.onTapCallback,
    required this.menuItems,
    required this.onMenuItemSelected,
    this.leadingWidget,
    this.textStyleTitle,
    this.textStyleSubTitle,
  });

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final themeData = context.watch<ThemeProvider>().themeData;
    final colorScheme = themeData.colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: ListTile(
        leading: widget.leadingWidget,
        title: Text(
          widget.title,
          maxLines: 1,
          overflow: TextOverflow.fade,
          softWrap: true,
          style: widget.textStyleTitle?.copyWith(
            color: colorScheme.onPrimaryContainer,
          ),
        ),
        subtitle: widget.subTitle != null
            ? Text(
                widget.subTitle!,
                maxLines: 1,
                overflow: TextOverflow.fade,
                softWrap: true,
                style: widget.textStyleSubTitle?.copyWith(
                  color: colorScheme.onSecondaryContainer,
                ),
              )
            : null,
        onTap: widget.onTapCallback,
        trailing: CustomAnimatedWidget(
          hovering: _hovering,
          child: PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: colorScheme.onPrimaryContainer,
            ),
            color: colorScheme.primaryContainer,
            onSelected: widget.onMenuItemSelected,
            itemBuilder: (BuildContext context) => widget.menuItems,
          ),
        ),
      ),
    );
  }
}
