import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:learning_application_store_data/utils/route/api.dart';

Future<Map<String, dynamic>> submitFormApplication(
  String name,
  String gender,
  bool isRemoteSelected,
  bool isOnSiteSelected,
  bool hasTransport,
  String datetime,
) async {
  try {
    final response = await http.post(
      Uri.parse(Api.postFormApplication),
      body: {
        'name': name,
        'gender': gender,
        'remote': isRemoteSelected.toString(),
        'onsite': isOnSiteSelected.toString(),
        'transport': hasTransport.toString(),
        'date': datetime,
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

Future<Map<String, dynamic>> fetchFormApplication() async {
  try {
    final response = await http.get(Uri.parse(Api.getFormApplication));
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
