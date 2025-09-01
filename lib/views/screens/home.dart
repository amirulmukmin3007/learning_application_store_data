import 'package:flutter/material.dart';
import 'package:learning_application_store_data/models/task_models.dart';
import 'package:learning_application_store_data/utils/components/custom_appbar.dart';
import 'package:learning_application_store_data/utils/components/custom_listtile.dart';
import 'package:learning_application_store_data/utils/state_management/tasklist_provider.dart';
import 'package:learning_application_store_data/views/pages/show_all_tasks.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> result = {};
  List<dynamic> tasksList = [];
  List<dynamic> activeTasksList = [];
  List<dynamic> incompleteTasksList = [];
  String userId = '';
  bool status = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  void fetchTasks() async {
    setState(() {
      isLoading = true;
    });
    result = await getTasks();

    // get tasks list
    tasksList = result['tasks'];
    Provider.of<TaskListProvider>(
      context,
      listen: false,
    ).getTaskList(tasksList);

    // split tasks
    splitTasks(tasksList);

    // get user id
    userId = result['user_id'];

    // get status
    status = result['success'];

    setState(() {
      isLoading = false;
    });
  }

  void splitTasks(tasksList) {
    tasksList.forEach((task) {
      if (task['task_status'] == 'ACTIVE') {
        activeTasksList.add(task);
      } else if (task['task_status'] == 'INCOMPLETE') {
        incompleteTasksList.add(task);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF6D4D), // #FF6D4D
      appBar: CustomAppbar(title: 'Home'),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Kotak "Welcome, User!"
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: double.infinity,
                      height: 100,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Welcome, $userId!',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.account_circle),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ShowAllTasks()),
                      ),
                      child: Text('See All'),
                    ),

                    SizedBox(height: 20),

                    // Kotak "Task List"
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: double.infinity,
                      height: 500,
                      child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            TabBar(
                              labelColor: Colors.yellow,
                              unselectedLabelColor: Colors.white,
                              indicatorColor: Colors.yellow,
                              indicatorSize: TabBarIndicatorSize.tab,
                              tabs: [
                                Tab(text: 'To Do'),
                                Tab(text: 'Missed'),
                              ],
                            ),

                            Expanded(
                              child: TabBarView(
                                children: [
                                  ListView.builder(
                                    itemCount: activeTasksList.length,
                                    itemBuilder: (context, index) {
                                      return CustomListtile(
                                        title:
                                            activeTasksList[index]['task_title'],
                                        subtitle:
                                            activeTasksList[index]['task_desc'],
                                        trailing:
                                            activeTasksList[index]['task_status'],
                                      );
                                    },
                                  ),
                                  ListView.builder(
                                    itemCount: incompleteTasksList.length,
                                    itemBuilder: (context, index) {
                                      return CustomListtile(
                                        title:
                                            incompleteTasksList[index]['task_title'],
                                        subtitle:
                                            incompleteTasksList[index]['task_desc'],
                                        trailing:
                                            incompleteTasksList[index]['task_status'],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isLoading)
            Center(child: CircularProgressIndicator(color: Colors.yellow)),
        ],
      ),
    );
  }
}
