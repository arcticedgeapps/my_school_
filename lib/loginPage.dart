import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Components/custom_app_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    try {
      // Attempt to sign in with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // If successful, navigate to the homepage
      if (userCredential.user != null) {
        Navigator.of(context).pushReplacementNamed('/');
      }
    } catch (e) {
      // Show an error message if the login fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      appBar: const CustomAppBar(title: 'Login'), // Reusing CustomAppBar
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome Back!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Set the background color
                foregroundColor: Colors.white, // Set text color to white
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // Squared corners
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Add forgot password action
              },
              child: const Text('Forgot Password?'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/register');
              },
              child: const Text('Don\'t have an account? Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
