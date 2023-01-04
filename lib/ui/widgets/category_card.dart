import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/constants/constants.dart';

class CategoryCard extends StatelessWidget {
  //final String? svgSrc;
  final IconData? iconSrc;
  final FaIcon? icon;
  final String title;
  final VoidCallback press;
  const CategoryCard({
    Key? key,
    //this.svgSrc,
    required this.title,
    required this.press,
    this.iconSrc,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(20),
      /* decoration: BoxDecoration(
          color: Colors.white,//const Color(0xFFFCFCFC),
          borderRadius: BorderRadius.circular(13),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -23,
              color: kShadowColor,
            ),
          ],
        ),*/
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: press,
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Column(
              children: <Widget>[
                // SvgPicture.asset(svgSrc!),
                Icon(
                  iconSrc,
                  color: Colors.black54,
                  size: 25.5,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
                //const Spacer(),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
