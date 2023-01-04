import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String? itemLabel;
  final IconData? icon;
  final VoidCallback? onTapAction;

  const DrawerItem({
    Key? key,
    this.itemLabel,
    this.icon,
    this.onTapAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(itemLabel!),
      leading: Icon(
        icon,
        color: Colors.black87,
      ),
      onTap: onTapAction,
    );
  }
}
