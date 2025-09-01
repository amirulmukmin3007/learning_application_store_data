import 'package:flutter/material.dart';
import 'package:learning_application_store_data/models/form_models.dart';
import 'package:learning_application_store_data/utils/components/custom_appbar.dart';
import 'package:learning_application_store_data/utils/components/custom_listtile.dart';

class ShowFormApplication extends StatefulWidget {
  const ShowFormApplication({super.key});

  @override
  State<ShowFormApplication> createState() => _ShowFormApplicationState();
}

class _ShowFormApplicationState extends State<ShowFormApplication> {
  bool isLoading = false;
  Map<String, dynamic> result = {};
  List<dynamic> tasksList = [];
  bool status = false;

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  void fetchTasks() async {
    setState(() {
      isLoading = true;
    });
    result = await fetchFormApplication();
    tasksList = result['forms'];
    status = result['success'];
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF6D4D),
      appBar: CustomAppbar(title: 'Show Form Application'),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.all(5.0),
              padding: EdgeInsets.all(10.0),
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  'Form Application',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasksList.length,
              itemBuilder: (context, index) {
                return CustomListtile(
                  title: tasksList[index]['name'],
                  subtitle: tasksList[index]['date'],
                  trailing: 'Has Transport : ${tasksList[index]['transport']}',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
