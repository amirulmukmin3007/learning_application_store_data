import 'package:flutter/material.dart';
import 'package:learning_application_store_data/models/form_models.dart';
import 'package:learning_application_store_data/models/task_models.dart';
import 'package:learning_application_store_data/utils/components/custom_appbar.dart';
import 'package:learning_application_store_data/utils/state_management/tasklist_provider.dart';
import 'package:learning_application_store_data/utils/state_management/userdata_provider.dart';
import 'package:provider/provider.dart';

class FormCreateTask extends StatefulWidget {
  const FormCreateTask({super.key});

  @override
  State<FormCreateTask> createState() => _FormCreateTaskState();
}

class _FormCreateTaskState extends State<FormCreateTask> {
  Map<String, dynamic> result = {};
  TextEditingController userIdController = TextEditingController();
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    userIdController.text = Provider.of<UserDataProvider>(
      context,
      listen: false,
    ).userId;
  }

  Future<void> submitForm() async {
    setState(() {
      isLoading = true;
    });

    result = await postFormCreateTask(
      userIdController.text,
      taskTitleController.text,
      taskDescriptionController.text,
    );

    if (result['success'] == true) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Task created successfully!'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF6B6B),
      appBar: CustomAppbar(title: 'Form Create Task'),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Form Create Task',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: userIdController,
                            decoration: const InputDecoration(
                              labelText: 'User ID',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: taskTitleController,
                            decoration: const InputDecoration(
                              labelText: 'Task Title',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: taskDescriptionController,
                            decoration: const InputDecoration(
                              labelText: 'Task Description',
                              border: OutlineInputBorder(),
                            ),
                            maxLines: null,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        submitForm();
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: isLoading,
            child: Center(
              child: CircularProgressIndicator(color: Colors.yellow),
            ),
          ),
        ],
      ),
    );
  }
}
