import 'package:flutter/material.dart';
import 'package:my_school_life/Components/custom_app_bar.dart';
import 'package:my_school_life/Components/drawer_menu.dart';

class AddSchoolPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Register a school'),
      drawer: DrawerMenu(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Text(
                'Register a school',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Text(
                'Please contact the following e-mail in order to get started to add a school',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text(
                'myschoollife@edu.com',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Text(
                'Please send us the following information:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text(
                'School name\nYour relation to the school\nYour name and surname',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
