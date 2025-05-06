import 'package:flutter/material.dart';
import 'package:mobile_app/screens/appointment_screen/appointment_screen.dart';
import 'package:mobile_app/screens/chatbot_screen.dart';
import 'package:mobile_app/screens/chatting_screen.dart';
import 'package:mobile_app/screens/check_out_screen.dart';
import 'package:mobile_app/screens/doctor_s_one_screen.dart';
import 'package:mobile_app/screens/doctors_screen/doctors_screen.dart';
import 'package:mobile_app/screens/home_screen.dart';
import 'package:mobile_app/screens/journal_screen/journal_screen.dart';
import 'package:mobile_app/screens/payment_screen.dart';
import 'package:mobile_app/screens/sessions_screen/sessions_screen.dart';
import 'package:mobile_app/screens/sign_in_log_in.dart';
import 'package:mobile_app/screens/sign_up_screen.dart';


class AppNavigationScreen extends StatelessWidget {
  const AppNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE1F1F6),
      body: SafeArea(
        child: SizedBox(
          width: 375,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(color: Color(0xffE1F1F6)),
                child: const Column(
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "App Navigation",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 20,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Check the app's UI",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff888888),
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Divider(height: 1, thickness: 1, color: Color(0xff000000)),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(color: Color(0xffE1F1F6)),
                    child: Column(
                      children: [
                        _buildScreenTitle(
                          context,
                          screenTitle: "Sign up",
                          onTapScreenTitle: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  SignUpScreen()),
                          ),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Sign in",
                          onTapScreenTitle: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  SignInLogInScreen()),
                          ),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Home",
                          onTapScreenTitle: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  HomeScreen()),
                          ),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Chat Bot",
                          onTapScreenTitle: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ChatbotScreen()),
                          ),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Chatting",
                          onTapScreenTitle: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ChattingScreen()),
                          ),
                        ),
                         _buildScreenTitle(
                          context,
                          screenTitle: "Sessions",
                          onTapScreenTitle: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SessionsScreen()),
                          ),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Doctors",
                          onTapScreenTitle: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const DoctorsScreen()),
                          ),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Doctor's One",
                          onTapScreenTitle: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const DoctorSOneScreen()),
                          ),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Appointment",
                          onTapScreenTitle: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AppointmentScreen()),
                          ),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Check out",
                          onTapScreenTitle: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CheckOutScreen()),
                          ),
                        ),
                         _buildScreenTitle(
                          context,
                          screenTitle: "Payment",
                          onTapScreenTitle: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PaymentScreen()),
                          ),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Journal",
                          onTapScreenTitle: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  JournalScreen()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScreenTitle(
    BuildContext context, {
    required String screenTitle,
    Function? onTapScreenTitle,
  }) {
    return GestureDetector(
      onTap: () {
        onTapScreenTitle?.call();
      },
      child: Container(
        decoration: const BoxDecoration(color: Color(0XFFFFFFFF)),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                screenTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xff000000),
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 5),
            const Divider(height: 1, thickness: 1, color: Color(0xff888888)),
          ],
        ),
      ),
    );
  }
}