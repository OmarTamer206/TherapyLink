/*import 'package:flutter/material.dart';

//These are the Viewport values of your Figma Design.
//These are used in the code as a reference to create you UI Responsively.

const num FIGMA_DESIGN_WIDTH = 430;
const num FIGMA_DESIGN_HEIGHT = 932;
const num FIGMA_DESIGN_STATUS_BAR = 0;

extension ResponsiveExtension on num {
  double get _width => SizeUtils.width;
  double get h => ((this * _width) / FIGMA_DESIGN_WIDTH);
  double get fSize => ((this * _width) / FIGMA_DESIGN_WIDTH);
}

extension FormatExtension on double {
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(this.toStringAsFixed(fractionDigits));
  }

  double isNonZero({num defaultValue = 0.0}) {
    return this > 0 ? this : defaultValue.toDouble();
  }
}

enum DeviceType { mobile, tablet, desktop }

typedef ResponsiveBuild = Widget Function(
    BuildContext context, Orientation orientation, DeviceType deviceType);

class Sizer extends StatelessWidget {
  const Sizer({Key? key, required this.builder})
      : super(
          key: key,
        );

  //Builds the widget whenever the orientation changes.
  final ResponsiveBuild builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeUtils.setScreenSize(constraints, orientation);
        return builder(context, orientation, SizeUtils.deviceType);
      });
    });
  }
}

class SizeUtils {
  static BoxConstraints boxConstraints = const BoxConstraints();
  static Orientation orientation = Orientation.portrait;
  static DeviceType deviceType = DeviceType.mobile;
  static double height = FIGMA_DESIGN_HEIGHT.toDouble();
  static double width = FIGMA_DESIGN_WIDTH.toDouble();

  static void setScreenSize(
    BoxConstraints constraints,
    Orientation currentOrientation,
  ) {
    try {
      boxConstraints = constraints;
      orientation = currentOrientation;
      
      if (orientation == Orientation.portrait) {
        width = boxConstraints.maxWidth.isNonZero(defaultValue: FIGMA_DESIGN_WIDTH);
        height = boxConstraints.maxHeight.isNonZero(defaultValue: FIGMA_DESIGN_HEIGHT);
      } else {
        width = boxConstraints.maxHeight.isNonZero(defaultValue: FIGMA_DESIGN_WIDTH);
        height = boxConstraints.maxWidth.isNonZero(defaultValue: FIGMA_DESIGN_HEIGHT);
      }
      
      // Determine device type based on width
      deviceType = width < 600 ? DeviceType.mobile : 
                  width < 900 ? DeviceType.tablet : 
                  DeviceType.desktop;
    } catch (e) {
      // Fallback to default values if any error occurs
      width = FIGMA_DESIGN_WIDTH.toDouble();
      height = FIGMA_DESIGN_HEIGHT.toDouble();
      deviceType = DeviceType.mobile;
    }
  }
}*/