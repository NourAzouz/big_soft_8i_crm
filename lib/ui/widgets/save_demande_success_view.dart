import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

import '/ui/shared/size_config.dart';

class SaveDemandeSuccessView extends StatelessWidget {
  final VoidCallback? action;

  const SaveDemandeSuccessView({Key? key, this.action}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            Positioned(
              top: SizeConfig.heightMultiplier * 25,
              width: SizeConfig.heightMultiplier * 40,
              height: SizeConfig.heightMultiplier * 28,
              child: Container(
                child: FlareActor(
                  "assets/flare_animations/success_check.flr",
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  animation: "play",
                  callback: (_) => action!(),
                ),
              ),
            ),
            Positioned(
              top: SizeConfig.heightMultiplier * 48,
              child: Text(
                'Enregistrer avec succès',
                style: TextStyle(
                  fontSize: SizeConfig.heightMultiplier * 3,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
