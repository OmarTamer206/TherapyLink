import 'package:flutter/material.dart';
import 'package:mobile_app/theme/custom_text_style.dart';
import 'package:mobile_app/theme/theme_helper.dart';

class AppbarTitle extends StatelessWidget {
  const AppbarTitle(
      {Key? key, required this.text, this.onTap, this.margin, this.textStyle})
      : super(
          key: key,
        );

  final String text;

  final Function? onTap;

  final EdgeInsetsGeometry? margin;

  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: GestureDetector(
        onTap: () {
          onTap?.call();
        },
        child: Text(
          text,
          style:textStyle?? CustomTextStyles.headlineSmallOnErrorContainer.copyWith(
            color: theme.colorScheme.onErrorContainer,
          ),
        ),
      ),
    );
  }
}
