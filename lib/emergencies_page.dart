import 'package:flutter/material.dart';
import 'package:my_school_life/Components/custom_app_bar.dart';
import 'package:my_school_life/Components/drawer_menu.dart';

class EmergenciesPage extends StatelessWidget {
  const EmergenciesPage({super.key});

  final double elementSpacing = 16.0; // Adjust this value to control spacing between elements
  final double elementWidth = 300.0; // Adjust this value to control the width of elements

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Emergency Services'),
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
                      'Emergency services:',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: elementWidth,
                  height: 200, // Adjust the height as needed
                  child: const Center(
                    child: Image(
                      image: NetworkImage('https://example.com/emergency_icon.png'), // Replace with your image URL
                      height: 100,
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing),
                buildEmergencyContact('Fire department:', '0212345456'),
                SizedBox(height: elementSpacing),
                buildEmergencyContact('Hospital:', '0212345456'),
                SizedBox(height: elementSpacing),
                buildEmergencyContact('Police:', '0212345456'),
                SizedBox(height: elementSpacing),
                buildEmergencyContact('Pest Removal:', '0212345456'),
                SizedBox(height: elementSpacing),
                buildEmergencyContact('Snake Rescue:', '0212345456'),
                SizedBox(height: elementSpacing),
                buildEmergencyContact('Poison hotline:', '0212345456'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmergencyContact(String title, String contact) {
    return SizedBox(
      width: elementWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.0),
          Text(
            contact,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
