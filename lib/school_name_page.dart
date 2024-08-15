import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_school_life/Components/custom_app_bar.dart';
import 'package:my_school_life/Components/drawer_menu.dart';
import 'package:my_school_life/NewsPage.dart';
import 'package:my_school_life/emergencies_page.dart';
import 'package:my_school_life/school_contact_info.dart';
import 'package:my_school_life/services_page.dart'; // Import the ServicesPage

class SchoolNamePage extends StatelessWidget {
  final String schoolID;
  final double elementSpacing = 16.0;
  final double elementWidth = 300.0;

  SchoolNamePage({
    Key? key,
    required this.schoolID,
    required String schoolName,
    required String logoUrl,
    required String buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'My School Life'),
      drawer: const DrawerMenu(),
      body: FutureBuilder<DocumentSnapshot>(
        future: _fetchSchoolData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('School not found'));
          }

          DocumentSnapshot schoolSnapshot = snapshot.data!;
          String schoolName = schoolSnapshot['schoolName'] ?? 'School Name';
          String logoUrl = schoolSnapshot['logoUrl'] ?? '';
          Color buttonColor = _parseColor(schoolSnapshot['buttonColor']);

          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: elementWidth,
                      child: Center(
                        child: Text(
                          schoolName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: elementSpacing),
                    Container(
                      width: elementWidth,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        image: logoUrl.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(logoUrl),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: logoUrl.isEmpty
                          ? Center(child: Text('No Logo Available'))
                          : null,
                    ),
                    SizedBox(height: elementSpacing),
                    SizedBox(
                      width: elementWidth,
                      child: const Center(
                        child: Text(
                          'School information:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: elementSpacing),
                    _buildButton(
                      label: 'Contact info',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SchoolContactInfoPage(schoolID: schoolID),
                          ),
                        );
                      },
                      color: buttonColor,
                    ),
                    SizedBox(height: elementSpacing),
                    _buildButton(
                      label: 'News',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsPage(schoolID: schoolID),
                          ),
                        );
                      },
                      color: buttonColor,
                    ),
                    SizedBox(height: elementSpacing),
                    _buildButton(
                      label: 'Emergencies',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EmergenciesPage(schoolID: schoolID),
                          ),
                        );
                      },
                      color: buttonColor,
                    ),
                    SizedBox(height: elementSpacing),
                    _buildButton(
                      label: 'Services', // New Services button
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ServicesPage(schoolID: schoolID),
                          ),
                        );
                      },
                      color: buttonColor,
                    ),
                    SizedBox(height: elementSpacing),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<DocumentSnapshot> _fetchSchoolData() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('schools')
          .doc(schoolID)
          .get();
      return snapshot;
    } catch (e) {
      throw Exception('Error fetching school data: $e');
    }
  }

  Color _parseColor(String? colorString) {
    if (colorString != null && colorString.isNotEmpty) {
      return Color(int.parse(colorString, radix: 16) | 0xFF000000);
    }
    return Colors.green; // Default color if not specified
  }

  Widget _buildButton({
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return SizedBox(
      width: elementWidth,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: color,
          minimumSize: const Size(double.infinity, 50),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          textStyle: const TextStyle(fontSize: 18),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
