import 'package:flutter/material.dart';
import 'package:mobile_app/screens/app_navigation_screen.dart';
import 'package:mobile_app/screens/appointment_of_life_coach_screen/appointment_of_life_coach_screen.dart';
import 'package:mobile_app/screens/appointment_screen/appointment_screen.dart';
import 'package:mobile_app/screens/chatbot_screen.dart';
import 'package:mobile_app/screens/chatting_screen.dart';
import 'package:mobile_app/screens/check_out_of_life_coach_screen.dart';
import 'package:mobile_app/screens/check_out_screen/check_out_screen.dart';
import 'package:mobile_app/screens/doctor_s_one_screen.dart';
import 'package:mobile_app/screens/doctors_screen/doctors_screen.dart';
import 'package:mobile_app/screens/edit_profile_screen.dart';
import 'package:mobile_app/screens/home_screen.dart';
import 'package:mobile_app/screens/journal_screen/journal_screen.dart';
import 'package:mobile_app/screens/life_coach_s_screen.dart';
import 'package:mobile_app/screens/life_coaches_screen/life_coaches_screen.dart';
import 'package:mobile_app/screens/old_sessions_rate_screen.dart';
import 'package:mobile_app/screens/sign_in_log_in.dart';
import 'package:mobile_app/screens/sign_up_screen.dart';

class AppRoutes {
  static const String signUpScreen = '/sign_up_screen';

  static const String sessionsScreen = '/sessions_screen';

  static const String sessionsInitialPage = '/sessions_initial_page';

  static const String doctorsScreen = '/doctors_screen';

  static const String doctorSOneScreen = '/doctor_s_one_screen';

  static const String appointmentScreen = '/appointment_screen';

  static const String checkOutScreen = '/check_out_screen';

  static const String paymentScreen = '/payment_screen';

  static const String journalScreen = '/journal_screen';

  static const String profileScreen = '/profile_screen';

  static const String editProfileScreen = '/edit_profile_screen';

  static const String signInLogInScreen = '/sign_in_log_in_screen';

  static const String homeScreen = '/home_screen';

  static const String chatbotScreen = '/chatbot_screen';

  static const String chattingScreen = '/chatting_screen';

  static const String upcomingSessionsScreen = '/upcoming_sessions_screen';

  static const String upcomingSessionsVideoScreen =
      '/upcoming_sessions_video_screen';

  static const String upcomingSessionsChatScreen =
      '/upcoming_sessions_chat_screen';

  static const String oldSessionsScreen = '/old_sessions_screen';

  static const String oldSessionsRateScreen = '/old_sessions_rate_screen';

  static const String checkOutOfLifeCoachScreen =
      '/check_out_of_life_coach_screen';

  static const String paymentLifeCoachScreen = '/payment_life_coach_screen';

  static const String typeOfTherapistScreen = '/type_of_therapist_screen';

  static const String lifeCoachesScreen = '/life_coaches_screen';

  static const String lifeCoachSScreen = '/life_coach_s_screen';

  static const String appointmentOfLifeCoachScreen =
      '/appointment_of_life_coach_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    signUpScreen: (context) => SignUpScreen(),
    //sessionsScreen: (context) => SessionsScreen(),
    doctorsScreen: (context) => const DoctorsScreen(),
    doctorSOneScreen: (context) => const DoctorSOneScreen(),
    appointmentScreen: (context) => const AppointmentScreen(),
    checkOutScreen: (context) => const CheckOutScreen(),
    //paymentScreen: (context) => PaymentScreen(),
    journalScreen: (context) => const JournalScreen(),
    //profileScreen: (context) => ProfileScreen(),
    editProfileScreen: (context) => const EditProfileScreen(),
    signInLogInScreen: (context) => SignInLogInScreen(),
    homeScreen: (context) => HomeScreen(),
    chatbotScreen: (context) => const ChatbotScreen(),
    chattingScreen: (context) => ChattingScreen(),
    //upcomingSessionsScreen: (context) => UpcomingSessionsScreen(),
    //upcomingSessionsVideoScreen: (context) => UpcomingSessionsVideoScreen(),
    //upcomingSessionsChatScreen: (context) => UpcomingSessionsChatScreen(),
    //oldSessionsScreen: (context) => OldSessionsScreen(),
    oldSessionsRateScreen: (context) => const OldSessionsRateScreen(),
    checkOutOfLifeCoachScreen: (context) => const CheckOutOfLifeCoachScreen(),
    //paymentLifeCoachScreen: (context) => PaymentLifeCoachScreen(),
    //typeOfTherapistScreen: (context) => TypeOfTherapistScreen(),
    lifeCoachesScreen: (context) => const LifeCoachesScreen(),
    lifeCoachSScreen: (context) => const LifeCoachSScreen(),
    appointmentOfLifeCoachScreen: (context) => const AppointmentOfLifeCoachScreen(),
    appNavigationScreen: (context) => const AppNavigationScreen(),
    initialRoute: (context) => SignUpScreen(),
  };
}
