import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 20, 117, 197), // Set background color to blue
      body: Center(
        child: ClipOval(
          child: Image.asset(
            'assets/logo.png', // Ganti dengan nama file gambar Anda
            width: 150.0, // Set width of the circle
            height: 150.0, // Set height of the circle
            fit: BoxFit.cover, // Ensure the image fits within the circle
          ),
        ),
      ),
    );
  }
}
