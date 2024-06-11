import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double elementSpacing = 16.0;
    final double elementWidth = 300.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        backgroundColor: Colors.green, // Customize the AppBar color if needed
      ),
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
                      'Latest news letter:',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing),
                Container(
                  width: elementWidth,
                  height: 200, // Adjust the height as needed
                  color: Colors.grey[300],
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.picture_as_pdf,
                          size: 50,
                        ),
                        Text('PDF'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: elementSpacing),
                SizedBox(
                  width: elementWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add functionality to open PDF
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.black, // Text color
                      textStyle: const TextStyle(fontSize: 18), // Text size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // Rounded corners
                      ),
                      minimumSize: const Size(double.infinity, 50), // Width and Height
                    ),
                    child: const Text('Open PDF'),
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
