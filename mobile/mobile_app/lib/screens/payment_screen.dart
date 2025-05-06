import 'package:flutter/material.dart';
import 'package:mobile_app/core/utils/image_constant.dart';
import 'package:mobile_app/screens/home_screen.dart';
import 'package:mobile_app/theme/app_decoration.dart';
import 'package:mobile_app/theme/custom_text_style.dart';
import 'package:mobile_app/theme/theme_helper.dart';
import 'package:mobile_app/widgets/app_bar/appbar_subtitle.dart';
import 'package:mobile_app/widgets/app_bar/custom_app_bar.dart';
import 'package:mobile_app/widgets/custom_image_view.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

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
                    padding: const EdgeInsets.only(top: 22),
                    decoration: AppDecoration.background,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: _buildAppbar(context),
                        ),
                        const SizedBox(height: 192),
                        CustomImageView(
                          imagePath: ImageConstant.imgVector,
                          height: 236,
                          width: 236,
                        ),
                        const SizedBox(height: 42),
                        Text(
                          "Session Payment Successful!",
                          style: CustomTextStyles.headlineSmallBlack900SemiBold,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Transaction Number : 12345678",
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 18),
                        const SizedBox(
                          width: double.maxFinite,
                          child: Divider(indent: 36, endIndent: 36),
                        ),
                        const SizedBox(height: 18),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Amount Paid:",
                                style: CustomTextStyles.titleMedium18_1,
                              ),
                              const TextSpan(text: " "),
                              TextSpan(
                                text: "LE 500.00",
                                style: CustomTextStyles
                                    .titleMediumPrimaryContainer,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 224),
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

  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      leadingWidth: 60,
      leading: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(6.0), // adjust spacing as needed
          child: CustomImageView(
            imagePath: ImageConstant
                .imgArrowDownBlack900, // replace with your actual arrow asset
            height: 32,
            width: 32,
          ),
        ),
      ),
      title: const AppbarSubtitle(text: "Payment"),
    );
  }
}
