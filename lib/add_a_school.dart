import 'package:flutter/material.dart';
import 'package:my_school_life/Components/custom_app_bar.dart';
import 'package:my_school_life/Components/drawer_menu.dart';

class AddSchoolPage extends StatelessWidget {
  final double elementSpacing = 16.0; // Adjust this value to control spacing between elements
  final double elementWidth = 300.0;

  const AddSchoolPage({super.key}); // Adjust this value to control the width of elements

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Register a school'),
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
                      'Register a school',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing),
                SizedBox(
                  width: elementWidth,
                  child: const Center(
                    child: Text(
                      'Please contact the following e-mail in order to get started to add a school',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing / 2),
                SizedBox(
                  width: elementWidth,
                  child: const Center(
                    child: Text(
                      'myschoollife@edu.com',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing),
                SizedBox(
                  width: elementWidth,
                  child: const Center(
                    child: Text(
                      'Please send us the following information:',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing / 2),
                SizedBox(
                  width: elementWidth,
                  child: const Center(
                    child: Text(
                      'School name\nYour relation to the school\nYour name and surname',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
