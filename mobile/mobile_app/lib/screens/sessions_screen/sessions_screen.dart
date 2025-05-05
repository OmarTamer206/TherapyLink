// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mobile_app/screens/sessions_screen/sessions_initial_page.dart';
import 'package:mobile_app/widgets/custom_button_bar.dart';

class SessionsScreen extends StatelessWidget {
  SessionsScreen({super.key});

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              Expanded(
                child: Navigator(
                  key: navigatorKey,
                  onGenerateRoute: (routeSetting) => PageRouteBuilder(
                    pageBuilder: (ctx, ani, ani1) =>
                        getCurrentPage(routeSetting.name!),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                  initialRoute: 'sessionsInitialPage',
                ),
              ),
            ],
          ),
        ),
      ),
     bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomBottomBar(
        onChanged: (BottomBarEnum type) {
          Navigator.pushReplacement(
            navigatorKey.currentContext!,
            PageRouteBuilder(
              pageBuilder: (ctx, ani, ani1) => getCurrentPage(getCurrentRoute(type)),
              transitionDuration: const Duration(seconds: 0),
            ),
          );
        },
      ),
    );
  }

  //Handling route based on bottom click actions
   String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.home:
        return 'homeScreen';
      case BottomBarEnum.sessions:
        return 'sessionsInitialPage';
      case BottomBarEnum.groupsessions:
        return 'groupSessionsScreen';
      case BottomBarEnum.account:
        return 'accountScreen';
      default:
        return 'sessionsInitialPage';
    }
  }

  //Handling page based on route
 Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case 'sessionsInitialPage':
        return const SessionsInitialPage();
      case 'homeScreen':
        return const DefaultWidget(); // Replace with actual HomeScreen widget
      case 'groupSessionsScreen':
        return const DefaultWidget(); // Replace with actual GroupSessionsScreen widget
      case 'accountScreen':
        return const DefaultWidget(); // Replace with actual AccountScreen widget
      default:
        return const DefaultWidget();
    }
  }
}
