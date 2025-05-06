import 'package:flutter/material.dart';
import 'package:mobile_app/core/utils/image_constant.dart';
import 'package:mobile_app/screens/appointment_screen/appointment_screen.dart';
import 'package:mobile_app/screens/check_out_screen/widgets/appointmentdurationlist_item_widget.dart';
import 'package:mobile_app/theme/app_decoration.dart';
import 'package:mobile_app/theme/custom_text_style.dart';
import 'package:mobile_app/theme/theme_helper.dart';
import 'package:mobile_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:mobile_app/widgets/app_bar/appbar_subtitle.dart';
import 'package:mobile_app/widgets/app_bar/custom_app_bar.dart';
import 'package:mobile_app/widgets/custom_drop_down.dart';
import 'package:mobile_app/widgets/custom_elevated_button.dart';
import 'package:mobile_app/widgets/custom_image_view.dart';
import 'package:mobile_app/widgets/custom_text_form_field.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  // Controllers for text fields
  TextEditingController cardHolderController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  // Dropdown items for appointment type
  List<String> appointmentTypeList = ["Chatting", "Voice Call", "Video Call"];
  String? selectedAppointmentType = "Video Call"; // Default selection

  // Duration options
  List<String> durationList = ["30 min", "1 hour", "2 hours"];
  String? selectedDuration = "30 min"; // Default selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: AppDecoration.background,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildAppBar(context),
                  const SizedBox(height: 20),
                  // Doctor Info
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.all(12),
                    decoration: AppDecoration.widgetorinput.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder6,
                    ),
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgEllipse254x54,
                          height: 50,
                          width: 50,
                          radius: BorderRadius.circular(25),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dr. Mark",
                                style: CustomTextStyles.titleSmallBlack900,
                              ),
                              Text(
                                "Clinical Psychologist",
                                style: CustomTextStyles.labelLargeBlack900_1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Appointment Type Section
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.all(16),
                    decoration: AppDecoration.widgetorinput.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder6,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Choose Type of Appointment",
                          style: CustomTextStyles.titleLargeBlack900SemiBold,
                        ),
                        const SizedBox(height: 12),
                        CustomDropDown(
                          value: selectedAppointmentType,
                          hintText: "Select Appointment Type",
                          hintStyle: CustomTextStyles.titleMediumBlack900_1,
                          items: appointmentTypeList,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          borderDecoration:
                              DropDownStyleHelper.underLinePrimaryContainer,
                          filled: false,
                          onChanged: (value) {
                            setState(() {
                              selectedAppointmentType = value;
                            });
                          },
                        ),
                        const SizedBox(height: 12),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: durationList.map((duration) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: AppointmentDurationListItemWidget(
                                  text: duration,
                                  isSelected: duration == selectedDuration,
                                  onTap: () {
                                    setState(() {
                                      selectedDuration = duration;
                                    });
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        CustomElevatedButton(
                            text: "Confirm",
                            height: 50,
                            buttonStyle: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            buttonTextStyle: CustomTextStyles
                                .titleMediumOnErrorContainer
                                .copyWith(
                              fontSize: 22,
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Payment Section
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.all(16),
                    decoration: AppDecoration.widgetorinput.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder6,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 16,
                              width: 16,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Credit Card / Debit Card",
                              style: CustomTextStyles.titleMediumBlack900,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Divider(color: theme.colorScheme.primaryContainer),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          controller: cardHolderController,
                          hintText: "Card Holder",
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          borderDecoration: InputBorder.none, // Remove border
                          filled: false,
                          prefix: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: CustomImageView(
                              imagePath: ImageConstant.imgUser,
                              height: 16,
                              width: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Divider(color: theme.colorScheme.primaryContainer),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          controller: cardNumberController,
                          hintText: "Card Number",
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          borderDecoration: InputBorder.none, // Remove border
                          filled: false,
                          prefix: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: CustomImageView(
                              imagePath: ImageConstant.imgCard,
                              height: 16,
                              width: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Divider(color: theme.colorScheme.primaryContainer),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextFormField(
                              controller: expiryDateController,
                              hintText: "MM/YY",
                              width: 120,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              borderDecoration: TextFormFiledStyleHelper
                                  .outlinePrimaryContainer,
                              filled: false,
                            ),
                            CustomTextFormField(
                              controller: cvvController,
                              hintText: "CVV",
                              width: 120,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              borderDecoration: TextFormFiledStyleHelper
                                  .outlinePrimaryContainer,
                              filled: false,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Total Amount
                  Text(
                    "Total Amount: LE 500",
                    style: CustomTextStyles.titleLargePrimaryContainer,
                  ),
                  const SizedBox(height: 28),
                  // Checkout Button
                  CustomElevatedButton(
                    text: "Check Out",
                    margin: EdgeInsets.symmetric(horizontal: 36),
                    height: 50,
                    buttonStyle: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    buttonTextStyle:
                        CustomTextStyles.titleMediumOnErrorContainer.copyWith(
                          fontSize: 22,
                        ),
                    onPressed: () {
                      // Navigator.push(
                      // context,
                      // MaterialPageRoute(builder: (context) => const PaymentScreen()),
                      // );
                    },
                  ),
                  const SizedBox(height: 24),
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
        margin: EdgeInsets.only(left: 36),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AppointmentScreen()),
          );
        },
      ),
      centerTitle: true,
      title: AppbarSubtitle(text: "Check Out"),
    );
  }
}

// Updated AppointmentDurationListItemWidget to support dynamic text, selection, and tap events
class AppointmentDurationListItemWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;

  const AppointmentDurationListItemWidget({
    super.key,
    required this.text,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: AppDecoration.outlinePrimary.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder6,
          color: isSelected ? theme.colorScheme.primaryContainer : null,
        ),
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: CustomTextStyles.bodyMediumBlack900,
        ),
      ),
    );
  }
}
