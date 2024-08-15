import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SubcategoryPage extends StatelessWidget {
  final String category;

  const SubcategoryPage({super.key, required this.category});

  Future<List<Map<String, dynamic>>> fetchSubcategories() async {
    final firestore = FirebaseFirestore.instance;
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    try {
      // Fetch the user's schoolID
      final userDoc = await firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        throw Exception('User document does not exist');
      }

      // Check if the schoolID field exists
      if (!userDoc.data()!.containsKey('schoolID')) {
        print('User document data: ${userDoc.data()}');
        throw Exception('User document is missing "schoolID" field');
      }

      final schoolID = userDoc['schoolID'];

      // Fetch school color
      final schoolDoc =
          await firestore.collection('schools').doc(schoolID).get();

      if (!schoolDoc.exists) {
        throw Exception('School document does not exist for $schoolID');
      }

      if (!schoolDoc.data()!.containsKey('buttonColor')) {
        print('School document data: ${schoolDoc.data()}');
        throw Exception('School document is missing "buttonColor" field');
      }

      final schoolColor = Color(int.parse(schoolDoc['buttonColor'], radix: 16));

      // Fetch subcategories where listingsCount > 0
      final snapshot = await firestore
          .collection('businesses')
          .where('mainCategory', isEqualTo: category)
          .where('schoolID',
              isEqualTo:
                  schoolID) // Ensure that we're querying for the specific school
          .where('listingsCount', isGreaterThan: 0)
          .get();

      List<Map<String, dynamic>> subcategories = [];
      for (var doc in snapshot.docs) {
        final subCategory = doc['subCategory'] as String;
        final listingsCount = doc['listingsCount'] as int;

        subcategories.add({
          'id': doc.id,
          'name': subCategory,
          'count': listingsCount,
          'color': schoolColor,
        });
      }
      return subcategories;
    } catch (e) {
      print('Error fetching subcategories: $e');
      throw e; // Re-throw to ensure the FutureBuilder captures the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$category Services')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchSubcategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading subcategories'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No subcategories available'));
          } else {
            final subcategories = snapshot.data!;
            return ListView.builder(
              itemCount: subcategories.length,
              itemBuilder: (context, index) {
                final subcategory = subcategories[index];
                return ListTile(
                  title: Text(
                    '${subcategory['name']} (${subcategory['count']})',
                    style: TextStyle(color: subcategory['color']),
                  ),
                  onTap: () {
                    // Handle subcategory selection
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
