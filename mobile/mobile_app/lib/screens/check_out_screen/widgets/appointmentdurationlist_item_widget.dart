import 'package:flutter/material.dart';
import 'package:mobile_app/theme/app_decoration.dart';
import 'package:mobile_app/theme/custom_text_style.dart';

class AppointmentDurationListItemWidget extends StatelessWidget {
  const AppointmentDurationListItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: AppDecoration.outlinePrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder6,
      ),
      child: Text(
        "30 min",
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: CustomTextStyles.bodyMediumBlack900,
      ),
    );
  }
}
