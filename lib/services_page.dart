import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Components/custom_app_bar.dart';
import 'Components/drawer_menu.dart';
import 'Pages/subcategories.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key, required this.schoolID});

  final String schoolID;
  final double elementSpacing = 16.0;
  final double elementWidth = 300.0;

  Future<Map<String, int>> fetchServiceCounts() async {
    final firestore = FirebaseFirestore.instance;

    try {
      final snapshot = await firestore
          .collection('businesses')
          .where('schoolID', isEqualTo: schoolID)
          .get();

      print('Documents fetched: ${snapshot.docs.length}');

      Map<String, int> serviceCounts = {};
      for (var doc in snapshot.docs) {
        String category = doc['mainCategory'];
        serviceCounts[category] = (serviceCounts[category] ?? 0) + 1;
      }
      return serviceCounts;
    } catch (e) {
      print('Error fetching service counts: $e');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Services'),
      drawer: const DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center horizontally
            children: [
              SizedBox(height: 20), // Optional space from the top
              Center(
                child: SizedBox(
                  width: elementWidth,
                  child: const Text(
                    'Services',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: elementSpacing),
              Center(
                child: SizedBox(
                  width: elementWidth,
                  child: const Text(
                    'Select a service from many trusted parents from this school.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: elementSpacing),
              FutureBuilder<Map<String, int>>(
                future: fetchServiceCounts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Error loading services');
                  } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                    return const Text('No services available.');
                  } else {
                    final serviceCounts = snapshot.data ?? {};
                    return Wrap(
                      spacing: 16.0,
                      runSpacing: 16.0,
                      alignment: WrapAlignment.center, // Center the wrap
                      children: buildServiceButtons(
                          context, serviceCounts, Colors.green),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildServiceButtons(
      BuildContext context, Map<String, int> serviceCounts, Color schoolColor) {
    List<Map<String, dynamic>> services = [
      {'title': 'Automotive', 'icon': Icons.car_repair},
      {'title': 'Community', 'icon': Icons.group},
      {'title': 'Electrical', 'icon': Icons.electrical_services},
      {'title': 'Home & Outdoors', 'icon': Icons.home},
      {'title': 'Vacancies', 'icon': Icons.business_center},
      {'title': 'Pets', 'icon': Icons.pets},
      {'title': 'Real Estate', 'icon': Icons.real_estate_agent},
      {'title': 'Maintenance', 'icon': Icons.build},
      {'title': 'Medical', 'icon': Icons.local_hospital},
      {'title': 'Law', 'icon': Icons.gavel},
      {'title': 'Plumbing', 'icon': Icons.plumbing},
      {'title': 'Hotel', 'icon': Icons.hotel},
      {'title': 'Advertising', 'icon': Icons.ad_units},
      {'title': 'Mechanic', 'icon': Icons.build_circle},
      {'title': 'Landscaping', 'icon': Icons.park},
      {'title': 'Storage', 'icon': Icons.store},
      {'title': 'Travel Agent', 'icon': Icons.airplanemode_active},
    ];

    // Filter services to show only those with listings
    return services.where((service) {
      String title = service['title'];
      return serviceCounts.containsKey(title);
    }).map((service) {
      String title = service['title'];
      IconData icon = service['icon'];
      int count = serviceCounts[title] ?? 0;
      return buildServiceButton(context, title, icon, count, schoolColor);
    }).toList();
  }

  Widget buildServiceButton(BuildContext context, String title, IconData icon,
      int count, Color schoolColor) {
    return Container(
      width: elementWidth / 2 - 8,
      height: 100,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubcategoryPage(category: title),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: schoolColor,
          textStyle: const TextStyle(fontSize: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            SizedBox(height: 8),
            Text(
              '$title ($count)',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
