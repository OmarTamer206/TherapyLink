// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mobile_app/routes/app_routes.dart';
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
                  initialRoute: AppRoutes.sessionsInitialPage,
                  onGenerateRoute: (routeSetting) => PageRouteBuilder(
                    pageBuilder: (ctx, ani, ani1) =>
                        getCurrentPage(routeSetting.name!),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.only(left: 26, right: 26, bottom: 24),
        child: _buildBottomNavigationBar(context),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomBottomBar(
        onChanged: (BottomBarEnum type) {
          Navigator.pushNamed(
            navigatorKey.currentContext!,
            getCurrentRoute(type),
          );
        },
      ),
    );
  }

  //Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.home:
        return AppRoutes.homeScreen;
      case BottomBarEnum.sessions:
        return AppRoutes.sessionsInitialPage;
      case BottomBarEnum.groupsessions:
        return "/";
      case BottomBarEnum.account:
        return "/";
      default:
        return "/";
    }
  }

  //Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.sessionsInitialPage:
        return const SessionsInitialPage();
      default:
        return const DefaultWidget();
    }
  }
}
