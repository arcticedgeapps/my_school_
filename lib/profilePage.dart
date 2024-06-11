import 'package:flutter/material.dart';
import 'package:my_school_life/Components/custom_app_bar.dart';
import 'package:my_school_life/Components/drawer_menu.dart';

class ProfilePage extends StatelessWidget {
  final double elementSpacing = 16.0; // Adjust this value to control spacing between elements
  final double elementWidth = 300.0;

  const ProfilePage({super.key}); // Adjust this value to control the width of elements

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Profile'),
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
                      'Profile',
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
                      'John Doe',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  width: elementWidth,
                  child: const Center(
                    child: Text(
                      'john.doe@example.com',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing * 2),
                SizedBox(
                  width: elementWidth,
                  child: _buildProfileField('Full Name', 'John Doe'),
                ),
                SizedBox(height: elementSpacing),
                SizedBox(
                  width: elementWidth,
                  child: _buildProfileField('Email', 'john.doe@example.com'),
                ),
                SizedBox(height: elementSpacing * 2),
                SizedBox(
                  width: elementWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add logic for editing the profile later
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
                      minimumSize: const Size(double.infinity, 50), // Width and Height
                      padding: const EdgeInsets.symmetric(horizontal: 20), // Horizontal padding
                      textStyle: const TextStyle(fontSize: 18), // Text size
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Straight border
                      ),
                    ),
                    child: const Text('Edit Profile'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8.0),
        TextFormField(
          initialValue: value,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          readOnly: true, // Make this read-only for now; can be editable in the future
        ),
      ],
    );
  }
}
