import 'package:flutter/material.dart';
import 'package:mobile_app/core/utils/image_constant.dart';
import 'package:mobile_app/screens/doctors_screen/widgets/doctorslist_item_widget.dart';
import 'package:mobile_app/theme/app_decoration.dart';
import 'package:mobile_app/theme/custom_text_style.dart';
import 'package:mobile_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:mobile_app/widgets/app_bar/appbar_subtitle.dart';
import 'package:mobile_app/widgets/app_bar/custom_app_bar.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          padding:const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  padding:const EdgeInsets.only(top: 20),
                  decoration: AppDecoration.background,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: _buildAppBar(context),
                      ),
                     const SizedBox(height: 72),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding:const EdgeInsets.only(left: 36),
                          child: Text(
                            "Clinical Psychologist",
                            style: CustomTextStyles.labelMediumBold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Expanded(
                        child: Container(
                          width: double.maxFinite,
                          margin:const EdgeInsets.symmetric(horizontal: 36),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 32),
                          decoration: AppDecoration.widgetorinput.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder6,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [_buildDoctorsList(context)],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowdown,
        margin: const EdgeInsets.only(left: 36),
      ),
      centerTitle: true,
      title: const AppbarSubtitle(text: "Doctors"),
    );
  }

  Widget _buildDoctorsList(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          physics:const BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10);
          },
          itemCount: 12,
          itemBuilder: (context, index) {
            return const DoctorsListItemWidget();
          },
        ),
      ),
    );
  }
}
