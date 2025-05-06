import 'package:flutter/material.dart';
import 'package:mobile_app/core/utils/image_constant.dart';
import 'package:mobile_app/screens/doctor_s_one_screen.dart';
import 'package:mobile_app/screens/doctors_screen/widgets/doctorslist_item_widget.dart';
import 'package:mobile_app/screens/home_screen.dart';
import 'package:mobile_app/theme/app_decoration.dart';
import 'package:mobile_app/theme/custom_text_style.dart';
import 'package:mobile_app/theme/theme_helper.dart';
import 'package:mobile_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:mobile_app/widgets/app_bar/appbar_subtitle.dart';
import 'package:mobile_app/widgets/app_bar/custom_app_bar.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth * 0.9; // 90% of screen width

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.only(top: 20),
            decoration: AppDecoration.background,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: CustomAppBar(
                    leadingWidth: 40,
                    leading: AppbarLeadingImage(
                      imagePath: ImageConstant.imgArrowDownBlack900,
                      margin: const EdgeInsets.only(left: 16),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      },
                    ),
                    centerTitle: true,
                    title: const AppbarSubtitle(text: "Doctors"),
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Clinical Psychologist",
                      style: CustomTextStyles.labelMediumBold.copyWith(
                        color: appTheme.black900,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: SizedBox(
                    width: containerWidth,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: AppDecoration.widgetorinput.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder6,
                      ),
                      child: _buildDoctorsList(context),
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Add some padding at the bottom for better scrolling experience
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorsList(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
      itemCount: 12,
      itemBuilder: (context, index) {
        return DoctorsListItemWidget(
          onViewDoctorTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DoctorSOneScreen(), // Navigate to DoctorPage
              ),
            );
          },
        );
      },
    );
  }
}

class DefaultWidget extends StatelessWidget {
  const DefaultWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffffffff),
      padding: const EdgeInsets.all(10),
      child: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'HomeScreen Placeholder - Replace with actual HomeScreen widget',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}