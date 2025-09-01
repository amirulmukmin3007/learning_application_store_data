import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:learning_application_store_data/utils/components/custom_appbar.dart';
import 'package:permission_handler/permission_handler.dart';

class FormComplexPage extends StatefulWidget {
  const FormComplexPage({super.key});

  @override
  State<FormComplexPage> createState() => _FormComplexPageState();
}

class _FormComplexPageState extends State<FormComplexPage> {
  bool isLoading = false;

  // Form data
  File? selectedFile;
  File? capturedImage;
  String currentLocation = '';
  String currentTime = '';
  String selectedFileName = '';

  final ImagePicker _imagePicker = ImagePicker();

  // Get current time
  void getCurrentTime() {
    setState(() {
      final now = DateTime.now();
      currentTime =
          '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')}';
    });
  }

  // File picker
  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result != null) {
        setState(() {
          selectedFile = File(result.files.single.path!);
          selectedFileName = result.files.single.name;
        });
      }
    } catch (e) {
      _showErrorDialog('Error picking file: $e');
    }
  }

  // Camera capture
  Future<void> captureImage() async {
    try {
      // Request camera permission
      var status = await Permission.camera.request();
      if (status.isDenied) {
        _showErrorDialog('Camera permission is required');
        return;
      }

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          capturedImage = File(image.path);
        });
      }
    } catch (e) {
      _showErrorDialog('Error capturing image: $e');
    }
  }

  // Get current location
  Future<void> getCurrentLocation() async {
    try {
      setState(() {
        isLoading = true;
      });

      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          isLoading = false;
        });
        _showErrorDialog('Location services are disabled');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            isLoading = false;
          });
          _showErrorDialog('Location permissions are denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          isLoading = false;
        });
        _showErrorDialog('Location permissions are permanently denied');
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        currentLocation =
            'Lat: ${position.latitude.toStringAsFixed(6)}, Lng: ${position.longitude.toStringAsFixed(6)}';
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showErrorDialog('Error getting location: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text('Complex form data collected successfully!'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void submitComplexForm() {
    // Simple validation
    if (selectedFile == null &&
        capturedImage == null &&
        currentLocation.isEmpty &&
        currentTime.isEmpty) {
      _showErrorDialog('Please fill at least one field');
      return;
    }

    // Here you would normally send the data to your backend
    print('File: ${selectedFile?.path}');
    print('Image: ${capturedImage?.path}');
    print('Location: $currentLocation');
    print('Time: $currentTime');

    _showSuccessDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Form Complex Page'),
      backgroundColor: Color(0xFFFF6B6B), // Coral/orange background
      body: Stack(
        children: [
          SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // Form Complex Header
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
                              'Complex Form',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.settings_outlined,
                              size: 30,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),

                      // Form Container
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: Color(0xFF4A4A4A), // Dark gray background
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // File Upload Section
                            Text(
                              'File Upload:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xFFFFD700),
                                  width: 2,
                                ),
                              ),
                              child: InkWell(
                                onTap: pickFile,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 15,
                                        ),
                                        child: Text(
                                          selectedFileName.isEmpty
                                              ? 'Choose File'
                                              : selectedFileName,
                                          style: TextStyle(
                                            color: selectedFileName.isEmpty
                                                ? Colors.grey[400]
                                                : Colors.black,
                                            fontSize: 16,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(13),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFD700),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(6),
                                          bottomRight: Radius.circular(6),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.upload_file,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 20),

                            // Camera Section
                            Text(
                              'Camera:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFD700),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: InkWell(
                                onTap: captureImage,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Capture Photo',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Show captured image preview
                            if (capturedImage != null) ...[
                              SizedBox(height: 10),
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFFFFD700),
                                    width: 2,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.file(
                                    capturedImage!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],

                            SizedBox(height: 20),

                            // Location Section
                            Text(
                              'Location:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFD700),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: InkWell(
                                onTap: getCurrentLocation,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Get Current Location',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (currentLocation.isNotEmpty) ...[
                              SizedBox(height: 8),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFFFFD700),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  currentLocation,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],

                            SizedBox(height: 20),

                            // Current Time Section
                            Text(
                              'Current Time:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFD700),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: InkWell(
                                onTap: getCurrentTime,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Get Current Time',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (currentTime.isNotEmpty) ...[
                              SizedBox(height: 8),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFFFFD700),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  currentTime,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],

                            SizedBox(height: 30),

                            // Submit Button
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFD700),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: InkWell(
                                onTap: submitComplexForm,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.send,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Submit Complex Form',
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
                    ],
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
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text(
                      'Getting location...',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
