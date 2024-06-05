import 'package:flutter/material.dart';
import 'package:my_school_life/Components/custom_app_bar.dart';
import 'package:my_school_life/Components/drawer_menu.dart';

class ProfilePage extends StatelessWidget {
  final double elementSpacing = 16.0; // Adjust this value to control spacing between elements
  final double elementWidth = 300.0; // Adjust this value to control the width of elements

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile'),
      drawer: DrawerMenu(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: elementWidth,
                  child: Center(
                    child: Text(
                      'Profile',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: elementWidth,
                  child: Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://example.com/profile.jpg'), // Replace with your profile image URL
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: elementWidth,
                  child: Center(
                    child: Text(
                      'John Doe',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  width: elementWidth,
                  child: Center(
                    child: Text(
                      'john.doe@example.com',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing * 2),
                Container(
                  width: elementWidth,
                  child: _buildProfileField('Full Name', 'John Doe'),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: elementWidth,
                  child: _buildProfileField('Email', 'john.doe@example.com'),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: elementWidth,
                  child: _buildProfileField('Phone', '+1 234 567 890'),
                ),
                SizedBox(height: elementSpacing * 2),
                Container(
                  width: elementWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add logic for editing the profile later
                    },
                    child: Text('Edit Profile'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
                      minimumSize: Size(double.infinity, 50), // Width and Height
                      padding: EdgeInsets.symmetric(horizontal: 20), // Horizontal padding
                      textStyle: TextStyle(fontSize: 18), // Text size
                      shape: RoundedRectangleBorder(
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

  Widget _buildProfileField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        TextFormField(
          initialValue: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          readOnly: true, // Make this read-only for now; can be editable in the future
        ),
      ],
    );
  }
}
