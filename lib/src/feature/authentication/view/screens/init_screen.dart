// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizzle_starter/src/core/constant/theme/theme_constants.dart';
import 'package:sizzle_starter/src/feature/home/widget/Dashboard/view/home_screen.dart';
import 'package:sizzle_starter/src/feature/home/widget/Dashboard/view/profile/profile_screen.dart';
import 'package:flutter/services.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

import '../../../home/widget/Dashboard/view/booking_history/booking_history.dart';
import '../../../home/widget/Dashboard/view/notifications/notifications_screen.dart';
import '../../../home/widget/Dashboard/view/settings/settings_screen.dart';


class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  int currentSelectedIndex = 0;

  void updateCurrentIndex(int index) {
    setState(() {
      currentSelectedIndex = index;
    });
  }

  final pages = [
    const HomeScreen(),
    const BookingHistoryScreen(),// Update this with the corresponding screens
    const NotificationsScreen(),
    const SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const Color inActiveIconColor = Colors.grey; // Define your inactive icon color

    return Scaffold(
      body: pages[currentSelectedIndex],
      bottomNavigationBar: AnnotatedRegionWrapper(
        child: BottomNavigationBar(
          onTap: updateCurrentIndex,
          currentIndex: currentSelectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: inActiveIconColor,
              ),
              activeIcon: Icon(
                Icons.home,
                color: theme.primaryColor,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
                color: inActiveIconColor,
              ),
              activeIcon: Icon(
                Icons.history,
                color: theme.primaryColor,
              ),
              label: "Booking History",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications_outlined,
                color: inActiveIconColor,
              ),
              activeIcon: Icon(
                Icons.notifications,
                color: theme.primaryColor,
              ),
              label: "Notifications",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings_outlined,
                color: inActiveIconColor,
              ),
              activeIcon: Icon(
                Icons.settings,
                color: theme.primaryColor,
              ),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}




class AnnotatedRegionWrapper extends StatelessWidget {
  const AnnotatedRegionWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavBarStyle: FlexSystemNavBarStyle.transparent,
        useDivider: false,
      ),
      child: child,
    );
}
