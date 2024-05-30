import 'package:flutter/material.dart';
import 'package:my_school_life/Components/custom_app_bar.dart';
import 'package:my_school_life/Components/drawer_menu.dart';

class AboutMySchoolLifePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'About My School Life'),
      drawer: DrawerMenu(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Text(
                'About My School Life',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Text(
                'My School Life is an app designed to help students, parents, and educators manage and engage with school activities more effectively. With features like registering businesses, contacting school administration, and adding new schools, the app aims to provide a comprehensive platform for all school-related needs.',
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
