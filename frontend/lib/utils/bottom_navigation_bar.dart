import 'package:flutter/material.dart';
import 'package:frontend/utils/constants.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  BottomNavBar({required this.currentIndex, required this.onTap});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    double iconSize = MediaQuery.of(context).size.width * 0.06;
    return StylishBottomBar(
      option: DotBarOptions(
        dotStyle: DotStyle.tile,
        gradient: const LinearGradient(
          colors: [
            Colors.deepPurple,
            Colors.pink,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      items: [
        BottomBarItem(
          title: const Text('Home'),
          backgroundColor: kPrimary,
          selectedIcon: const Icon(Icons.home_filled),
          icon: SvgPicture.asset(
            'lib/assets/icons/home.svg',
            color: kPrimary,
            width: iconSize,
          ),
        ),
        BottomBarItem(
          icon: SvgPicture.asset(
            'lib/assets/icons/reels.svg',
            color: kPrimary,
            width: iconSize,
          ),
          title: const Text('Reels'),
          backgroundColor: kPrimary,
        ),
        BottomBarItem(
          icon: SvgPicture.asset(
            'lib/assets/icons/add.svg',
            color: kPrimary,
            width: MediaQuery.of(context).size.width * 0.08,
          ),
          title: const Text('Post'),
          backgroundColor: kPrimary,
        ),
        BottomBarItem(
            title: const Text('Message'),
            backgroundColor: kPrimary,
            icon: SvgPicture.asset(
              'lib/assets/icons/message.svg',
              color: kPrimary,
              width: iconSize,
            )),
        BottomBarItem(
          icon: SvgPicture.asset(
            'lib/assets/icons/account.svg',
            color: kPrimary,
            width: iconSize,
          ),
          title: const Text('Profile'),
          backgroundColor: kPrimary,
        ),
      ],
      // fabLocation: StylishBarFabLocation.end,
      // hasNotch: true,
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
    );
  }
}
