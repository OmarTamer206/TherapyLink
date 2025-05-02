import 'package:flutter/material.dart';
import 'package:mobile_app/theme/theme_helper.dart';

class AppbarSubtitle extends StatelessWidget {
  const AppbarSubtitle({Key? key, required this.text, this.onTap, this.margin})
      : super(
          key: key,
        );

  final String text;

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
        child: Text(
          text,
          style: theme.textTheme.headlineSmall!.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
