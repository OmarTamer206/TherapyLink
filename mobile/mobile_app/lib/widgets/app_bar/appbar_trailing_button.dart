import 'package:flutter/material.dart';
import 'package:mobile_app/theme/custom_text_style.dart';
import 'package:mobile_app/widgets/custom_elevated_button.dart';

class AppbarTrailingButton extends StatelessWidget {
  const AppbarTrailingButton({
    Key? key,
    this.onTap,
    this.margin,
  }) : super(key: key);

  final Function? onTap;

  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: GestureDetector(
        onTap: () {
          onTap?.call();
        },
        child: CustomElevatedButton(
          height: 28,
          width: 92,
          text: "Log Out",
          buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainer,
        ),
      ),
    );
  }
}
