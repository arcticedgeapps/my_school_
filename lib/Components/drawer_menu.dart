import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final double elementSpacing = 16.0;

  const DrawerMenu({super.key}); // Adjust this value to control spacing between elements

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Center(
              child: Text(
                'My school life',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          _buildDrawerItem(
            context,
            text: 'Home',
            routeName: '/',
          ),
          _buildDrawerItem(
            context,
            text: 'Profile',
            routeName: '/profile',
          ),
          _buildDrawerItem(
            context,
            text: 'Settings',
            routeName: '/settings',
          ),
          _buildDrawerItem(
            context,
            text: 'Register Business',
            routeName: '/register-business',
          ),
          _buildDrawerItem(
            context,
            text: 'Contact My School Life',
            routeName: '/contact-my-school-life',
          ),
          _buildDrawerItem(
            context,
            text: 'Add a School',
            routeName: '/add-school',
          ),
          _buildDrawerItem(
            context,
            text: 'About My School Life',
            routeName: '/about-my-school-life',
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, {required String text, required String routeName}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: elementSpacing / 2),
      child: ListTile(
        title: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
      ),
    );
  }
}
