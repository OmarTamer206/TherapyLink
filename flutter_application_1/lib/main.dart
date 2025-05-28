import 'package:flutter/material.dart';
import 'pages/HomePage.dart';           // Home Page
import 'pages/feedback_page.dart';       // Feedback Page
import 'pages/profile_page.dart';        // Profile Page
import 'pages/edit_profile_page.dart';   // Edit Profile Page
import 'pages/sessions_page.dart';       // Sessions Page
import 'pages/my_journal_page.dart';     // My Journal Page
import 'pages/chatbot_welcome.dart'; 
import 'pages/login.dart';      // Add this
import 'pages/signup.dart';  
   // Add this
// ChatBot Welcome Page

void main() {
  runApp(const TherapyLinkApp());
}

class TherapyLinkApp extends StatelessWidget {
  const TherapyLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TherapyLink',
      debugShowCheckedModeBanner: false,
initialRoute: '/login',
   routes: {
  '/login': (context) => const LoginPage(),
  '/signup': (context) => const SignUpPage(),
  '/home': (context) => const HomePage(),
  '/feedback': (context) => const FeedbackPage(),
  '/profile': (context) => const ProfilePage(),
  '/edit-profile': (context) => const EditProfilePage(),
  '/sessions': (context) => const SessionsPage(),
  '/journal': (context) => const MyJournalPage(),
  '/chatbot': (context) => ChatBotWelcomePage(),
},

    );
  }
}