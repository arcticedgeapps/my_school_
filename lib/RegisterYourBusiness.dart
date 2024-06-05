import 'package:flutter/material.dart';
import 'package:my_school_life/Components/custom_app_bar.dart';
import 'package:my_school_life/Components/drawer_menu.dart';

class RegisterBusinessPage extends StatelessWidget {
  final double elementSpacing = 16.0; // Adjust this value to control spacing between elements
  final double elementWidth = 300.0; // Adjust this value to control the width of elements

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Register Your Business'),
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
                      'Enter your details',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing / 2),
                Container(
                  width: elementWidth,
                  child: Center(
                    child: Text(
                      'List your company on the app for only\nR250/year..',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: elementWidth,
                  child: _buildTextField('Company name'),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: elementWidth,
                  child: _buildTextField('Company email'),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: elementWidth,
                  child: _buildTextField('Company address'),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: elementWidth,
                  child: _buildTextField('Company number'),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: elementWidth,
                  child: _buildTextField('Upload logo'),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: elementWidth,
                  child: _buildTextField('About', maxLines: 4),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: elementWidth,
                  child: _buildTextField('Reg number'),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: elementWidth,
                  child: _buildTextField('Main category'),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: elementWidth,
                  child: _buildTextField('Sub category'),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: elementWidth,
                  child: Center(
                    child: Text(
                      'Payments made through the app allow\nyour listing to go live instantly. EFT\npayments may delay your listing going\nlive as we will need to send you an\ninvoice manually.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: elementWidth,
                  child: _buildCheckbox('Pay now'),
                ),
                Container(
                  width: elementWidth,
                  child: _buildCheckbox('Request EFT invoice'),
                ),
                Container(
                  width: elementWidth,
                  child: _buildCheckbox('Accept T&C\'s'),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: elementWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add logic for form submission later
                    },
                    child: Text('Submit'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.green, // Text color
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
