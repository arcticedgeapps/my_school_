import 'package:flutter/material.dart';
import 'package:my_school_life/Components/custom_app_bar.dart';
import 'package:my_school_life/Components/drawer_menu.dart';

class RegisterBusinessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Register Your Business'),
      drawer: DrawerMenu(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Text(
                'Register my business',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text(
                'List your company on the app for only\nR250/year..',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 16.0),
            _buildTextField('Company name'),
            SizedBox(height: 16.0),
            _buildTextField('Company email'),
            SizedBox(height: 16.0),
            _buildTextField('Company address'),
            SizedBox(height: 16.0),
            _buildTextField('Company number'),
            SizedBox(height: 16.0),
            _buildTextField('Upload logo'),
            SizedBox(height: 16.0),
            _buildTextField('About', maxLines: 4),
            SizedBox(height: 16.0),
            _buildTextField('Reg number'),
            SizedBox(height: 16.0),
            _buildTextField('Main category'),
            SizedBox(height: 16.0),
            _buildTextField('Sub category'),
            SizedBox(height: 16.0),
            Center(
              child: Text(
                'Payments made through the app allow\nyour listing to go live instantly. EFT\npayments may delay your listing going\nlive as we will need to send you an\ninvoice manually.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(height: 16.0),
            _buildCheckbox('Pay now'),
            _buildCheckbox('Request EFT invoice'),
            _buildCheckbox('Accept T&C\'s'),
            SizedBox(height: 16.0),
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

  Widget _buildCheckbox(String label) {
    return Row(
      children: [
        Expanded(child: Text(label, style: TextStyle(fontSize: 16))),
        Checkbox(
          value: false,
          onChanged: (value) {
            // Add logic for checkbox state change later
          },
        ),
      ],
    );
  }
}
