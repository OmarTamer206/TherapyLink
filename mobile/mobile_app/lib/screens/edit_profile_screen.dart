// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mobile_app/core/utils/image_constant.dart';
import 'package:mobile_app/theme/app_decoration.dart';
import 'package:mobile_app/theme/custom_text_style.dart';
import 'package:mobile_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:mobile_app/widgets/app_bar/appbar_subtitle.dart';
import 'package:mobile_app/widgets/app_bar/custom_app_bar.dart';
import 'package:mobile_app/widgets/custom_drop_down.dart';
import 'package:mobile_app/widgets/custom_elevated_button.dart';
import 'package:mobile_app/widgets/custom_image_view.dart';
import 'package:mobile_app/widgets/custom_text_form_field.dart';

class EditProfileScreen extends StatelessWidget {
   EditProfileScreen({super.key});

  TextEditingController birthDateInputController = TextEditingController();

  List<String> dropdowmItemList = ["Item One", "Item Two", "Item Three"];

  TextEditingController phoneNumberInputController = TextEditingController();

  TextEditingController emailInputController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
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
                      padding: EdgeInsets.only(top: 18),
                      decoration: AppDecoration.background,
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.maxFinite,
                            child: _buildAppBar(context),
                          ),
                          SizedBox(height: 80),
                          CustomImageView(
                            imagePath: ImageConstant.imgEllipse2150x150,
                            height: 150,
                            width: 152,
                            radius: BorderRadius.circular(74),
                          ),
                          SizedBox(height: 50),
                          Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.symmetric(horizontal: 36),
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 16),
                            decoration: AppDecoration.widgetorinput.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder6,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: double.maxFinite,
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.imgSettings,
                                        height: 24,
                                        width: 24,
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Emily Mark",
                                            style: CustomTextStyles
                                                .titleMediumBlack90018,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: double.maxFinite,
                                  child: Divider(),
                                ),
                                _buildBirthDateInput(context),
                                CustomDropDown(
                                  icon: Container(
                                    margin: EdgeInsets.only(left: 16),
                                    child: CustomImageView(
                                      imagePath: ImageConstant.imgArrowdown,
                                      height: 18,
                                      width: 12,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  iconSize: 18,
                                  hintText: "Martial Status",
                                  hintStyle:
                                      CustomTextStyles.titleMediumBlack90018,
                                  items: dropdowmItemList,
                                  prefix: Container(
                                    margin: EdgeInsets.fromLTRB(8, 8, 10, 8),
                                    child: CustomImageView(
                                      imagePath: ImageConstant.imgMartialStatus,
                                      height: 18,
                                      width: 24,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  prefixConstraints: BoxConstraints(
                                    maxHeight: 38,
                                  ),
                                  contentPadding: EdgeInsets.all(8),
                                  borderDecoration: DropDownStyleHelper
                                      .underLinePrimaryContainer,
                                  filled: false,
                                ),
                                _buildPhoneNumberInput(context),
                                _buildEmailInput(context),
                                Container(
                                  width: double.maxFinite,
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.imgLock,
                                        height: 24,
                                        width: 20,
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 12),
                                          child: Text(
                                            "Password",
                                            style: CustomTextStyles
                                                .titleMediumBlack90018,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 4),
                              ],
                            ),
                          ),
                          SizedBox(height: 50),
                          _buildConfirmButton(context),
                          SizedBox(height: 70),
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
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 60,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowDownBlack900,
        margin: EdgeInsets.only(left: 36),
      ),
      centerTitle: true,
      title: AppbarSubtitle(text: "Edit Profile"),
    );
  }

  Widget _buildBirthDateInput(BuildContext context) {
    return CustomTextFormField(
      controller: birthDateInputController,
      hintText: "9/1/2005",
      hintStyle: CustomTextStyles.titleMediumBlack90018,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(8, 8, 10, 8),
        child: CustomImageView(
          imagePath: ImageConstant.imgCalenderEditProfile,
          height: 18,
          width: 22,
          fit: BoxFit.contain,
        ),
      ),
      prefixConstraints: BoxConstraints(maxHeight: 40),
      contentPadding: EdgeInsets.all(8),
      borderDecoration: TextFormFiledStyleHelper.underLinePrimaryContainer,
      filled: false,
    );
  }

  Widget _buildPhoneNumberInput(BuildContext context) {
    return CustomTextFormField(
      controller: phoneNumberInputController,
      hintText: "010-5680-3248",
      hintStyle: CustomTextStyles.titleMediumBlack90018,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(8, 8, 10, 8),
        child: CustomImageView(
          imagePath: ImageConstant.imgCall,
          height: 18,
          width: 24,
          fit: BoxFit.contain,
        ),
      ),
      prefixConstraints: BoxConstraints(maxHeight: 40),
      contentPadding: EdgeInsets.all(8),
      borderDecoration: TextFormFiledStyleHelper.underLinePrimaryContainer,
      filled: false,
    );
  }

  Widget _buildEmailInput(BuildContext context) {
    return CustomTextFormField(
      controller: emailInputController,
      hintText: "Emilymark@gmail.com",
      hintStyle: CustomTextStyles.titleMediumBlack90018,
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.emailAddress,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(8, 10, 10, 10),
        child: CustomImageView(
          imagePath: ImageConstant.imgMessageEditProfile,
          height: 22,
          width: 24,
          fit: BoxFit.contain,
        ),
      ),
      prefixConstraints: BoxConstraints(maxHeight: 42),
      contentPadding: EdgeInsets.fromLTRB(8, 10, 12, 10),
      borderDecoration: TextFormFiledStyleHelper.underLinePrimaryContainer,
      filled: false,
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return CustomElevatedButton(
      text: "Confirm",
      margin: EdgeInsets.symmetric(horizontal: 36),
    );
  }
}
