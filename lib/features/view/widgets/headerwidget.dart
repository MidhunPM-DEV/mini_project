import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onPressed;
  const HeaderWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF00C368),
      centerTitle: true,
      title:
          Text("Contacts", style: Theme.of(context).appBarTheme.titleTextStyle),
      actions: [
        IconButton(
            onPressed: onPressed, icon: const Icon(Icons.person_add_alt_1))
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
