import 'package:flutter/material.dart';
import 'package:mobile_app/core/utils/image_constant.dart';
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

class CheckOutScreen extends StatelessWidget {
   CheckOutScreen({super.key});

  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];

  TextEditingController expiryDateInputController = TextEditingController();

  TextEditingController cvvInputController = TextEditingController();

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
                    padding: EdgeInsets.only(top: 20),
                    decoration: AppDecoration.background,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: _buildAppBar(context),
                        ),
                        SizedBox(height: 46),
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
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.symmetric(horizontal: 36),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          decoration: AppDecoration.widgetorinput.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder6,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Choose Type of Appointment",
                                style:
                                    CustomTextStyles.titleLargeBlack900SemiBold,
                              ),
                              CustomDropDown(
                                hintText: "Video Call",
                                hintStyle: theme.textTheme.titleMedium!,
                                items: dropdownItemList,
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 12, 12, 4),
                                borderDecoration: DropDownStyleHelper
                                    .underLinePrimaryContainer,
                                filled: false,
                              ),
                              _buildAppointmentDurationList(context),
                              _buildConfirmButton(context),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.symmetric(horizontal: 36),
                          padding: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 12),
                          decoration: AppDecoration.widgetorinput.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder6,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 8),
                              Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 14,
                                      width: 14,
                                      margin: EdgeInsets.only(top: 2),
                                      decoration: BoxDecoration(
                                        color:
                                            theme.colorScheme.primaryContainer,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Credit Card / Debit Card",
                                          style: theme.textTheme.titleMedium,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16),
                              SizedBox(
                                width: double.maxFinite,
                                child: Divider(),
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                child: _buildCardNumberRow(
                                  context,
                                  carOne: ImageConstant.imgUser,
                                  cardnumberOne: "Card Holder",
                                ),
                              ),
                              SizedBox(height: 18),
                              SizedBox(
                                width: double.maxFinite,
                                child: Divider(),
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                child: _buildCardNumberRow(
                                  context,
                                  carOne: ImageConstant.imgCard,
                                  cardnumberOne: "Card Number",
                                ),
                              ),
                              SizedBox(height: 18),
                              SizedBox(
                                width: double.maxFinite,
                                child: Divider(),
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                width: double.maxFinite,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildExpiryDateInput(context),
                                    _buildCvvInput(context),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Total Ammount:",
                                style: CustomTextStyles.titleLargeBlack900_2,
                              ),
                              TextSpan(text: " "),
                              TextSpan(
                                text: " LE 500",
                                style:
                                    CustomTextStyles.titleLargePrimaryContainer,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 28),
                        _buildCheckoutButton(context),
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
      title: AppbarSubtitle(text: "Check Out"),
    );
  }

  Widget _buildAppointmentDurationList(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 32,
          children: List.generate(3, (index) {
            return AppointmentDurationListItemWidget();
          }),
        ),
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return CustomElevatedButton(
      height: 52,
      text: "Confirm",
      buttonTextStyle: CustomTextStyles.titleLargeOnErrorContainer,
    );
  }

  Widget _buildExpiryDateInput(BuildContext context) {
    return CustomTextFormField(
      width: 132,
      controller: expiryDateInputController,
      hintText: "MM/YY",
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      borderDecoration: TextFormFiledStyleHelper.outlinePrimaryContainer,
      filled: false,
    );
  }

  Widget _buildCvvInput(BuildContext context) {
    return CustomTextFormField(
      width: 132,
      controller: cvvInputController,
      hintText: "CVV",
      textInputAction: TextInputAction.done,
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      borderDecoration: TextFormFiledStyleHelper.outlinePrimaryContainer,
      filled: false,
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return CustomElevatedButton(
      text: "Check Out",
      margin: EdgeInsets.only(left: 36, right: 34),
    );
  }

  Widget _buildCardNumberRow(
    BuildContext context, {
    required String carOne,
    required String cardnumberOne,
  }) {
    return Row(
      children: [
        CustomImageView(
          imagePath: carOne,
          height: 12,
          width: 14,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            cardnumberOne,
            style: theme.textTheme.titleMedium!.copyWith(
              color: appTheme.black900,
            ),
          ),
        ),
      ],
    );
  }
}
