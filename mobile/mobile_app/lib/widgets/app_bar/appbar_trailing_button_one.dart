import 'package:flutter/material.dart';
import 'package:mobile_app/core/utils/image_constant.dart';
import 'package:mobile_app/theme/custom_text_style.dart';
import 'package:mobile_app/theme/theme_helper.dart';
import 'package:mobile_app/widgets/custom_image_view.dart';

class AppbarTrailingButtonOne extends StatelessWidget {
  const AppbarTrailingButtonOne({Key? key, this.onTap, this.margin})
      : super(
          key: key,
        );

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
        child: Container(
          height: 28,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFA81416), // Your desired color
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgNeedHelp,
                height: 20,
                width: 20,
                fit: BoxFit.contain,
                color: theme.colorScheme.onErrorContainer,
              ),
              const SizedBox(width: 6),
              Text(
                "Need Help?",
                style: CustomTextStyles.labelLargeOnErrorContainer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
