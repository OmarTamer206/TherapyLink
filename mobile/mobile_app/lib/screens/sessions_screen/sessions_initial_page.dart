import 'package:flutter/material.dart';
import 'package:mobile_app/screens/sessions_screen/widgets/previoussessionslist_item_widget.dart';
import 'package:mobile_app/screens/sessions_screen/widgets/upcomingsessionslist_item_widget.dart';
import 'package:mobile_app/theme/app_decoration.dart';
import 'package:mobile_app/theme/custom_text_style.dart';
import 'package:mobile_app/theme/theme_helper.dart';
import 'package:mobile_app/widgets/app_bar/appbar_subtitle.dart';
import 'package:mobile_app/widgets/app_bar/custom_app_bar.dart';

class SessionsInitialPage extends StatefulWidget {
  const SessionsInitialPage({super.key});

  @override
  State<SessionsInitialPage> createState() => _SessionsInitialPageState();
}

class _SessionsInitialPageState extends State<SessionsInitialPage> {
  @override
  Widget build(BuildContext context) {
    // Get the screen width to calculate a smaller container width
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth * 0.9; // 90% of screen width

    return SingleChildScrollView(
      child: Container(
        width: double.maxFinite,
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(top: 18),
              decoration: AppDecoration.background,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: _buildAppBar(context),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Text(
                      "Upcoming Sessions",
                      style: CustomTextStyles.titleLargeBlack900.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: SizedBox(
                      width: containerWidth,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Reduced padding
                        decoration: AppDecoration.widgetorinput.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder6,
                          border: const Border(
                            left: BorderSide(
                              color: Color(0xffffffff),
                              width: 1,
                            ),
                            right: BorderSide(
                              color: Color(0xffffffff),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [_buildUpcomingSessionsList(context)],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Text(
                      "Previous Sessions",
                      style: CustomTextStyles.titleLargeBlack900.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: SizedBox(
                      width: containerWidth,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Reduced padding
                        decoration: AppDecoration.widgetorinput.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder6,
                          border:const Border(
                            left: BorderSide(
                              color: Color(0xffffffff),
                              width: 1,
                            ),
                            right: BorderSide(
                              color: Color(0xffffffff),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [_buildPreviousSessionsList(context)],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return const CustomAppBar(
      centerTitle: true,
      title: AppbarSubtitle(text: "Sessions"),
    );
  }

  Widget _buildUpcomingSessionsList(BuildContext context) {
    return ListView.separated(
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
      itemCount: 5,
      itemBuilder: (context, index) {
        return const UpcomingSessionsListItemWidget();
      },
    );
  }

  Widget _buildPreviousSessionsList(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 9.0),
          child: Divider(
            height: 1,
            thickness: 1,
            color: theme.colorScheme.primaryContainer,
          ),
        );
      },
      itemCount: 8,
      itemBuilder: (context, index) {
        return const PreviousSessionListItemWidget();
      },
    );
  }
}