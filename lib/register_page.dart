import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _schoolFocusNode = FocusNode();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> _schoolSearchResults = [];
  String? _selectedSchoolID; // Variable to store the selected school's ID

  Future<void> _searchSchool(String query) async {
    if (query.isNotEmpty) {
      QuerySnapshot snapshot = await _firestore
          .collection('schools')
          .where('schoolName', isGreaterThanOrEqualTo: query)
          .where('schoolName', isLessThanOrEqualTo: query + '\uf8ff')
          .orderBy('schoolName')
          .get();

      setState(() {
        _schoolSearchResults = snapshot.docs.map((doc) {
          return doc['schoolName'] as String;
        }).toList();
      });
    } else {
      setState(() {
        _schoolSearchResults.clear();
      });
    }
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim());

        // Fetch the schoolID based on the selected school name
        DocumentSnapshot schoolSnapshot = await _firestore
            .collection('schools')
            .where('schoolName', isEqualTo: _schoolController.text.trim())
            .limit(1)
            .get()
            .then((snapshot) => snapshot.docs.first);

        _selectedSchoolID = schoolSnapshot.id;

        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'name': _nameController.text.trim(),
          'surname': _surnameController.text.trim(),
          'email': _emailController.text.trim(),
          'school': _schoolController.text.trim(),
          'schoolID': _selectedSchoolID, // Store the schoolID
          'addedSchools': [
            {
              'schoolName': _schoolController.text.trim(),
              'schoolID': _selectedSchoolID
            }
          ], // Add the selected school
        });

        // Navigate to the home page after successful registration
        Navigator.of(context).pushReplacementNamed('/');
      } catch (e) {
        print('Registration failed: $e');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Registration failed: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                const Text(
                  'My School Life',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _surnameController,
                  decoration: InputDecoration(labelText: 'Surname'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your surname';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _schoolController,
                  focusNode: _schoolFocusNode,
                  decoration: InputDecoration(labelText: 'School'),
                  onChanged: (value) {
                    _searchSchool(value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your school';
                    }
                    return null;
                  },
                ),
                if (_schoolSearchResults.isNotEmpty)
                  Container(
                    height: 100,
                    child: ListView.builder(
                      itemCount: _schoolSearchResults.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_schoolSearchResults[index]),
                          onTap: () async {
                            setState(() {
                              _schoolController.text =
                                  _schoolSearchResults[index];
                              _schoolSearchResults.clear();
                              _schoolFocusNode.unfocus();
                            });

                            // Fetch and store the schoolID when a school is selected
                            DocumentSnapshot schoolSnapshot = await _firestore
                                .collection('schools')
                                .where('schoolName',
                                    isEqualTo: _schoolController.text.trim())
                                .limit(1)
                                .get()
                                .then((snapshot) => snapshot.docs.first);

                            _selectedSchoolID = schoolSnapshot.id;
                          },
                        );
                      },
                    ),
                  ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0), // Squared corners
                    ),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                  child: const Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 40),
                Image.asset(
                  'assets/images/logo.png', // Use the provided asset
                  width: 100,
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
