// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mobile_app/core/utils/image_constant.dart';
import 'package:mobile_app/theme/theme_helper.dart';
import 'package:mobile_app/widgets/custom_image_view.dart';

enum BottomBarEnum { home, sessions, groupsessions, account }

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key, this.onChanged});

  final Function(BottomBarEnum)? onChanged;

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  final List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgNavHome,
      activeIcon: ImageConstant.imgNavHome,
      title: "Home",
      type: BottomBarEnum.home,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgTelevision,
      activeIcon: ImageConstant.imgTelevision,
      title: "Sessions",
      type: BottomBarEnum.sessions,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavSessions,
      activeIcon: ImageConstant.imgNavSessions,
      title: "Sessions",
      type: BottomBarEnum.sessions,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavGroupSessions,
      activeIcon: ImageConstant.imgNavGroupSessions,
      title: "Group sessions",
      type: BottomBarEnum.groupsessions,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavAccount,
      activeIcon: ImageConstant.imgNavAccount,
      title: "Account",
      type: BottomBarEnum.account,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 26,
        right: 26,
        bottom: 24,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: bottomMenuList[index].icon,
                  height: 10,
                  width: 60,
                  color: theme.colorScheme.primaryContainer,
                ),
               const SizedBox(height: 46.710022),
                Text(
                  bottomMenuList[index].title ?? "",
                  style: TextStyle(
                    color: theme.colorScheme.onErrorContainer,
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            activeIcon: SizedBox(
              width: 30,
              child: Column(
                
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomImageView(
                    imagePath: bottomMenuList[index].activeIcon,
                    height: 26,
                    width: double.maxFinite,
                    color: theme.colorScheme.onErrorContainer,
                  ),
                  Text(
                    bottomMenuList[index].title ?? "",
                    style: theme.textTheme.labelMedium!.copyWith(
                      color: theme.colorScheme.onErrorContainer,
                    ),
                  ),
                ],
              ),
            ),
            label: '',
          );
        }),
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {});
        },
      ),
    );
  }
}

class BottomMenuModel {
  BottomMenuModel(
      {required this.icon,
      required this.activeIcon,
      this.title,
      required this.type});

  String icon;

  String activeIcon;

  String? title;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  const DefaultWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffffffff),
      padding: const EdgeInsets.all(10),
      child: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
