import 'package:flutter/material.dart';
import 'package:mobile_app/core/utils/image_constant.dart';
import 'package:mobile_app/theme/custom_text_style.dart';
import 'package:mobile_app/widgets/custom_image_view.dart';

class JournalEntriesItemWidget extends StatelessWidget {
  const JournalEntriesItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("2/4/2024", style: CustomTextStyles.titleMediumSemiBold_1),
                CustomImageView(
                  imagePath: ImageConstant.imgDelete,
                  height: 16,
                  width: 16,
                ),
              ],
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Today, I realized how much progress I’ve made in managing my anxiety. The breathing exercises my therapist recommended are starting to feel natural, and I’m proud of myself for sticking with them. ",
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: CustomTextStyles.titleSmallBlack900Medium,
          ),
          SizedBox(height: 16),
          // Removed Divider to eliminate grey lines
        ],
      ),
    );
  }
}