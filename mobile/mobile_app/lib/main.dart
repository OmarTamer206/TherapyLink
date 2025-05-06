import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/screens/app_navigation_screen.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xFFE1F1F6), // Your primary color
    statusBarIconBrightness: Brightness.dark, // White icons
  ));
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TherapyLink',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const AppNavigationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
