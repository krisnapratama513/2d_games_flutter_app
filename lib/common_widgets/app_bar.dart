import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;

  const CustomAppBar({super.key, required this.titleText});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        titleText,
        style: const TextStyle(
          // color: Color(0xFFDCD7C9),
          color: Color(0xFFABD1C6),
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xFF282823),
      centerTitle: true,
      iconTheme: const IconThemeData(
        color: Color(0xFFDCD7C9),
      ),
      elevation: 4, // Nilai elevation tetap 4 sesuai default
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
