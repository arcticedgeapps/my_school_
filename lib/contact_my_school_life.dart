import 'package:flutter/material.dart';
import 'package:my_school_life/Components/custom_app_bar.dart';
import 'package:my_school_life/Components/drawer_menu.dart';

class ContactMySchoolLifePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Contact us'),
      drawer: DrawerMenu(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Text(
                'Contact us',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text(
                'Please be aware that Admin may take up to 4 working days to respond to all enquiries.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 16.0),
            _buildTextField('Your name'),
            SizedBox(height: 16.0),
            _buildTextField('Subject', maxLines: 4),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Add logic for form submission later
              },
              child: Text('Submit'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        SizedBox(height: 8.0),
        TextFormField(
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
