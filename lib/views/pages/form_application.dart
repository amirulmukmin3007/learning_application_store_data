import 'package:flutter/material.dart';
import 'package:learning_application_store_data/models/form_models.dart';
import 'package:learning_application_store_data/utils/components/custom_appbar.dart';

class FormApplicationPage extends StatefulWidget {
  const FormApplicationPage({super.key});

  @override
  State<FormApplicationPage> createState() => _FormApplicationPageState();
}

class _FormApplicationPageState extends State<FormApplicationPage> {
  bool isLoading = false;

  String selectedGender = '';
  List<String> genderList = ['Male', 'Female'];
  bool isRemoteSelected = false;
  bool isOnSiteSelected = false;
  bool hasTransport = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void submission() async {
    if (!formKey.currentState!.validate() || dateController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please fill in all the required fields.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final result = await submitFormApplication(
      nameController.text,
      selectedGender,
      isRemoteSelected,
      isOnSiteSelected,
      hasTransport,
      dateController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (result['status'] == true) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Form submitted successfully!'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Form Application Page'),
      backgroundColor: Color(0xFFFF6B6B), // Coral/orange background
      body: Stack(
        children: [
          SafeArea(
            child: Form(
              key: formKey,
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        // Form Application Header
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Form Application',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.description_outlined,
                                size: 30,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20),

                        // Form Container
                        Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              color: Color(0xFF4A4A4A), // Dark gray background
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Name Field
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Color(0xFFFFD700),
                                      width: 2,
                                    ), // Golden border
                                  ),
                                  child: TextFormField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      hintText: 'Name',
                                      hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 16,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 15,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),

                                SizedBox(height: 15),

                                // Gender Dropdown
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Color(0xFFFFD700),
                                      width: 2,
                                    ), // Golden border
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: selectedGender.isEmpty
                                        ? null
                                        : selectedGender,
                                    hint: Text(
                                      'Gender',
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 16,
                                      ),
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 15,
                                      ),
                                    ),
                                    items: genderList.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedGender = newValue!;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Color(0xFFFFD700),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select your gender';
                                      }
                                      return null;
                                    },
                                  ),
                                ),

                                SizedBox(height: 20),

                                // Work Type Checkboxes
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: isRemoteSelected,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                isRemoteSelected = value!;
                                              });
                                            },
                                            activeColor: Color(0xFFFFD700),
                                            checkColor: Colors.black,
                                            side: BorderSide(
                                              color: Color(0xFFFFD700),
                                            ),
                                          ),
                                          Text(
                                            'Remote',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: isOnSiteSelected,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                isOnSiteSelected = value!;
                                              });
                                            },
                                            activeColor: Color(0xFFFFD700),
                                            checkColor: Colors.black,
                                            side: BorderSide(
                                              color: Color(0xFFFFD700),
                                            ),
                                          ),
                                          Text(
                                            'On-Site',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 25),

                                // Transport Radio Buttons
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Radio(
                                            value: true,
                                            groupValue: hasTransport,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                hasTransport = value!;
                                              });
                                            },
                                            activeColor: Colors.white,
                                            fillColor: WidgetStateProperty.all(
                                              Colors.white,
                                            ),
                                          ),
                                          Text(
                                            'Has transport',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Radio<bool>(
                                            value: false,
                                            groupValue: hasTransport,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                hasTransport = value!;
                                              });
                                            },
                                            activeColor: Colors.white,
                                            fillColor: WidgetStateProperty.all(
                                              Colors.white,
                                            ),
                                          ),
                                          Text(
                                            'No transport',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 25),

                                // Date Label and Field
                                Text(
                                  'Date:',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 8),

                                InkWell(
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101),
                                    );

                                    if (pickedDate != null) {
                                      setState(() {
                                        dateController.text =
                                            '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Color(0xFFFFD700),
                                        width: 2,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          dateController.text.isEmpty
                                              ? 'Select Date'
                                              : dateController.text,
                                          style: TextStyle(
                                            color: dateController.text.isEmpty
                                                ? Colors.grey[400]
                                                : Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Icon(
                                          Icons.calendar_today,
                                          color: Color(0xFFFFD700),
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Spacer(),

                                // Submit Button
                                Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFD700), // Golden yellow
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      submission();
                                      print('Form submitted');
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.send,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Submit',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (isLoading)
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black.withOpacity(0.4),
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
