import 'package:flutter/material.dart';
import 'package:learning_application_store_data/utils/components/custom_navbar.dart';
import 'package:learning_application_store_data/views/pages/form_create_task.dart';
import 'package:learning_application_store_data/views/screens/form_page.dart';
import 'package:learning_application_store_data/views/screens/home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  List<Widget> screens = [Home(), FormCreateTask()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: CustomNavbar(
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        currentIndex: currentIndex,
      ),
    );
  }
}
