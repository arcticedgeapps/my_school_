import 'package:flutter/material.dart';
import 'package:my_school_life/Components/custom_app_bar.dart';
import 'package:my_school_life/Components/drawer_menu.dart';
import 'package:my_school_life/NewsPage.dart';
import 'package:my_school_life/emergencies_page.dart';
import 'package:my_school_life/school_contact_info.dart';
import 'package:my_school_life/services_page.dart';

class SchoolNamePage extends StatelessWidget {
  final double elementSpacing = 16.0; // Adjust this value to control spacing between elements
  final double elementWidth = 300.0;

  const SchoolNamePage({super.key}); // Adjust this value to control the width of elements

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'My School Life'),
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
                      '[School Name]',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: elementWidth,
                  height: 200, // Adjust the height as needed
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Center(
                    child: Text('LOGO'),
                  ),
                ),
                SizedBox(height: elementSpacing),
                SizedBox(
                  width: elementWidth,
                  child: const Center(
                    child: Text(
                      'School information:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing),
                SizedBox(
                  width: elementWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SchoolContactInfoPage()),
                      );
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
                    child: const Text('Contact info'),
                  ),
                ),
                SizedBox(height: elementSpacing),
                SizedBox(
                  width: elementWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NewsPage()),
                      );
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
                    child: const Text('News'),
                  ),
                ),
                SizedBox(height: elementSpacing),
                SizedBox(
                  width: elementWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EmergenciesPage()),
                      );
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
                    child: const Text('Emergencies'),
                  ),
                ),
                SizedBox(height: elementSpacing),
                SizedBox(
                  width: elementWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ServicesPage()),
                      );
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
                    child: const Text('Services'),
                  ),
                ),
                SizedBox(height: elementSpacing),
                SizedBox(
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
                SizedBox(
                  width: elementWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add navigation or functionality
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.black, // Text color
                      minimumSize: const Size(double.infinity, 50), // Width and Height
                      padding: const EdgeInsets.symmetric(horizontal: 20), // Horizontal padding
                      textStyle: const TextStyle(fontSize: 18), // Text size
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Straight border
                      ),
                    ),
                    child: const Text('Facebook'),
                  ),
                ),
                SizedBox(height: elementSpacing),
                SizedBox(
                  width: elementWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add navigation or functionality
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.black, // Text color
                      minimumSize: const Size(double.infinity, 50), // Width and Height
                      padding: const EdgeInsets.symmetric(horizontal: 20), // Horizontal padding
                      textStyle: const TextStyle(fontSize: 18), // Text size
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Straight border
                      ),
                    ),
                    child: const Text('Instagram'),
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
