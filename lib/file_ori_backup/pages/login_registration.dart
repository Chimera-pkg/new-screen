import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginRegistrationPage extends StatelessWidget {
  const LoginRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'skribeX',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Colors.white70,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal, // Set to transparent
        elevation: 0, // Remove the shadow
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.teal, // Choose your gradient start color
              Colors.indigo, // Choose your gradient end color
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Gradient separator line
                  Container(
                    height: 2,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.green, // Customize gradient start color
                          Colors.orange, // Customize gradient end color
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Your logo or app name widget here
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    // Replace the following line with your logo/image
                    child: SvgPicture.asset(
                      'assets/icons/logo.svg',
                      width: 60,
                      height: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Your login form widget here
                  LoginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Email input field
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: const Icon(Icons.email),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.green),
              borderRadius: BorderRadius.circular(12.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Password input field
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: const Icon(Icons.lock),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.circular(12.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 16),
        // Login button
        ElevatedButton(
          onPressed: () {
            // Implement your login logic here
          },
          child: Text('Login'),
        ),
        const SizedBox(height: 16),
        // Or login with social media buttons
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialMediaButton(iconPath: 'assets/icons/google_icon.svg'),
            SizedBox(width: 16),
            SocialMediaButton(iconPath: 'assets/icons/apple_icon.svg'),
          ],
        ),
        const SizedBox(height: 16),
        // Register link
        GestureDetector(
          onTap: () {
            // Navigate to registration page
            // Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
          },
          child: const Text(
            'Don\'t have an account? Register here.',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  final String iconPath;

  const SocialMediaButton({super.key, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgPicture.asset(iconPath, width: 30, height: 30),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: LoginRegistrationPage(),
  ));
}
