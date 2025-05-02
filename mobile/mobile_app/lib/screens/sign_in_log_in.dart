// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mobile_app/core/utils/image_constant.dart';
import 'package:mobile_app/screens/home_screen.dart';
import 'package:mobile_app/screens/sign_up_screen.dart';
import 'package:mobile_app/theme/app_decoration.dart';
import 'package:mobile_app/theme/custom_text_style.dart';
import 'package:mobile_app/theme/theme_helper.dart';
import 'package:mobile_app/widgets/custom_elevated_button.dart';
import 'package:mobile_app/widgets/custom_image_view.dart';
import 'package:mobile_app/widgets/custom_text_form_field.dart';

class SignInLogInScreen extends StatelessWidget {
  SignInLogInScreen({super.key});

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

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
                      decoration: AppDecoration.fillTeal,
                      child: Column(
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgLogoNoBackground,
                            height: 44,
                            width: 148,
                            alignment: Alignment.centerLeft,
                          ),
                          const SizedBox(height: 50),
                          CustomImageView(
                            imagePath: ImageConstant.imgMaskGroup,
                            height: 188,
                            width: double.maxFinite,
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                          ),
                          const SizedBox(height: 18),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: AppDecoration.outlineBlack,
                            child: Text(
                              "Welcome back! Your path to clarity and support is just a conversation away.",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles
                                  .titleLargeScriptMTBoldPrimaryContainer,
                            ),
                          ),
                         const SizedBox(height: 80),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: CustomTextFormField(
                              controller: emailController,
                              hintText: "Email",
                              textInputType: TextInputType.emailAddress,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 12,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: CustomTextFormField(
                              controller: passwordController,
                              hintText: "Password",
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.visiblePassword,
                              obscureText: true,
                              contentPadding:const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 12,
                              ),
                            ),
                          ),
                         const SizedBox(height: 50),
                          CustomElevatedButton(
                            height: 54,
                            text: "Log In",
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            buttonStyle: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0XFF06303E),
                            ),
                            buttonTextStyle: CustomTextStyles.titleLargeOnErrorContainer,
                            onPressed: () {
                              if(_formKey.currentState!.validate()){
                              // Navigate to home page
                              Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreen()),
                              );
                              }
                            },
                          ),
                          const SizedBox(height: 6),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignUpScreen()),
                              );
                            },
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: theme.textTheme.titleMedium,
                              ),
                             const SizedBox(width: 8),
                              Text(
                                "Sign Up",
                                style: CustomTextStyles
                                    .titleMediumPrimaryContainerBold.copyWith(
                                      decoration: TextDecoration.underline,
                                    ),
                              ),
                            ],
                          ),
                          ),
                          const SizedBox(height: 170),
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
}
