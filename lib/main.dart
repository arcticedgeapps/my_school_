import 'package:flutter/material.dart';
// Import SchoolNamePage
import 'package:my_school_life/Components/custom_app_bar.dart';
import 'package:my_school_life/Components/drawer_menu.dart';
import 'package:my_school_life/RegisterYourBusiness.dart';
import 'package:my_school_life/about_my_school_life.dart';
import 'package:my_school_life/add_a_school.dart';
import 'package:my_school_life/contact_my_school_life.dart';
import 'package:my_school_life/profilePage.dart';
import 'package:my_school_life/school_name_page.dart';
import 'package:my_school_life/settingPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/settings': (context) => const SettingsPage(),
        '/register-business': (context) => const RegisterBusinessPage(),
        '/contact-my-school-life': (context) => const ContactMySchoolLifePage(),
        '/add-school': (context) => const AddSchoolPage(),
        '/about-my-school-life': (context) => const AboutMySchoolLifePage(),
        '/school-name': (context) => const SchoolNamePage(), // Add this route
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final double elementSpacing = 16.0; // Adjust this value to control spacing between elements
  final double elementWidth = 300.0;

  const HomePage({super.key}); // Adjust this value to control the width of elements

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'My School Life'),
      drawer: const DrawerMenu(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: elementWidth,
                  child: const Center(
                    child: Text(
                      'Welcome [Name]',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing),
                SizedBox(
                  width: elementWidth,
                  child: const Icon(
                    Icons.touch_app,
                    size: 100,
                    color: Colors.green,
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
                  height: 200, // Adjust the height as needed
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
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing),
                SizedBox(
                  width: elementWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/school-name'); // Navigate to SchoolNamePage
                    }, //We need to add a pop up to let the user know if there are no results and what to do.
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.green, // Text color
                      minimumSize: const Size(double.infinity, 50), // Width and Height
                      padding: const EdgeInsets.symmetric(horizontal: 20), // Horizontal padding
                      textStyle: const TextStyle(fontSize: 18), // Text size
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Straight border
                      ),
                    ),
                    child: const Text('Add School'),
                  ),
                ),
                SizedBox(height: elementSpacing),
                SizedBox(
                  width: elementWidth,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Added schools:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                // Add list of added schools here
              ],
            ),
          ),
        ),
      ),
    );
  }
}
