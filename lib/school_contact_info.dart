import 'package:flutter/material.dart';
import 'package:my_school_life/Components/custom_app_bar.dart';
import 'package:my_school_life/Components/drawer_menu.dart';

class SchoolContactInfoPage extends StatelessWidget {
  const SchoolContactInfoPage({Key? key}) : super(key: key);

  final double elementSpacing = 16.0; // Adjust this value to control spacing between elements
  final double elementWidth = 300.0; // Adjust this value to control the width of elements

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'School Contact Info'),
      drawer: const DrawerMenu(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: elementWidth,
                  child: const Center(
                    child: Text(
                      '[schoolName]', //copy in google sheet for ref
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: elementWidth,
                  height: 200, // Adjust the height as needed
                  color: Colors.grey[300],
                  child: const Center(
                    child: Text('[schoolLogo]'),
                  ),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: elementWidth,
                  child: const Center(
                    child: Text(
                      'Contact Details',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: elementWidth,
                  child: const Center(
                    child: Text(
                      '[phoneNumber]',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  width: elementWidth,
                  child: const Center(
                    child: Text(
                      '[email]',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  width: elementWidth,
                  child: const Center(
                    child: Text(
                      '[schoolAddress]',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: elementWidth,
                  child: const Center(
                    child: Text(
                      'Social links:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: elementWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add navigation or functionality
                    },
                    child: const Text('Facebook'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.lightBlue, // Text color
                      minimumSize: const Size(double.infinity, 50), // Width and Height
                      padding: const EdgeInsets.symmetric(horizontal: 20), // Horizontal padding
                      textStyle: const TextStyle(fontSize: 18), // Text size
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Straight border
                      ),
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: elementWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add navigation or functionality
                    },
                    child: const Text('Instagram'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 0, 176, 50), // Text color
                      minimumSize: const Size(double.infinity, 50), // Width and Height
                      padding: const EdgeInsets.symmetric(horizontal: 20), // Horizontal padding
                      textStyle: const TextStyle(fontSize: 18), // Text size
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Straight border
                      ),
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
