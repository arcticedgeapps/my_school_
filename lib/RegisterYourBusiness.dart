import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // For File class
import 'package:firebase_storage/firebase_storage.dart'; // For Firebase Storage
import 'package:path/path.dart'; // For basename function
import 'package:my_school_life/Components/custom_app_bar.dart';
import 'package:my_school_life/Components/drawer_menu.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My School Life',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: RegisterBusinessPage(),
    );
  }
}

class RegisterBusinessPage extends StatefulWidget {
  const RegisterBusinessPage({super.key});

  @override
  _RegisterBusinessPageState createState() => _RegisterBusinessPageState();
}

class _RegisterBusinessPageState extends State<RegisterBusinessPage> {
  final double elementSpacing =
      16.0; // Adjust this value to control spacing between elements
  final double elementWidth = 300.0;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _companyEmailController = TextEditingController();
  final TextEditingController _companyAddressController =
      TextEditingController();
  final TextEditingController _companyNumberController =
      TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _regNumberController = TextEditingController();

  String? _selectedMainCategory;
  String? _selectedSubCategory;
  String? _selectedSchool;
  String? _selectedSchoolID; // Store the selected school's ID
  bool _payNow = false;
  bool _requestEFT = false;
  bool _acceptTnC = false;
  String? _logoUrl;

  List<String> _schools = [];
  List<String> _subCategories = [];

  final Map<String, List<String>> _categories = {
    'Automotive': ['Car Repairs', 'Car Rentals'],
    'Community': ['Events', 'Volunteer'],
    'Electrical': ['Electricians', 'Appliance Repair'],
    'Home And Outdoors': ['Furniture', 'Gardening'],
    'Vacancies': ['Full-time', 'Part-time'],
    'Pets': ['Pet Grooming', 'Veterinary'],
    'Real Estate': ['Buy', 'Rent'],
    'Maintenance': ['Handyman', 'Cleaning'],
    'Medical': ['Doctors', 'Pharmacies'],
    'Law': ['Lawyers', 'Legal Advice'],
    'Advertising': ['Digital Marketing', 'Print'],
    'Mechanic': ['Engine Repairs', 'Diagnostics'],
    'Landscaping': ['Design', 'Maintenance'],
    'Storage': ['Personal Storage', 'Business Storage'],
    'Travel Agent': ['Domestic', 'International'],
  };

  @override
  void initState() {
    super.initState();
    _fetchSchools();
  }

  Future<void> _fetchSchools() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('schools').get();
      setState(() {
        _schools =
            snapshot.docs.map((doc) => doc['schoolName'] as String).toList();
      });
    } catch (e) {
      print('Error fetching schools: $e');
    }
  }

  Future<void> _fetchSchoolID(String schoolName) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('schools')
          .where('schoolName', isEqualTo: schoolName)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          _selectedSchoolID = snapshot.docs.first.id;
        });
      } else {
        print('No document found for school name: $schoolName');
      }
    } catch (e) {
      print('Error fetching school ID: $e');
    }
  }

  void _onMainCategoryChanged(String? newValue) {
    setState(() {
      _selectedMainCategory = newValue;
      _selectedSubCategory = null;
      _subCategories = newValue != null ? _categories[newValue]! : [];
    });
  }

  Future<void> _saveBusiness(BuildContext context) async {
    if (_formKey.currentState!.validate() && _selectedSchool != null) {
      try {
        await _firestore.collection('businesses').add({
          'companyName': _companyNameController.text,
          'companyEmail': _companyEmailController.text,
          'companyAddress': _companyAddressController.text,
          'companyNumber': _companyNumberController.text,
          'uploadLogo': _logoUrl,
          'about': _aboutController.text,
          'regNumber': _regNumberController.text,
          'mainCategory': _selectedMainCategory,
          'subCategory': _selectedSubCategory,
          'payNow': _payNow,
          'requestEFT': _requestEFT,
          'acceptTnC': _acceptTnC,
          'school': _selectedSchool,
          'schoolID': _selectedSchoolID, // Save the schoolID here
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Business registered successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register business: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Please fill all required fields and select a school')),
      );
    }
  }

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      String fileName = basename(pickedImage.path);

      try {
        TaskSnapshot snapshot = await FirebaseStorage.instance
            .ref('logos/$fileName')
            .putFile(imageFile);
        String downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          _logoUrl = downloadUrl;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logo uploaded successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload logo: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Register Your Business'),
      drawer: const DrawerMenu(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: elementWidth,
                    child: const Center(
                      child: Text(
                        'Enter your details',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: elementSpacing / 2),
                  SizedBox(
                    width: elementWidth,
                    child: const Center(
                      child: Text(
                        'List your company on the app for only\nR250/year..',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: elementSpacing),
                  SizedBox(
                    width: elementWidth,
                    child:
                        _buildTextField('Company name', _companyNameController),
                  ),
                  SizedBox(height: elementSpacing),
                  SizedBox(
                    width: elementWidth,
                    child: _buildTextField(
                        'Company email', _companyEmailController),
                  ),
                  SizedBox(height: elementSpacing),
                  SizedBox(
                    width: elementWidth,
                    child: _buildTextField(
                        'Company address', _companyAddressController),
                  ),
                  SizedBox(height: elementSpacing),
                  SizedBox(
                    width: elementWidth,
                    child: _buildTextField(
                        'Company number', _companyNumberController),
                  ),
                  SizedBox(height: elementSpacing),
                  SizedBox(
                    width: elementWidth,
                    child: ElevatedButton(
                      onPressed: () => _pickImage(context),
                      child: const Text('Upload Logo'),
                    ),
                  ),
                  if (_logoUrl != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.network(_logoUrl!),
                    ),
                  SizedBox(height: elementSpacing),
                  SizedBox(
                    width: elementWidth,
                    child:
                        _buildTextField('About', _aboutController, maxLines: 4),
                  ),
                  SizedBox(height: elementSpacing),
                  SizedBox(
                    width: elementWidth,
                    child: _buildTextField('Reg number', _regNumberController),
                  ),
                  SizedBox(height: elementSpacing),
                  SizedBox(
                    width: elementWidth,
                    child: DropdownButtonFormField(
                      value: _selectedSchool,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedSchool = newValue;
                        });
                        _fetchSchoolID(
                            newValue!); // Fetch the schoolID when a school is selected
                      },
                      decoration: const InputDecoration(
                        labelText: 'Select School',
                        border: OutlineInputBorder(),
                      ),
                      items: _schools.map((school) {
                        return DropdownMenuItem(
                          value: school,
                          child: Text(school),
                        );
                      }).toList(),
                      validator: (value) =>
                          value == null ? 'Please select a school' : null,
                    ),
                  ),
                  SizedBox(height: elementSpacing),
                  SizedBox(
                    width: elementWidth,
                    child: DropdownButtonFormField(
                      value: _selectedMainCategory,
                      onChanged: _onMainCategoryChanged,
                      decoration: const InputDecoration(
                        labelText: 'Main category',
                        border: OutlineInputBorder(),
                      ),
                      items: _categories.keys.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      validator: (value) => value == null
                          ? 'Please select a main category'
                          : null,
                    ),
                  ),
                  SizedBox(height: elementSpacing),
                  SizedBox(
                    width: elementWidth,
                    child: DropdownButtonFormField(
                      value: _selectedSubCategory,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedSubCategory = newValue;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Sub category',
                        border: OutlineInputBorder(),
                      ),
                      items: _subCategories.map((subCategory) {
                        return DropdownMenuItem(
                          value: subCategory,
                          child: Text(subCategory),
                        );
                      }).toList(),
                      validator: (value) =>
                          value == null ? 'Please select a sub category' : null,
                    ),
                  ),
                  SizedBox(height: elementSpacing),
                  SizedBox(
                    width: elementWidth,
                    child: const Center(
                      child: Text(
                        'Payments made through the app allow\nyour listing to go live instantly. EFT\npayments may delay your listing going\nlive as we will need to send you an\ninvoice manually.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  SizedBox(height: elementSpacing),
                  SizedBox(
                    width: elementWidth,
                    child: _buildCheckbox('Pay now', _payNow, (newValue) {
                      setState(() {
                        _payNow = newValue!;
                      });
                    }),
                  ),
                  SizedBox(
                    width: elementWidth,
                    child: _buildCheckbox('Request EFT invoice', _requestEFT,
                        (newValue) {
                      setState(() {
                        _requestEFT = newValue!;
                      });
                    }),
                  ),
                  SizedBox(
                    width: elementWidth,
                    child: _buildCheckbox('Accept T&C', _acceptTnC, (newValue) {
                      setState(() {
                        _acceptTnC = newValue!;
                      });
                    }),
                  ),
                  SizedBox(height: elementSpacing),
                  SizedBox(
                    width: elementWidth,
                    child: ElevatedButton(
                      onPressed: () => _saveBusiness(context),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green, // Text color
                        minimumSize:
                            const Size(double.infinity, 50), // Width and Height
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20), // Horizontal padding
                        textStyle: const TextStyle(fontSize: 18), // Text size
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero, // Straight border
                        ),
                      ),
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          validator: (value) => value == null || value.isEmpty
              ? 'This field cannot be empty'
              : null,
        ),
      ],
    );
  }

  Widget _buildCheckbox(
      String label, bool value, ValueChanged<bool?> onChanged) {
    return Row(
      children: [
        Expanded(child: Text(label, style: const TextStyle(fontSize: 16))),
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
