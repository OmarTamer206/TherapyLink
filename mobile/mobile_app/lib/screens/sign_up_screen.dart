// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mobile_app/core/utils/image_constant.dart';
import 'package:mobile_app/screens/sign_in_log_in.dart';
import 'package:mobile_app/theme/app_decoration.dart';
import 'package:mobile_app/theme/custom_text_style.dart';
import 'package:mobile_app/theme/theme_helper.dart';
import 'package:mobile_app/widgets/custom_drop_down.dart';
import 'package:mobile_app/widgets/custom_elevated_button.dart';
import 'package:mobile_app/widgets/custom_image_view.dart';
import 'package:mobile_app/widgets/custom_text_form_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController fullNameInputController = TextEditingController();
  final List<String> dropdownItemList = ["Male", "Female", "Other"];
  String? selectedGender;

  final TextEditingController ageInputController = TextEditingController();
  final List<String> dropdownItemList1 = [
    "Single",
    "Married",
    "Divorced",
    "Widowed"
  ];
  String? selectedMaritalStatus;

  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController phoneNumberInputController =
      TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();
  final TextEditingController confirmPasswordInputController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: AppDecoration.background,
                      child: Column(
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgLogoNoBackground,
                            height: 44,
                            width: 148,
                            alignment: Alignment.centerLeft,
                          ),
                          const SizedBox(height: 34),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: AppDecoration.outlineBlack,
                            child: Text(
                              "\"Find the support you need, connect with the right therapist, and start your journey toward healing because everyone deserves a safe space to talk.\"",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles
                                  .titleLargeScriptMTBoldPrimaryContainer.copyWith(
                                    shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.3),
                                    offset: const Offset(0, 2),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          _buildFullNameInput(context),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: CustomDropDown(
                              icon: Container(
                                margin: const EdgeInsets.only(left: 16),
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgArrowdown,
                                  height: 10,
                                  width: 12,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              iconSize: 10,
                              hintText: "Gender",
                              items: dropdownItemList,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 12, 20, 12),
                              onChanged: (value) {
                                selectedGender = value;
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildAgeInput(context),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: CustomDropDown(
                              icon: Container(
                                margin: const EdgeInsets.only(left: 16),
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgArrowdown,
                                  height: 10,
                                  width: 12,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              iconSize: 10,
                              hintText: "Martial Status",
                              items: dropdownItemList1,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 12, 20, 12),
                              onChanged: (value) {
                                selectedMaritalStatus = value;
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildEmailInput(context),
                          const SizedBox(height: 10),
                          _buildPhoneNumberInput(context),
                          const SizedBox(height: 10),
                          _buildPasswordInput(context),
                          const SizedBox(height: 10),
                          _buildConfirmPasswordInput(context),
                          const SizedBox(height: 40),
                          _buildSignUpButton(context),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SignInLogInScreen()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: theme.textTheme.titleMedium,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "Log In",
                                  style: CustomTextStyles
                                      .titleMediumPrimaryContainerBold,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFullNameInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomTextFormField(
        controller: fullNameInputController,
        hintText: "Full Name",
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
      ),
    );
  }

  Widget _buildAgeInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomTextFormField(
        controller: ageInputController,
        hintText: "Age",
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
      ),
    );
  }

  Widget _buildEmailInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomTextFormField(
        controller: emailInputController,
        hintText: "Email",
        textInputType: TextInputType.emailAddress,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
      ),
    );
  }

  Widget _buildPhoneNumberInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomTextFormField(
        controller: phoneNumberInputController,
        hintText: "Phone Number",
        textInputType: TextInputType.phone,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
      ),
    );
  }

  Widget _buildPasswordInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomTextFormField(
        controller: passwordInputController,
        hintText: "Password",
        textInputType: TextInputType.visiblePassword,
        obscureText: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomTextFormField(
        controller: confirmPasswordInputController,
        hintText: "Confirm Password",
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
        obscureText: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return CustomElevatedButton(
        height: 54,
        text: "Sign Up",
        margin: const EdgeInsets.symmetric(horizontal: 16),
        buttonStyle: ElevatedButton.styleFrom(
          backgroundColor: const Color(0XFF06303E),
           shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6)
            ),
             elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        buttonTextStyle: CustomTextStyles.titleLargeOnErrorContainer.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignInLogInScreen()),
            );
          }
        });
  }
}
