import 'package:flutter/material.dart';

import '/core/constants/constants.dart';
import '/ui/shared/size_config.dart';

class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightMultiplier * 20,
      child: DrawerHeader(
        decoration: /*const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/drawer_background.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),*/
            const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_circle,
                  size: 53,
                  color: Colors.black54,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      Constants.username!,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Connecté',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(width: 3),
                        Container(
                          height: 10,
                          width: 10,
                          decoration: const ShapeDecoration(
                            shape: CircleBorder(),
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
