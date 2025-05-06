import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/core/utils/image_constant.dart';
import 'package:mobile_app/screens/appointment_screen/widgets/timeslots_item_widget.dart';
import 'package:mobile_app/screens/check_out_screen.dart';
import 'package:mobile_app/screens/doctor_s_one_screen.dart';
import 'package:mobile_app/theme/app_decoration.dart';
import 'package:mobile_app/theme/custom_text_style.dart';
import 'package:mobile_app/theme/theme_helper.dart';
import 'package:mobile_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:mobile_app/widgets/app_bar/appbar_subtitle.dart';
import 'package:mobile_app/widgets/app_bar/custom_app_bar.dart';
import 'package:mobile_app/widgets/custom_elevated_button.dart';
import 'package:mobile_app/widgets/custom_image_view.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  List<DateTime?> selectedDatesFromCalender = [];
  String? selectedTime; // Track the selected time slot

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 22),
                    decoration: AppDecoration.background,
                    child: Column(
                      children: [
                        _buildAppBar(context),
                        const SizedBox(height: 48),
                        Container(
                          width: 340,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 6),
                          decoration: AppDecoration.widgetorinput.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder6,
                          ),
                          child: Row(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgEllipse254x54,
                                height: 54,
                                width: 54,
                                radius: BorderRadius.circular(26),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Dr. Mark",
                                        style: theme.textTheme.titleSmall),
                                    Text("Clinical Psychologist",
                                        style: CustomTextStyles
                                            .labelLargeBlack900_1),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildCalendarSection(context),
                        const SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.zero,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: AppDecoration.widgetorinput.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder6,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Time Available",
                                  style: CustomTextStyles.titleLargeBlack900_1),
                              const SizedBox(height: 16),
                              _buildTimeSlots(context),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomElevatedButton(
                          text: "Proceed",
                          margin:const EdgeInsets.only(left: 36, right: 34),
                          height: 50,
                          buttonStyle: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                           onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const CheckOutScreen()),
                            );
                          },
                        ),
                        const SizedBox(height: 46),
                      ],
                    ),
                  ),
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
        imagePath: ImageConstant.imgArrowDownBlack900,
        margin: const EdgeInsets.only(left: 36),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>const DoctorSOneScreen()),
          );
        },
      ),
      centerTitle: true,
      title: const AppbarSubtitle(text: "Appointment"),
    );
  }

  Widget _buildCalendarSection(BuildContext context) {
    return Container(
      height: 300,
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 36),
      decoration: BoxDecoration(
        color: theme.colorScheme.onErrorContainer,
        borderRadius: BorderRadiusStyle.roundedBorder6,
      ),
      child: CalendarDatePicker2(
        config: CalendarDatePicker2Config(
          calendarType: CalendarDatePicker2Type.single,
          firstDate: DateTime(DateTime.now().year - 5),
          lastDate: DateTime(DateTime.now().year + 5),
          selectedDayHighlightColor: const Color(0XFF06303E),
          centerAlignModePicker: true,
          firstDayOfWeek: 0,
          controlsHeight: 50,
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
        onValueChanged: (dates) {
          setState(() {
            selectedDatesFromCalender = dates;
          });
        },
      ),
    );
  }

  Widget _buildTimeSlots(BuildContext context) {
    List<String> timeSlots = [
      "2:00 PM",
      "2:30 PM",
      "3:00 PM",
      "3:30 PM",
      "4:00 PM",
      "4:30 PM",
      "5:00 PM",
      "5:30 PM",
      "6:00 PM",
      "6:30 PM",
      "7:00 PM",
      "8:30 PM",
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 12,
      children: timeSlots.map((time) {
       return SizedBox(
          width: (MediaQuery.of(context).size.width - 130) / 3,
          child: TimeSlotsItemWidget(
            time: time,
            isSelected: selectedTime == time,
            onTap: () {
              setState(() {
                selectedTime = time;
              });
            },
          ),
        );
      }).toList(),
    );
  }
}