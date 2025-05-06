import "package:flutter/material.dart";
import "package:mobile_app/core/utils/image_constant.dart";
import "package:mobile_app/theme/app_decoration.dart";
import "package:mobile_app/theme/custom_text_style.dart";
import "package:mobile_app/widgets/custom_image_view.dart";

class ProfileListItemWidget extends StatelessWidget {
  const ProfileListItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 76,
      child: Column(
        children: [
          Container(
            height: 76,
            width: double.maxFinite,
            decoration: AppDecoration.buttonsCTA.copyWith(
              borderRadius: BorderRadiusStyle.circleBorder40,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgCalender,
                  height: 30,
                  width: 28,
                ),
              ],
            ),
          ),
         const SizedBox(height: 6),
          Text("6", style: CustomTextStyles.headlineSmallBlack900SemiBold),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Text(
                "Therapy Sessions",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: CustomTextStyles.titleMediumBlack900_1,
              ),
            ),
          )
        ],
      ),
    );
  }
}
