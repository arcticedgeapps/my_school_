import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_school_life/Components/custom_app_bar.dart';
import 'package:my_school_life/Components/drawer_menu.dart';

class SchoolContactInfoPage extends StatelessWidget {
  final String schoolID;
  final double elementSpacing = 16.0;
  final double elementWidth = 300.0;

  SchoolContactInfoPage({super.key, required this.schoolID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'School Contact Info'),
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
          String number = schoolSnapshot['number'] ?? 'Phone Number';
          String email = schoolSnapshot['email'] ?? 'Email Address';
          String schoolAddress = schoolSnapshot['address'] ?? 'School Address';
          String facebookLink = schoolSnapshot['facebookLink'] ?? '';
          String instagramLink = schoolSnapshot['instagramLink'] ?? '';
          Color buttonColor = _parseColor(schoolSnapshot['buttonColor']);

          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
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
                      color: Colors.grey[300],
                      child: logoUrl.isNotEmpty
                          ? Image.network(
                              logoUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                    child: Text('Error loading logo'));
                              },
                            )
                          : Center(child: Text('No Logo Available')),
                    ),
                    SizedBox(height: elementSpacing),
                    Container(
                      width: elementWidth,
                      child: Center(
                        child: Text(
                          'Contact Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: elementSpacing),
                    Container(
                      width: elementWidth,
                      child: Center(
                        child: Column(
                          children: [
                            _buildDetailRow('Phone Number', number),
                            _buildDetailRow('Email', email),
                            _buildDetailRow('Address', schoolAddress),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: elementSpacing),
                    Container(
                      width: elementWidth,
                      child: Center(
                        child: Text(
                          'Social links:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: elementSpacing),
                    Container(
                      width: elementWidth,
                      child: ElevatedButton(
                        onPressed: facebookLink.isNotEmpty
                            ? () {
                                // Add navigation or functionality
                              }
                            : null,
                        child: const Text('Facebook'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: facebookLink.isNotEmpty
                              ? buttonColor
                              : Colors.grey,
                          minimumSize: const Size(double.infinity, 50),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          textStyle: const TextStyle(fontSize: 18),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: elementSpacing),
                    Container(
                      width: elementWidth,
                      child: ElevatedButton(
                        onPressed: instagramLink.isNotEmpty
                            ? () {
                                // Add navigation or functionality
                              }
                            : null,
                        child: const Text('Instagram'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: instagramLink.isNotEmpty
                              ? buttonColor
                              : Colors.grey,
                          minimumSize: const Size(double.infinity, 50),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          textStyle: const TextStyle(fontSize: 18),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                    ),
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

  Widget _buildDetailRow(String heading, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Center the heading
        children: [
          Text(
            '$heading:',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center, // Center the heading text
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center, // Center the content text
            softWrap: true,
            maxLines: null, // Allows text to wrap to the next line
            overflow: TextOverflow.visible, // Ensures all text is shown
          ),
        ],
      ),
    );
  }
}
