import 'package:flutter/material.dart';
import 'package:learning_application_store_data/utils/state_management/tasklist_provider.dart';
import 'package:learning_application_store_data/views/screens/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskListProvider>(
          create: (_) => TaskListProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Widgets Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(),
    );
  }
}
