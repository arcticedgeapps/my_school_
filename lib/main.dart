import 'package:flutter/material.dart';
import 'package:my_school_life/Components/custom_app_bar.dart';
import 'package:my_school_life/Components/drawer_menu.dart';
import 'package:my_school_life/RegisterYourBusiness.dart';
import 'package:my_school_life/about_my_school_life.dart';
import 'package:my_school_life/add_a_school.dart';
import 'package:my_school_life/contact_my_school_life.dart';
import 'package:my_school_life/profilePage.dart';
import 'package:my_school_life/settingPage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/profile': (context) => ProfilePage(),
        '/settings': (context) => SettingsPage(),
        '/register-business': (context) => RegisterBusinessPage(),
        '/contact-my-school-life': (context) => ContactMySchoolLifePage(),
        '/add-school': (context) => AddSchoolPage(),
        '/about-my-school-life': (context) => AboutMySchoolLifePage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final double elementSpacing = 25.0; // Adjust this value to control spacing between elements

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'My School Life'),
      drawer: DrawerMenu(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  child: Text(
                    'Welcome [Name]',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: 300,
                  child: Icon(
                    Icons.touch_app,
                    size: 100,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: 300,
                  child: Text(
                    'What is this app for? This app is to grow awareness around services offered by parents.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: 300,
                  height: 200,
                  color: Colors.grey[300],
                  child: Center(
                    child: Icon(
                      Icons.play_circle_outline,
                      size: 50,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: 300,
                  child: Text(
                    'Search and add a school:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: 300,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Hoërskool Noordheuwel',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add school logic here
                    },
                    child: Text('Add School'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.green, // Text color
                      minimumSize: Size(double.infinity, 50), // Width and Height
                      padding: EdgeInsets.symmetric(horizontal: 20), // Horizontal padding
                      textStyle: TextStyle(fontSize: 18), // Text size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Straight border
                      ),
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: 300,
                  child: Align(
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
