import 'package:flutter/material.dart';

class DrawerItemWithBackground extends StatelessWidget {
  final String? itemLabel;
  final IconData? icon;
  final bool? isSelectedItem;
  final VoidCallback? onTapAction;

  const DrawerItemWithBackground({
    Key? key,
    @required this.itemLabel,
    @required this.icon,
    @required this.isSelectedItem,
    this.onTapAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: isSelectedItem! ? Colors.purple[50] : Colors.transparent,
      ),
      child: ListTile(
        title: Text(
          itemLabel!,
          style: TextStyle(
            color: isSelectedItem! ? Colors.blue : null,
          ),
        ),
        leading: Icon(
          icon,
          color: isSelectedItem! ? Colors.blue : Colors.black87,
        ),
        onTap: onTapAction,
      ),
    );
  }
}
