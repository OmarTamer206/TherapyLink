import 'package:flutter/material.dart';
import 'package:mobile_app/theme/custom_text_style.dart';

class UpcomingSessionsListItemWidget extends StatelessWidget {
  const UpcomingSessionsListItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("2/2/2025", style: CustomTextStyles.titleMedium18),
              Padding(
                padding:const EdgeInsets.only(left: 20),
                child: Text(
                  "Session wiht Dr.Mark",
                  style: CustomTextStyles.titleMediumBlack900_2,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 2),
                  child: Text(
                    "7:00PM",
                    style: CustomTextStyles.labelLargeBlack900_1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: double.maxFinite, child: Divider()),
        ],
      ),
    );
  }
}
