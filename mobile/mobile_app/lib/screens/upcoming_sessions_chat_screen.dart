// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mobile_app/core/utils/image_constant.dart';
import 'package:mobile_app/screens/home_screen.dart';
import 'package:mobile_app/screens/sessions_screen/sessions_screen.dart';
import 'package:mobile_app/theme/app_decoration.dart';
import 'package:mobile_app/theme/custom_text_style.dart';
import 'package:mobile_app/theme/theme_helper.dart';
import 'package:mobile_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:mobile_app/widgets/app_bar/appbar_subtitle.dart';
import 'package:mobile_app/widgets/app_bar/custom_app_bar.dart';
import 'package:mobile_app/widgets/custom_elevated_button.dart';
import 'package:mobile_app/widgets/custom_icon_button.dart';
import 'package:mobile_app/widgets/custom_image_view.dart';
import 'package:mobile_app/widgets/custom_text_form_field.dart';

class UpcomingSessionsChatScreen extends StatefulWidget {
  const UpcomingSessionsChatScreen({super.key});

  @override
  State<UpcomingSessionsChatScreen> createState() =>
      _UpcomingSessionsChatScreenState();
}

class _UpcomingSessionsChatScreenState
    extends State<UpcomingSessionsChatScreen> {
  TextEditingController typeController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // List to store chat messages
  final List<ChatMessage> _messages = [
    ChatMessage(
      text:
          "Iste culpa voluptatum sed earum itaque. Velit cum id consequatur. Blanditiis suscipit facere eveniet sed. Incidunt quod modi illo nesciunt hic possimus. Cumque aspernatur fugit dolor.",
      isUser: false,
    ),
    ChatMessage(
      text: "Magni suscipit eos et praesentium odio at.",
      isUser: true,
    ),
    ChatMessage(
      text:
          "Iste culpa voluptatum sed earum itaque. Velit cum id consequatur. Blanditiis suscipit facere eveniet sed. Incidunt quod modi illo nesciunt hic possimus. Cumque aspernatur fugit dolor.",
      isUser: false,
    ),
    ChatMessage(
      text: "Magni suscipit eos et praesentium odio at.",
      isUser: true,
    ),
    ChatMessage(
      text:
          "Iste culpa voluptatum sed earum itaque. Velit cum id consequatur. Blanditiis suscipit facere eveniet sed. Incidunt quod modi illo nesciunt hic possimus. Cumque aspernatur fugit dolor.",
      isUser: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Scroll to the bottom initially
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(top: 22, bottom: 22),
                    decoration: AppDecoration.background,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: _buildAppBar(context),
                        ),
                        SizedBox(height: 28),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 38),
                            child: Text(
                              "Session With: Dr. Magdy",
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                        ),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.symmetric(horizontal: 36),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Timing: 9/1/2025 , 7:00 PM",
                                style: CustomTextStyles.titleSmallBlack900,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  "30 minutes",
                                  style: CustomTextStyles.labelLargeBlack900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.symmetric(horizontal: 36),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 20,
                          ),
                          decoration: AppDecoration.widgetorinput.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder6,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Dynamic message list
                              SizedBox(
                                height: 500, // Adjust height as needed
                                child: ListView.builder(
                                  controller: _scrollController,
                                  reverse:
                                      false, // Render list in natural order
                                  itemCount: _messages.length,
                                  itemBuilder: (context, index) {
                                    final message = _messages[index];
                                    return _buildMessage(message);
                                  },
                                ),
                              ),
                              SizedBox(height: 18),
                              Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.only(right: 6),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextFormField(
                                        controller: typeController,
                                        hintText: "Type Something ....",
                                        textInputAction: TextInputAction.done,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(18, 12, 18, 10),
                                        borderDecoration:
                                            TextFormFiledStyleHelper
                                                .outlinePrimary,
                                      ),
                                    ),
                                    CustomIconButton(
                                      height: 52,
                                      width: 52,
                                      padding: EdgeInsets.all(4),
                                      decoration: IconButtonStyleHelper.none,
                                      onTap: () =>
                                          _handleSubmitted(typeController.text),
                                      child: CustomImageView(
                                        imagePath: ImageConstant.imgFrame,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomElevatedButton(
                          text: "Ends in 25:15:10 ",
                          margin: const EdgeInsets.only(
                            left: 36,
                            right: 34,
                          ),
                          height: 54,
                          buttonStyle: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                          buttonTextStyle:
                              CustomTextStyles.titleMediumOnErrorContainer.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                            );
                          },
                        ),
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

  Widget _buildMessage(ChatMessage message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Align(
        alignment:
            message.isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 210, // Match original width
          margin: EdgeInsets.only(
            left: message.isUser ? 0 : 6,
            right: message.isUser ? 6 : 0,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),
          decoration: message.isUser
              ? AppDecoration.fillPrimaryContainer.copyWith(
                  borderRadius: BorderRadiusStyle.customBorderTL141,
                )
              : AppDecoration.background.copyWith(
                  borderRadius: BorderRadiusStyle.customBorderBL14,
                ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 6),
              Text(
                message.text,
                maxLines: 8,
                overflow: TextOverflow.ellipsis,
                style: message.isUser
                    ? CustomTextStyles.bodySmallOnErrorContainer
                    : theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      // Append new message to the end of the list
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
      ));
    });

    typeController.clear();
    // Scroll to the bottom after adding a new message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
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
            MaterialPageRoute(builder: (context) => SessionsScreen()),
          );
        },
      ),
      centerTitle: true,
      title: AppbarSubtitle(text: "Upcoming Sessions"),
    );
  }

  @override
  void dispose() {
    typeController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}
