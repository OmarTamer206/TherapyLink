import 'package:flutter/material.dart';
import 'package:mobile_app/core/utils/image_constant.dart';
import 'package:mobile_app/screens/chatting_screen.dart';
import 'package:mobile_app/screens/home_screen.dart';
import 'package:mobile_app/theme/app_decoration.dart';
import 'package:mobile_app/theme/custom_text_style.dart';
import 'package:mobile_app/theme/theme_helper.dart';
import 'package:mobile_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:mobile_app/widgets/app_bar/appbar_title.dart';
import 'package:mobile_app/widgets/app_bar/custom_app_bar.dart';
import 'package:mobile_app/widgets/custom_elevated_button.dart';
import 'package:mobile_app/widgets/custom_image_view.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(top: 22),
                    decoration: AppDecoration.background,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: _buildAppBar(context),
                        ),
                        const SizedBox(height: 46),
                        CustomImageView(
                          imagePath: ImageConstant.imgMaskGroupPrimary,
                          height: 244,
                          width: double.maxFinite,
                        ),
                        const SizedBox(height: 46),
                        Text(
                          "Welcome To Our ChatBot Test !",
                          style: theme.textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 22),
                        SizedBox(
                          width: double.maxFinite,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              "Your personal assistant for mental well-being is ready to listen, guide, and connect you to the support you need.",
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.titleLargeBlack900Bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 112),
                        CustomElevatedButton(
                          text: "Start Chatting",
                          margin: const EdgeInsets.only(
                            left: 36,
                            right: 34,
                          ),
                          height: 54,
                          buttonStyle: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                          buttonTextStyle:
                              CustomTextStyles.titleMediumOnErrorContainer,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChattingScreen()),
                            );
                          },
                        ),
                        const SizedBox(height: 136),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowDownBlack900,
        margin: const EdgeInsets.only(left: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
          text: "ChatBot",
          textStyle: CustomTextStyles.headlineSmallBlack900.copyWith(
            color: theme.colorScheme.primary,
          )),
    );
  }
}
