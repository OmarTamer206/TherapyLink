import 'package:flutter/material.dart';
import 'package:mobile_app/theme/custom_text_style.dart';

class PreviousSessionListItemWidget extends StatelessWidget {
  const PreviousSessionListItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 22,
          width: 80,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text("2/2/2024", style: CustomTextStyles.titleMedium18),
              Text("2/2/2024", style: CustomTextStyles.titleMedium18),
            ],
          ),
        ),
        Expanded(
          child: Container(
            height: 22,
            margin:const EdgeInsets.only(left: 20),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  "Session with Dr.Mark",
                  style: CustomTextStyles.titleMediumBlack900_2,
                ),
                Text(
                  "Session with Dr.Mark",
                  style: CustomTextStyles.titleMediumBlack900_2,
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 14,
            width: 44,
            margin: const EdgeInsets.only(left: 12, bottom: 2),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text("7:00PM", style: CustomTextStyles.labelLargeBlack900_1),
                Text("7:00PM", style: CustomTextStyles.labelLargeBlack900_1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
