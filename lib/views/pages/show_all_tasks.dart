import 'package:flutter/material.dart';
import 'package:learning_application_store_data/utils/components/custom_appbar.dart';
import 'package:learning_application_store_data/utils/components/custom_listtile.dart';
import 'package:learning_application_store_data/utils/state_management/tasklist_provider.dart';
import 'package:provider/provider.dart';

class ShowAllTasks extends StatefulWidget {
  const ShowAllTasks({super.key});

  @override
  State<ShowAllTasks> createState() => _ShowAllTasksState();
}

class _ShowAllTasksState extends State<ShowAllTasks> {
  @override
  Widget build(BuildContext context) {
    TaskListProvider taskListProvider = Provider.of<TaskListProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xFFFF6D4D),
      appBar: CustomAppbar(title: 'Show All Tasks'),
      body: Column(
        children: [
          Center(
            child: Text(
              'All Tasks',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: taskListProvider.tasksList.length,
              itemBuilder: (context, index) {
                return CustomListtile(
                  title: taskListProvider.tasksList[index]['task_title'],
                  subtitle: taskListProvider.tasksList[index]['task_desc'],
                  trailing: taskListProvider.tasksList[index]['task_status'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
