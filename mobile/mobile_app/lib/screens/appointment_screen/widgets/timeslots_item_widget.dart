import 'package:flutter/material.dart';
import 'package:mobile_app/theme/app_decoration.dart';
import 'package:mobile_app/theme/theme_helper.dart';

class TimeSlotsItemWidget extends StatelessWidget {
  const TimeSlotsItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: AppDecoration.fillPrimaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder6,
      ),
      child: Text(
        "2:00 PM",
        textAlign: TextAlign.center,
        style: theme.textTheme.bodyMedium,
      ),
    );
  }
}
