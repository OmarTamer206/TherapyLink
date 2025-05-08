import 'package:flutter/material.dart';
import 'package:mobile_app/core/utils/image_constant.dart';
import 'package:mobile_app/theme/app_decoration.dart';
import 'package:mobile_app/theme/custom_text_style.dart';
import 'package:mobile_app/theme/theme_helper.dart';
import 'package:mobile_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:mobile_app/widgets/app_bar/appbar_subtitle.dart';
import 'package:mobile_app/widgets/app_bar/custom_app_bar.dart';
import 'package:mobile_app/widgets/custom_elevated_button.dart';
import 'package:mobile_app/widgets/custom_icon_button.dart';
import 'package:mobile_app/widgets/custom_image_view.dart';

class UpcomingSessionsCallScreen extends StatelessWidget {
  const UpcomingSessionsCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 26),
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(top: 22),
                    decoration: AppDecoration.background,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: _buildAppBar(context),
                        ),
                        SizedBox(height: 28),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.symmetric(horizontal: 36),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Session With: Dr. Magdy",
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    Text(
                                      "Timing: 9/1/2025 , 7:00  PM",
                                      style:
                                          CustomTextStyles.titleSmallBlack900,
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  "30 minutes",
                                  style: CustomTextStyles.labelLargeBlack900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.symmetric(horizontal: 36),
                          padding: EdgeInsets.symmetric(vertical: 50),
                          decoration: AppDecoration.widgetorinput.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder6,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgImage,
                                height: 204,
                                width: 206,
                                radius: BorderRadius.circular(102),
                              ),
                              SizedBox(height: 18),
                              Text(
                                "Dr. Magdy",
                                style: CustomTextStyles
                                    .headlineSmallBlack900SemiBold,
                              ),
                              Text(
                                "01:35:50",
                                style: theme.textTheme.titleLarge,
                              ),
                              SizedBox(height: 216),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomIconButton(
                                    height: 52,
                                    width: 52,
                                    padding: EdgeInsets.all(14),
                                    decoration: IconButtonStyleHelper.none,
                                    child: CustomImageView(
                                      imagePath: ImageConstant.imgVolumn,
                                    ),
                                  ),
                                  CustomIconButton(
                                    height: 52,
                                    width: 52,
                                    padding: EdgeInsets.all(8),
                                    decoration: IconButtonStyleHelper
                                        .fillErrorContainer,
                                    child: CustomImageView(
                                      imagePath: ImageConstant.imgClose,
                                    ),
                                  ),
                                  CustomIconButton(
                                    height: 52,
                                    width: 52,
                                    padding: EdgeInsets.all(14),
                                    decoration: IconButtonStyleHelper.none,
                                    child: CustomImageView(
                                      imagePath: ImageConstant.imgVoice,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomElevatedButton(
                          text: "Ends in 25:15:10 ",
                          margin: EdgeInsets.only(left: 34, right: 36),
                        ),
                        SizedBox(height: 6),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 60,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowDownBlack900,
        margin: EdgeInsets.only(left: 36),
        onTap: () {
        Navigator.pop(context); // Handle back navigation
      },
      ),
      centerTitle: true,
      title: AppbarSubtitle(text: "Upcoming Sessions"),
    );
  }
}
