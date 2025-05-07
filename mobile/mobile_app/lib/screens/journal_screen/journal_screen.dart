// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mobile_app/core/utils/image_constant.dart';
import 'package:mobile_app/screens/home_screen.dart';
import 'package:mobile_app/screens/journal_screen/widgets/journalentries_item_widget.dart';
import 'package:mobile_app/theme/app_decoration.dart';
import 'package:mobile_app/theme/theme_helper.dart';
import 'package:mobile_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:mobile_app/widgets/app_bar/appbar_subtitle.dart';
import 'package:mobile_app/widgets/app_bar/custom_app_bar.dart';
import 'package:mobile_app/widgets/custom_icon_button.dart';
import 'package:mobile_app/widgets/custom_image_view.dart';
import 'package:mobile_app/widgets/custom_text_form_field.dart';

class JournalScreen extends StatelessWidget {
  JournalScreen({super.key});

  TextEditingController typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              // No horizontal padding to keep content full-width
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(top: 22),
                    decoration: AppDecoration.background,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: _buildAppBar(context),
                        ),
                        // Space between app bar and journal box
                        const SizedBox(height: 40),
                        Container(
                          width: double.maxFinite,
                          // Horizontal margin for side spacing
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                          decoration: AppDecoration.widgetorinput.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder6,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildJournalEntries(context),
                              SizedBox(
                                width: double.maxFinite,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: CustomTextFormField(
                                        controller: typeController,
                                        hintText: "Type Something...",
                                        textInputAction: TextInputAction.done,
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                18, 12, 18, 10),
                                        borderDecoration:
                                            TextFormFiledStyleHelper
                                                .outlinePrimary,
                                      ),
                                    ),
                                    CustomIconButton(
                                      height: 52,
                                      width: 52,
                                      padding: const EdgeInsets.all(14),
                                      decoration: IconButtonStyleHelper.none,
                                      child: CustomImageView(
                                        imagePath: ImageConstant.imgMessage,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 42),
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
      leadingWidth: 40,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowDownBlack900,
        margin: const EdgeInsets.only(left: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
      ),
      centerTitle: true,
      title: const AppbarSubtitle(text: "My Journal"),
    );
  }

  Widget _buildJournalEntries(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 4),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(
              height: 1,
              thickness: 1,
              color: theme.colorScheme.primaryContainer,
            ),
          );
        },
        itemCount: 6,
        itemBuilder: (context, index) {
          return const JournalEntriesItemWidget();
        },
      ),
    );
  }
}
