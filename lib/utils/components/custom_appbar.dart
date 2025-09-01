import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.yellow,
      title: Text(title),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 10, 0),
          child: Image.asset('assets/ke_logo.png', width: 30),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
