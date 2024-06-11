import 'package:flutter/material.dart';
import 'package:my_school_life/Components/custom_app_bar.dart';
import 'package:my_school_life/Components/drawer_menu.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  final double elementSpacing = 16.0; // Adjust this value to control spacing between elements
  final double elementWidth = 300.0; // Adjust this value to control the width of elements

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Services'),
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
                      'Services',
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
                      'Select a service from many trusted parents from this school.',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing),
                Wrap(
                  spacing: 16.0,
                  runSpacing: 16.0,
                  children: [
                    buildServiceButton('Automotive (2)', Icons.car_repair),
                    buildServiceButton('Community (2)', Icons.group),
                    buildServiceButton('Electrical (2)', Icons.electrical_services),
                    buildServiceButton('Home & Outdoors (2)', Icons.home),
                    buildServiceButton('Vacancies (2)', Icons.business_center),
                    buildServiceButton('Pets (2)', Icons.pets),
                    buildServiceButton('Real Estate (2)', Icons.real_estate_agent),
                    buildServiceButton('Maintenance (2)', Icons.build),
                    buildServiceButton('Medical (2)', Icons.local_hospital),
                    buildServiceButton('Law (2)', Icons.gavel),
                    buildServiceButton('Plumbing (2)', Icons.plumbing),
                    buildServiceButton('Hotel (2)', Icons.hotel),
                    buildServiceButton('Advertising (2)', Icons.ad_units),
                    buildServiceButton('Mechanic (2)', Icons.build_circle),
                    buildServiceButton('Landscaping (2)', Icons.park),
                    buildServiceButton('Storage (2)', Icons.store),
                    buildServiceButton('Travel Agent (2)', Icons.airplanemode_active),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildServiceButton(String title, IconData icon) {
    return Container(
      width: elementWidth / 2 - 8, // Adjust width to fit two buttons in a row with spacing
      height: 100,
      child: ElevatedButton(
        onPressed: () {
          // Add navigation or functionality
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.lightBlue, // Text color
          textStyle: const TextStyle(fontSize: 18), // Text size
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Rounded corners
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
