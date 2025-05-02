import 'package:flutter/material.dart';
import 'package:mobile_app/theme/app_decoration.dart';
import 'package:mobile_app/widgets/custom_image_view.dart';

class AppbarTrailingImage extends StatelessWidget {
  AppbarTrailingImage({
    Key? key,
    this.imagePath,
    this.height,
    this.width,
    this.onTap,
    this.margin,
  }) : super(
          key: key,
        );

  final double? height;

  final double? width;

  final String? imagePath;

  final Function? onTap;

  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadiusStyle.roundedBorder16,
        onTap: () {
          onTap?.call();
        },
        child: CustomImageView(
          imagePath: imagePath!,
          height: height ?? 24,
          width: width ?? 24,
          fit: BoxFit.contain,
          radius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
