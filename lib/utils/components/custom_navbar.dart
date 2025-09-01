import 'package:flutter/material.dart';

class CustomNavbar extends StatelessWidget {
  const CustomNavbar({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  final Function(int) onTap;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: currentIndex,
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Form'),
      ],
    );
  }
}
