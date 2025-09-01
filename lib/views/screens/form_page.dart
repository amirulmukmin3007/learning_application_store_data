import 'package:flutter/material.dart';
import 'package:learning_application_store_data/utils/components/custom_appbar.dart';
import 'package:learning_application_store_data/utils/components/custom_button.dart';
import 'package:learning_application_store_data/views/pages/form_application.dart';
import 'package:learning_application_store_data/views/pages/form_complex.dart';
import 'package:learning_application_store_data/views/pages/show_form_application.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Form'),
      body: Container(
        color: Color(0xFFFF6D4D),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FormApplicationPage(),
                      ),
                    );
                  },
                  title: 'Form Application',
                  icon: Icons.note,
                  color: Colors.yellow,
                ),
                CustomButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FormComplexPage(),
                      ),
                    );
                  },
                  title: 'Form Complex',
                  icon: Icons.file_copy,
                  color: Colors.green,
                ),
                CustomButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowFormApplication(),
                      ),
                    );
                  },
                  title: 'Show Form Application',
                  icon: Icons.list,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
