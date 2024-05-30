import 'package:flutter/material.dart';
import 'package:my_school_life/Components/custom_app_bar.dart';
import 'package:my_school_life/Components/drawer_menu.dart';
import 'package:my_school_life/RegisterYourBusiness.dart';
import 'package:my_school_life/add_a_school.dart';
import 'package:my_school_life/profilePage.dart';
import 'package:my_school_life/settingPage.dart';
import 'contact_my_school_life.dart';
import 'about_my_school_life.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
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

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My School Life',
      ),
      drawer: DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                'Welcome [Name]',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Image.asset(
                'assets/images/logojpeg.jpg',
                width: 160,
                height: 160,
              ),
              SizedBox(height: 20),
              Text(
                'What is this app for? This app is to grow awareness around services offered by parents.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Container(
                color: Colors.grey[300],
                width: 300,
                height: 150,
                child: Icon(
                  Icons.play_circle_outline,
                  size: 50,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Search and add a school:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Hoërskool Noordheuwel',
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                    color: Colors.green,
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text('Add School'),
              ),
              SizedBox(height: 20),
              Text(
                'Added schools:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // You can add the list of added schools here
            ],
          ),
        ),
      ),
    );
  }
}



  