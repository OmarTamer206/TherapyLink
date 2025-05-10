import 'package:flutter/material.dart';
import 'package:mobile_app/core/utils/image_constant.dart';
import 'package:mobile_app/theme/theme_helper.dart';
import 'package:mobile_app/widgets/custom_image_view.dart';

class LifeCoachesListItemWidget extends StatelessWidget {
final VoidCallback? onViewCoachTap; // Callback for navigation
  final TextStyle? viewCoachStyle; // Optional style override for "View Doctor"
  
 const LifeCoachesListItemWidget({
    super.key,
    this.onViewCoachTap,
    this.viewCoachStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.onErrorContainer,
        border: Border.all(
          color: theme.colorScheme.primaryContainer,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgEllipse6,
                height: 40,
                width: 40,
                radius: BorderRadius.circular(20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dr. Mark",
                    style: theme.textTheme.titleSmall!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 12,
                        color: theme.colorScheme.primary, // Color #06303E
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "4.5",
                        style: theme.textTheme.labelSmall!.copyWith(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
           GestureDetector(
            onTap: onViewCoachTap,
            child: Text(
              "View Coaches",
              style: viewCoachStyle ??
                  theme.textTheme.labelLarge!.copyWith(
                    color: theme.colorScheme.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}