import 'package:flutter/material.dart';
import 'package:mobile_app/theme/custom_text_style.dart';
import 'package:mobile_app/theme/theme_helper.dart';
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
          height: 36,
          width: 110,
          text: "Log Out",
          buttonStyle: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onErrorContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainer,
          onPressed: onTap as VoidCallback?,
        ),
      ),
    );
  }
}