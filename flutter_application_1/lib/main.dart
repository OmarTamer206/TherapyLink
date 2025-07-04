import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/emergency_session_ended.dart';
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
final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

void main() {

    FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint('Error Caught by FlutterError: ${details.exception}');
    debugPrint('Stack trace:\n${details.stack}');
  };


  runApp(TherapyLinkApp());
}

class TherapyLinkApp extends StatelessWidget {
  TherapyLinkApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TherapyLink',
      debugShowCheckedModeBanner: false,
initialRoute: '/login',
navigatorObservers: [routeObserver],
   routes: {
  '/login': (context) => const LoginPage(),
  '/signup': (context) => const SignUpPage(),
  '/home': (context) => const HomePage(),
  '/profile': (context) => const ProfilePage(),
  '/edit-profile': (context) => const EditProfilePage(),
  '/sessions': (context) =>  SessionsPage(),
  '/journal': (context) => const MyJournalPage(),
  '/chatbot': (context) => ChatBotWelcomePage(),
  '/sessionEnded': (context) => SessionEndedPage(),
},

    );
  }
}