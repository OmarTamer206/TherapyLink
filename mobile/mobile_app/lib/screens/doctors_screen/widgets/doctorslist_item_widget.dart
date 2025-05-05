import 'package:flutter/material.dart';
import 'package:mobile_app/core/utils/image_constant.dart';
import 'package:mobile_app/theme/theme_helper.dart';
import 'package:mobile_app/widgets/custom_image_view.dart';

class DoctorsListItemWidget extends StatelessWidget {
  const DoctorsListItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgEllipse6,
          height: 34,
          width: 34,
          radius: BorderRadius.circular(16),
        ),
        Expanded(
          child: Column(
            children: [
              Text("Dr.Mark", style: theme.textTheme.titleSmall),
              SizedBox(
                width: double.maxFinite,
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgSignal,
                      height: 10,
                      width: 10,
                    ),
                    Text("4.5", style: theme.textTheme.labelSmall),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text("View Doctor", style: theme.textTheme.labelLarge),
          ),
        ),
      ],
    );
  }
}
