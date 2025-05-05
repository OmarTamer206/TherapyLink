import 'package:flutter/material.dart';
import 'package:mobile_app/core/utils/image_constant.dart';
import 'package:mobile_app/screens/appointment_screen/appointment_screen.dart';
import 'package:mobile_app/screens/doctors_screen/doctors_screen.dart';
import 'package:mobile_app/theme/app_decoration.dart';
import 'package:mobile_app/theme/custom_text_style.dart';
import 'package:mobile_app/theme/theme_helper.dart';
import 'package:mobile_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:mobile_app/widgets/app_bar/appbar_subtitle.dart';
import 'package:mobile_app/widgets/app_bar/custom_app_bar.dart';
import 'package:mobile_app/widgets/custom_elevated_button.dart';
import 'package:mobile_app/widgets/custom_image_view.dart';
import 'package:mobile_app/widgets/custom_rating_bar.dart';

class DoctorSOneScreen extends StatelessWidget {
  const DoctorSOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(top: 20),
                    decoration: AppDecoration.background,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: _buildAppBar(context),
                        ),
                        const SizedBox(height: 44),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 36),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 16,
                          ),
                          decoration: AppDecoration.widgetorinput.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder6,
                          ),
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgEllipse2,
                                height: 80,
                                width: 80,
                                radius: BorderRadius.circular(40),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: double.maxFinite,
                                        child: Row(
                                          children: [
                                            Text(
                                              "Dr. Mark",
                                              style: theme.textTheme.titleSmall,
                                            ),
                                            const CustomRatingBar(
                                              alignment: Alignment.bottomCenter,
                                              initialRating: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "Clinical Psychologist",
                                        style: CustomTextStyles
                                            .labelLargeBlack900_2,
                                      ),
                                      Text(
                                        "I am Dr. Mark, a dedicated clinical psychologist specializing in helping individuals overcome mental health challenges through evidence-based and compassionate care.",
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        style: CustomTextStyles
                                            .labelMediumBlack900,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 26),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 36),
                            child: Text(
                              "Reviews",
                              style: CustomTextStyles.titleLargeBlack900,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.maxFinite,
                          margin: const EdgeInsets.symmetric(horizontal: 36),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 16,
                          ),
                          decoration: AppDecoration.widgetorinput.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder6,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Dr. Mark",
                                style: CustomTextStyles.titleMediumSemiBold_1,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Dr. Mark has been an incredible support throughout my therapy journey. He listens attentively and offers thoughtful advice that’s really helped me manage my anxiety. I always feel heard and understood after each session!",
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    CustomTextStyles.titleSmallBlack900Medium,
                              ),
                              const SizedBox(height: 18),
                              const SizedBox(
                                width: double.maxFinite,
                                child: Divider(),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Dr. Mark",
                                style: CustomTextStyles.titleMediumSemiBold_1,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "I was hesitant about online therapy, but Dr. Mark made me feel comfortable right away. His calm demeanor and practical suggestions have made a big difference in my life. I would highly recommend him to anyone seeking help!",
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    CustomTextStyles.titleSmallBlack900Medium,
                              ),
                              const SizedBox(height: 16),
                              const SizedBox(
                                width: double.maxFinite,
                                child: Divider(),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Dr, Mark",
                                style: CustomTextStyles.titleMediumSemiBold_1,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Dr. Mark is very knowledgeable and compassionate. He helped me through a really tough time in my life, and I’ve made so much progress thanks to him. The online sessions are convenient and still feel very personal.",
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    CustomTextStyles.titleSmallBlack900Medium,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50),
                        CustomElevatedButton(
      height: 54,
      text: "Make Appointment",
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
      buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainer.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>const AppointmentScreen()),
        );
      },
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
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
      leading: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DoctorsScreen()),
          );
        },
        child: AppbarLeadingImage(
          imagePath: ImageConstant.imgArrowDownBlack900,
          margin: const EdgeInsets.only(left: 36),
        ),
      ),
      title: const Expanded(
        child: Center(
          child: AppbarSubtitle(
            text: "Dr. Mark's Page",
          ),
        ),
      ),
    );
  }
}
