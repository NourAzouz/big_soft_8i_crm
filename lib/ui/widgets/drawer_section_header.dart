import 'package:flutter/material.dart';

import '../shared/size_config.dart';

class DrawerSectionHeader extends StatelessWidget {
  final sectionLabel;

  const DrawerSectionHeader({
    Key? key,
    @required this.sectionLabel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: SizeConfig.heightMultiplier * 1.2,
          left: 10,
          bottom: SizeConfig.heightMultiplier * 2),
      child: Text(
        sectionLabel,
        style: TextStyle(color: Colors.black54),
      ),
    );
  }
}
