import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:learning_application_store_data/utils/route/api.dart';

Future<Map<String, dynamic>> getTasks() async {
  try {
    final response = await http.get(Uri.parse(Api.getTaskDataAmanda));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {};
    }
  } catch (e) {
    print(e);
    return {};
  }
}

Future<Map<String, dynamic>> postFormCreateTask(
  userId,
  taskTitle,
  taskDescription,
) async {
  try {
    final response = await http.post(
      Uri.parse(Api.postFormCreateTask),
      body: {
        'user_id': userId,
        'task_title': taskTitle,
        'task_desc': taskDescription,
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {};
    }
  } catch (e) {
    print(e);
    return {};
  }
}
