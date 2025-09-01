import 'package:flutter/material.dart';

class TaskListProvider extends ChangeNotifier {
  List<dynamic> _tasksList = [];

  List<dynamic> get tasksList => _tasksList;

  void getTaskList(List<dynamic> taskList) {
    _tasksList = taskList;
    notifyListeners();
  }
}
