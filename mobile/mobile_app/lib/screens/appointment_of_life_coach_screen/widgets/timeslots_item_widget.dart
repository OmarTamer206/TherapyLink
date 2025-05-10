import 'package:flutter/material.dart';
import 'package:mobile_app/theme/app_decoration.dart';
import 'package:mobile_app/theme/theme_helper.dart';

class TimeSlotsItemWidget2 extends StatelessWidget {
  final String time;
  final bool isSelected;
  final VoidCallback onTap;

  const TimeSlotsItemWidget2({
    super.key,
    required this.time,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: AppDecoration.fillPrimaryContainer.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder6,
          color: isSelected
              ? theme.colorScheme.primary // Highlight selected time
              : theme.colorScheme.primaryContainer,
        ),
        alignment: Alignment.center,
        child: Text(
          time,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isSelected
                ? theme.colorScheme.onErrorContainer
                : theme.colorScheme.onErrorContainer,
          ),
        ),
      ),
    );
  }
}