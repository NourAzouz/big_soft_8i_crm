// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/constants/constants.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const BottomNavItem(
            title: "Aujourd'hui",
            iconSrc: FontAwesomeIcons.list,
            //svgScr: "assets/icons/calendar.svg",
          ),
          const BottomNavItem(
            title: "Accueil",
            iconSrc: FontAwesomeIcons.home,
            //svgScr: "assets/icons/gym.svg",
            isActive: true,
          ),
          const BottomNavItem(
            title: "Se déconnecter",
            iconSrc: FontAwesomeIcons.signOutAlt,
            //svgScr: "assets/icons/Settings.svg",
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  //final String svgScr;
  final IconData? iconSrc;
  final String title;
  final VoidCallback? press;
  final bool isActive;
  const BottomNavItem({
    Key? key,
    //required this.svgScr,
    required this.title,
    this.iconSrc,
    this.press,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          /*SvgPicture.asset(
            svgScr,
            color: isActive ? kActiveIconColor : kTextColor,
          ),*/
          Icon(
            iconSrc,
            color: isActive ? kActiveIconColor : kTextColor,
            size: 20.0,
            semanticLabel: 'Text to announce in accessibility modes',
          ),
          Text(
            title,
            style: TextStyle(color: isActive ? kActiveIconColor : kTextColor),
          ),
        ],
      ),
    );
  }
}
