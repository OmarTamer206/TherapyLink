// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mobile_app/core/utils/image_constant.dart';
import 'package:mobile_app/screens/app_navigation_screen.dart';
import 'package:mobile_app/screens/edit_profile_screen.dart';
import 'package:mobile_app/screens/journal_screen/journal_screen.dart';
import 'package:mobile_app/screens/profile_screen/widgets/profilelist_item_widget.dart';
import 'package:mobile_app/theme/app_decoration.dart';
import 'package:mobile_app/theme/custom_text_style.dart';
import 'package:mobile_app/theme/theme_helper.dart';
import 'package:mobile_app/widgets/app_bar/appbar_subtitle.dart';
import 'package:mobile_app/widgets/app_bar/appbar_trailing_button.dart';
import 'package:mobile_app/widgets/app_bar/custom_app_bar.dart';
import 'package:mobile_app/widgets/custom_button_bar.dart';
import 'package:mobile_app/widgets/custom_elevated_button.dart';
import 'package:mobile_app/widgets/custom_image_view.dart';
import 'package:mobile_app/widgets/custom_outlined_button.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

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
                child: SingleChildScrollView(
                  child: Container(
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.only(top: 18),
                          decoration: AppDecoration.background,
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.maxFinite,
                                child: _buildAppBar(context),
                              ),
                              const SizedBox(height: 48),
                              CustomImageView(
                                imagePath: ImageConstant.imgEllipse2150x150,
                                height: 150,
                                width: 152,
                                radius: BorderRadius.circular(74),
                              ),
                              const SizedBox(height: 28),
                              Text(
                                "Emily Mark",
                                style: CustomTextStyles
                                    .headlineSmallBlack900SemiBold,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Joined 2/1/2023",
                                style: CustomTextStyles
                                    .headlineSmallBlack900SemiBold.copyWith(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    )
                              ),
                              const SizedBox(height: 26),
                              CustomOutlinedButton(
                                height: 46,
                                width: 204,
                                text: "Edit profile",
                                buttonStyle: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                buttonTextStyle:
                                    CustomTextStyles.titleLargePrimary,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditProfileScreen()));
                                },
                              ),
                              SizedBox(height: 18),
                              CustomElevatedButton(
                                height: 46,
                                width: 204,
                                text: "My Journal",
                               buttonStyle: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      theme.colorScheme.primary,
                                  foregroundColor:
                                      theme.colorScheme.onErrorContainer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                ),
                                buttonTextStyle:
                                    CustomTextStyles.titleLargeOnErrorContainer,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              JournalScreen()));
                                },
                              ),
                              const SizedBox(height: 80),
                              _buildProfileList(context),
                              const SizedBox(height: 90),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.only(bottom: 24),
        child: _buildBottomBar(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: AppbarSubtitle(text: "Profile"),
      actions: [
        AppbarTrailingButton(
          margin: EdgeInsets.only(top: 3, right: 36, bottom: 2),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AppNavigationScreen()));
          },
        ),
      ],
    );
  }

  Widget _buildProfileList(BuildContext context) {
    return const SizedBox(
      height: 200,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           SizedBox(
            width: 76,
            child: ProfileListItemWidget(),
          ),
           SizedBox(width: 40),
           SizedBox(
            width: 76,
            child: ProfileListItemWidget1(),
          ),
           SizedBox(width: 40),
           SizedBox(
            width: 76,
            child: ProfileListItemWidget2(),
          ),
        ],
      ),
    );
  }


  Widget _buildBottomBar(BuildContext context) {
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

  // Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.home:
        return "/";
      case BottomBarEnum.sessions:
        return "/";
      case BottomBarEnum.groupsessions:
        return "/";
      case BottomBarEnum.account:
        return "/";
      default:
        return "/";
    }
  }
}
