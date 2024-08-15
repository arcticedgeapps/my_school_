import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_school_life/settingPage.dart';
import 'add_a_school.dart';
import 'contact_my_school_life.dart';
import 'loginPage.dart';
import 'register_page.dart'; // Import your registration page here
import 'school_name_page.dart';
import 'Components/drawer_menu.dart';
import 'RegisterYourBusiness.dart'; // Keep your existing imports

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "",
      projectId: "my-school-life-c707a",
      storageBucket: "my-school-life-c707a.appspot.com",
      messagingSenderId: "711670113190",
      appId: "1:711670113190:android:b7c6505757d0ecd8d86567",
      measurementId: "G-P903QDEMSK",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My School Life',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white, // Set background color to white
      ),
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/register' : '/',
      routes: {
        '/': (context) => const HomePage(),
        '/school-name': (context) => SchoolNamePage(
              schoolName: '',
              logoUrl: '',
              buttonColor: '',
              schoolID: '',
            ),
        '/register-business': (context) => const RegisterBusinessPage(),
        '/register': (context) => const RegistrationPage(),
        '/login': (context) => const LoginPage(),
        '/settings': (context) => const SettingsPage(), // Added Settings route
        '/contact': (context) =>
            const ContactMySchoolLifePage(), // Added Contact My School Life route
        '/add-school': (context) =>
            const AddSchoolPage(), // Added Add School route
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double elementSpacing = 16.0;
  final double elementWidth = 300.0;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> _searchResults = [];
  List<Map<String, String>> _addedSchools = [];
  bool _showSuggestions = true;
  String? _userName;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        setState(() {
          _userName = userDoc['name'];
          _addedSchools = (userDoc['addedSchools'] as List<dynamic>)
              .map((school) => {
                    'schoolName': school['schoolName'] as String,
                    'schoolID': school['schoolID'] as String,
                  })
              .toList();
        });
      }
    }
  }

  Future<String?> _getSchoolID(String schoolName) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('schools')
          .where('schoolName', isEqualTo: schoolName)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.id;
      } else {
        print('No document found for school name: $schoolName');
        return null;
      }
    } catch (e) {
      print('Error fetching school ID: $e');
      return null;
    }
  }

  void _addToAddedSchools(String schoolName, String schoolID) async {
    setState(() {
      _addedSchools.add({'schoolName': schoolName, 'schoolID': schoolID});
    });
    await _saveAddedSchools();
  }

  void _removeFromAddedSchools(int index) async {
    setState(() {
      _addedSchools.removeAt(index);
    });
    await _saveAddedSchools();
  }

  Future<void> _saveAddedSchools() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'addedSchools': _addedSchools,
      });
    }
  }

  Future<void> _fetchSchoolNames(String query) async {
    _searchResults.clear();
    print('Fetching school names for query: $query');

    if (query.isNotEmpty) {
      try {
        QuerySnapshot snapshot = await _firestore
            .collection('schools')
            .where('schoolName', isGreaterThanOrEqualTo: query)
            .where('schoolName', isLessThanOrEqualTo: query + '\uf8ff')
            .orderBy('schoolName')
            .get();

        print('Documents fetched: ${snapshot.docs.length}');

        setState(() {
          _searchResults =
              snapshot.docs.map((doc) => doc['schoolName'] as String).toList();
          _showSuggestions = _searchResults.isNotEmpty;
          print('Search Results: $_searchResults'); // Print results to console
        });
      } catch (e) {
        print('Error fetching school names: $e');
        setState(() {
          _showSuggestions = false;
        });
      }
    } else {
      setState(() {
        _showSuggestions = false;
      });
    }
  }

  Widget _buildSchoolCard(String schoolName, String schoolID, int index) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        title: Text(
          schoolName,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            decoration: TextDecoration.underline,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.close, color: Colors.red),
          onPressed: () {
            _removeFromAddedSchools(index);
          },
        ),
        onTap: () async {
          try {
            DocumentSnapshot snapshot =
                await _firestore.collection('schools').doc(schoolID).get();

            if (snapshot.exists) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SchoolNamePage(
                    schoolName: snapshot['schoolName'],
                    logoUrl: snapshot['logoUrl'],
                    buttonColor: snapshot['buttonColor'],
                    schoolID: schoolID,
                  ),
                ),
              );
            } else {
              print('School document for $schoolID not found');
            }
          } catch (e) {
            print('Error fetching school data: $e');
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome ${_userName ?? '[Name]'}')),
      drawer: DrawerMenu(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: elementWidth,
                  child: Image.asset(
                    'assets/images/logo.png', // Replace with your logo asset
                    height: 100,
                    width: 100,
                  ),
                ),
                SizedBox(height: elementSpacing),
                SizedBox(
                  width: elementWidth,
                  child: const Text(
                    'What is this app for? This app is to grow awareness around services offered by parents.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: elementWidth,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Center(
                    child: Text('LOGO'),
                  ),
                ),
                SizedBox(height: elementSpacing),
                SizedBox(
                  width: elementWidth,
                  child: const Center(
                    child: Text(
                      'School information:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing),

                // Search field
                SizedBox(
                  width: elementWidth,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: elementSpacing),
                    child: TextField(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      onChanged: (value) {
                        _fetchSchoolNames(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search for a school...',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            _fetchSchoolNames(_searchController.text);
                          },
                        ),
                      ),
                    ),
                  ),
                ), // Added schools section
                if (_showSuggestions && _searchResults.isNotEmpty)
                  SizedBox(
                    width: elementWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Search Results',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          width: elementWidth,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white, // Adjust background color
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: _searchResults
                                .map(
                                  (schoolName) => ListTile(
                                    title: Text(schoolName),
                                    onTap: () async {
                                      String? schoolID =
                                          await _getSchoolID(schoolName);
                                      if (schoolID != null) {
                                        _searchController.text = schoolName;
                                        setState(() {
                                          _searchResults.clear();
                                          _showSuggestions = false;
                                          _addToAddedSchools(
                                              schoolName, schoolID);
                                        });
                                      }
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ), // Display added schools as cards
                SizedBox(
                  width: elementWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16), // Padding above added schools
                      const Text(
                        'Added schools:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _addedSchools
                            .asMap()
                            .entries
                            .map((entry) => _buildSchoolCard(
                                  entry.value['schoolName']!,
                                  entry.value['schoolID']!,
                                  entry.key,
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: elementSpacing),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
