/*import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/core/utils/image_constant.dart';
import 'package:mobile_app/screens/appointment_screen/widgets/timeslots_item_widget.dart';
import 'package:mobile_app/theme/app_decoration.dart';
import 'package:mobile_app/theme/custom_text_style.dart';
import 'package:mobile_app/theme/theme_helper.dart';
import 'package:mobile_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:mobile_app/widgets/app_bar/appbar_subtitle.dart';
import 'package:mobile_app/widgets/app_bar/custom_app_bar.dart';
import 'package:mobile_app/widgets/custom_elevated_button.dart';
import 'package:mobile_app/widgets/custom_image_view.dart';
import 'package:responsive_grid/responsive_grid.dart';

class AppointmentScreen extends StatelessWidget {
  AppointmentScreen({super.key});

  List<DateTime?> selectedDatesFromCalender = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 26),
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(top: 22),
                    decoration: AppDecoration.background,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: _buildAppBar(context),
                        ),
                        SizedBox(height: 48),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 36),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 6,
                          ),
                          decoration: AppDecoration.widgetorinput.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder6,
                          ),
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgEllipse254x54,
                                height: 54,
                                width: 54,
                                radius: BorderRadius.circular(26),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Dr. Mark",
                                      style: theme.textTheme.titleSmall,
                                    ),
                                    Text(
                                      "Clinical Psychologist",
                                      style:
                                          CustomTextStyles.labelLargeBlack900_1,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        _buildCalendarSection(context),
                        SizedBox(height: 20),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.symmetric(horizontal: 36),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: AppDecoration.widgetorinput.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder6,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Time Available",
                                style: CustomTextStyles.titleLargeBlack900_1,
                              ),
                              _buildTimeSlots(context),
                              SizedBox(height: 8),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomElevatedButton(
                          text: "Proceed",
                          margin: EdgeInsets.only(left: 36, right: 34),
                        ),
                        SizedBox(height: 46),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 60,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowdown,
        margin: EdgeInsets.only(left: 36),
      ),
      centerTitle: true,
      title: AppbarSubtitle(text: "Appointment"),
    );
  }

  Widget _buildCalendarSection(BuildContext context) {
    return Container(
      height: 230,
      width: 356,
      margin: EdgeInsets.symmetric(horizontal: 36),
      child: CalendarDatePicker2(
        config: CalendarDatePicker2Config(
          calendarType: CalendarDatePicker2Type.single,
          firstDate: DateTime(DateTime.now().year - 5),
          lastDate: DateTime(DateTime.now().year + 5),
          selectedDayHighlightColor: Color(0XFF06303E),
          centerAlignModePicker: true,
          firstDayOfWeek: 0,
          controlsHeight: 28,
          selectedDayTextStyle: TextStyle(
            color: theme.colorScheme.onErrorContainer,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
          controlsTextStyle: TextStyle(
            color: appTheme.black900,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
          dayTextStyle: TextStyle(
            color: appTheme.black900,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
          dayBorderRadius: BorderRadius.circular(6),
        ),
        value: selectedDatesFromCalender,
        onValueChanged: (dates) {},
      ),
    );
  }

  Widget _buildTimeSlots(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: ResponsiveGridListBuilder(
        minItemWidth: 1,
        minItemsPerRow: 3,
        horizontalGridSpacing: 40,
        verticalGridSpacing: 40,
        builder: (context, items) => ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          children: items,
        ),
        gridItems: List.generate(12, (index) {
          return TimeSlotsItemWidget();
        }),
      ),
    );
  }
}*/
