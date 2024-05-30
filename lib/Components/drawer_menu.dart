import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            leading: Icon(Icons.business),
            title: Text('Register Business'),
            onTap: () {
              Navigator.pushNamed(context, '/register-business');
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text('Contact My School Life'),
            onTap: () {
              Navigator.pushNamed(context, '/contact-my-school-life');
            },
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Add a School'),
            onTap: () {
              Navigator.pushNamed(context, '/add-school');
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About My School Life'),
            onTap: () {
              Navigator.pushNamed(context, '/about-my-school-life');
            },
          ),
        ],
      ),
    );
  }
}
