import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({
    required this.navigationShell,
    super.key,
  });
  final StatefulNavigationShell navigationShell;

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int selectedIndex = 0;

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: widget.navigationShell,
        ),
        bottomNavigationBar: BottomBarInspiredOutside(
          items: const [
            TabItem(
              icon: Icons.home,
              // title: 'Home',
            ),
            TabItem(
              icon: Icons.calendar_month,
              title: 'Appointments',
            ),
            TabItem(
              icon: Icons.notifications,
              title: 'Notifications',
            ),
            TabItem(
              icon: Icons.person,
              title: 'Profile',
            ),
          ],
          titleStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white,
              ),
          backgroundColor:Theme.of(context).colorScheme.primary,
          color: Colors.white,
          colorSelected: Colors.white,
          indexSelected: selectedIndex,
          onTap: (int index) {
                   setState(() {
            selectedIndex = index;
          });
          _goBranch(selectedIndex);
          },
          top: -28,
          animated: false,
          itemStyle: ItemStyle.circle,
          chipStyle:
              const ChipStyle(notchSmoothness: NotchSmoothness.verySmoothEdge),
        ),
      );
}
