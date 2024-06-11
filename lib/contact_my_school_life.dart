import 'package:flutter/material.dart';
import 'package:my_school_life/Components/custom_app_bar.dart';
import 'package:my_school_life/Components/drawer_menu.dart';

class ContactMySchoolLifePage extends StatelessWidget {
  final double elementSpacing = 16.0; // Adjust this value to control spacing between elements
  final double elementWidth = 300.0;

  const ContactMySchoolLifePage({super.key}); // Adjust this value to control the width of elements

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Contact us'),
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
                      'Fill out the form',
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
                      'Please be aware that Admin may take up to 4 working days to respond to all enquiries.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing),
                SizedBox(
                  width: elementWidth,
                  child: _buildTextField('Your name'),
                ),
                SizedBox(height: elementSpacing),
                SizedBox(
                  width: elementWidth,
                  child: _buildTextField('Subject', maxLines: 4),
                ),
                SizedBox(height: elementSpacing * 2),
                SizedBox(
                  width: elementWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add logic for form submission later
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.green, // Text color
                      minimumSize: const Size(double.infinity, 50), // Width and Height
                      padding: const EdgeInsets.symmetric(horizontal: 20), // Horizontal padding
                      textStyle: const TextStyle(fontSize: 18), // Text size
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Straight border
                      ),
                    ),
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8.0),
        TextFormField(
          maxLines: maxLines,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
