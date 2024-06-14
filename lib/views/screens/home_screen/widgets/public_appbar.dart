import 'package:flutter/material.dart';

class PublicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Function() onTap;
  final bool centerTitle;
  final bool leading;
  final List<Widget>? actions;
  final bool transparency;
  final bool checkPreferredSize;

  const PublicAppBar({
    super.key,
    required this.title,
    required this.onTap,
    this.centerTitle = true,
    this.leading = true,
    this.actions,
    this.transparency = true,
    this.checkPreferredSize = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: transparency,
      actions: actions,
      backgroundColor: Colors.white,
      leading: leading
          ? IconButton(
              onPressed: onTap,
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
              ),
            )
          : null,
      centerTitle: centerTitle,
      title: title,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
