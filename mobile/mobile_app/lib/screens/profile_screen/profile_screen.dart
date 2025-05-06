// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mobile_app/core/utils/image_constant.dart';
import 'package:mobile_app/screens/profile_screen/widgets/profilelist_item_widget.dart';
import 'package:mobile_app/theme/app_decoration.dart';
import 'package:mobile_app/theme/custom_text_style.dart';
import 'package:mobile_app/widgets/app_bar/appbar_subtitle.dart';
import 'package:mobile_app/widgets/app_bar/appbar_trailing_button.dart';
import 'package:mobile_app/widgets/app_bar/custom_app_bar.dart';
import 'package:mobile_app/widgets/custom_button_bar.dart';
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
                    padding: EdgeInsets.symmetric(horizontal: 26),
                    child: Column(
                      children: [
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.only(top: 18),
                          decoration: AppDecoration.background,
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.maxFinite,
                                child: _buildAppBar(context),
                              ),
                              SizedBox(height: 48),
                              CustomImageView(
                                imagePath: ImageConstant.imgEllipse2150x150,
                                height: 150,
                                width: 152,
                                radius: BorderRadius.circular(74),
                              ),
                              SizedBox(height: 28),
                              Text(
                                "Emily Mark",
                                style: CustomTextStyles
                                    .headlineSmallBlack900SemiBold,
                              ),
                              SizedBox(height: 26),
                              CustomOutlinedButton(
                                height: 46,
                                width: 204,
                                text: "Edit profile",
                                buttonTextStyle:
                                    CustomTextStyles.titleLargePrimary,
                              ),
                              SizedBox(height: 80),
                              _buildProfileList(context),
                              SizedBox(height: 90),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(left: 26, right: 26, bottom: 24),
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
        ),
      ],
    );
  }

  Widget _buildProfileList(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 56, right: 50),
      width: double.maxFinite,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 44,
          children: List.generate(3, (index) {
            return ProfileListItemWidget();
          }),
        ),
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

  //Handling route based on bottom click actions
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
