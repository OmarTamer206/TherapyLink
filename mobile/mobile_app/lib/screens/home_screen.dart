// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mobile_app/core/utils/image_constant.dart';
import 'package:mobile_app/screens/chatbot_screen.dart';
import 'package:mobile_app/screens/doctors_screen/doctors_screen.dart';
import 'package:mobile_app/screens/sessions_screen/sessions_screen.dart';
import 'package:mobile_app/screens/type_of_therapist_screen/type_of_therapist_screen.dart';
import 'package:mobile_app/theme/app_decoration.dart';
import 'package:mobile_app/theme/custom_button_style.dart';
import 'package:mobile_app/theme/custom_text_style.dart';
import 'package:mobile_app/theme/theme_helper.dart';
import 'package:mobile_app/widgets/app_bar/app_trailing_image.dart';
import 'package:mobile_app/widgets/app_bar/appbar_title_image.dart';
import 'package:mobile_app/widgets/app_bar/appbar_trailing_button_one.dart';
import 'package:mobile_app/widgets/app_bar/custom_app_bar.dart';
import 'package:mobile_app/widgets/custom_elevated_button.dart';
import 'package:mobile_app/widgets/custom_image_view.dart';
import 'package:mobile_app/widgets/custom_outlined_button.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key})
      : super(
          key: key,
        );
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
                          padding: const EdgeInsets.only(top: 14),
                          decoration: AppDecoration.background,
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.maxFinite,
                                child: _buildAppBar(context),
                              ),
                              const SizedBox(height: 24),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Text(
                                    "Welcome Emily !",
                                    style: CustomTextStyles
                                        .headlineSmallBlack900_1,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Text(
                                    "Upcoming Session",
                                    style: CustomTextStyles
                                        .titleLargeBlack900SemiBold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                width: double.maxFinite,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 18,
                                ),
                                decoration:
                                    AppDecoration.widgetorinput.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder6,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Session With: Dr. Magdy",
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "Timing: 9/1/2025 , 7:00 PM",
                                      style:
                                          CustomTextStyles.titleSmallBlack900,
                                    ),
                                    const SizedBox(height: 40),
                                    Container(
                                      height: 240,
                                      width: double.maxFinite,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 38),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          SizedBox(
                                            height: 240,
                                            width: 240,
                                            child: CircularProgressIndicator(
                                              value: 0.33,
                                              backgroundColor:
                                                  appTheme.blueGray100,
                                              color: theme
                                                  .colorScheme.primaryContainer,
                                            ),
                                          ),
                                          Text(
                                            "20 minutes left",
                                            style: CustomTextStyles
                                                .titleMediumSemiBold,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40),
                              const SizedBox(
                                width: double.maxFinite,
                                child: Divider(
                                  indent: 20,
                                  endIndent: 20,
                                ),
                              ),
                              const SizedBox(height: 38),
                              Container(
                                width: double.maxFinite,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child:
                                          _buildChangeTherapistButton(context),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _buildChooseDoctorButton(context),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              _buildRepeatChatbotButton(context),
                              const SizedBox(height: 30),
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
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 44,
      title: SizedBox(
        width: double.maxFinite,
        child: AppbarTitleImage(
          imagePath: ImageConstant.imgLogoNoBackground,
          height: 44,
          width: 146,
          margin: const EdgeInsets.only(left: 20),
        ),
      ),
      actions: [
        AppbarTrailingButtonOne(
          onTap: () {
            //Add "Need Help" button functionality
          },
          margin: const EdgeInsets.only(right: 12),
        ),
        AppbarTrailingImage(
          imagePath: ImageConstant.imgEllipse1,
          height: 34,
          width: 34,
          margin: const EdgeInsets.only(
            right: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildChangeTherapistButton(BuildContext context) {
    return SizedBox(
      height: 54,
      child: CustomOutlinedButton(
        text: "Change Therapist Preference",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const TypeOfTherapistScreen()),
          );
        },
        buttonStyle: CustomButtonStyles.outlinePrimaryContainerTL6.copyWith(
          fixedSize: MaterialStateProperty.all<Size>(const Size.fromHeight(54)),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
        buttonTextStyle: CustomTextStyles.titleMediumPrimaryContainerBold.copyWith(
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildChooseDoctorButton(BuildContext context) {
    return SizedBox(
      height: 54,
      child: CustomOutlinedButton(
        text: "Choose Doctor",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DoctorsScreen()),
          );
        },
        buttonStyle: CustomButtonStyles.outlinePrimary.copyWith(
          fixedSize: MaterialStateProperty.all<Size>(const Size.fromHeight(54)),
        ),
        buttonTextStyle: CustomTextStyles.titleMediumPrimary,
      ),
    );
  }

  Widget _buildRepeatChatbotButton(BuildContext context) {
    return CustomElevatedButton(
      height: 54,
      text: "Repeat Chatbot Test",
      margin:
          const EdgeInsets.symmetric(horizontal: 20),
          buttonStyle: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6)
            ),
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
      buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainer,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>const ChatbotScreen()),
        );
      },
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomBarItem(
              icon: ImageConstant.imgNavHome,
              label: "Home",
              isActive: true,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              }),
          _buildBottomBarItem(
              icon: ImageConstant.imgNavSessions,
              label: "Sessions",
              onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                 builder: (context) => SessionsScreen()
                ));
              }),
          _buildBottomBarItem(
              icon: ImageConstant.imgNavGroupSessions,
              label: "Group Sessions",
              onTap: () {
                //Navigator.push(
                // context,
                // MaterialPageRoute(
                // builder: (context) =>
                // SignInLogInScreen()));
              }),
          _buildBottomBarItem(
              icon: ImageConstant.imgNavAccount,
              label: "Account",
              onTap: () {
                // Navigator.push(
                //context,
                //  MaterialPageRoute(
                // builder: (context) =>
                //   SignInLogInScreen()));
              }),
        ],
      ),
    );
  }

  Widget _buildBottomBarItem({
    required String icon,
    required String label,
    bool isActive = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: icon,
            height: 24,
            width: 24,
            color: isActive
                ? theme.colorScheme.onErrorContainer
                : theme.colorScheme.primaryContainer,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: isActive
                  ? theme.colorScheme.onErrorContainer
                  : theme.colorScheme.primaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
