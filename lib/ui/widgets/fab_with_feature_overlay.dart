import 'package:flutter/material.dart';
import 'package:feature_discovery/feature_discovery.dart';

class FabWithFeatureOverlay extends StatelessWidget {
  final VoidCallback? onPress;

  const FabWithFeatureOverlay({
    Key? key,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DescribedFeatureOverlay(
      featureId: "fabFeature",
      tapTarget: const Icon(
        Icons.add,
        color: Colors.blue,
      ),
      backgroundColor: Colors.blue,
      title: const Text("Ajouter des crm"),
      description: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            "Cliquez ici pour ajouter de nouvelles crm",
            style: TextStyle(height: 1.3),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: onPress,
        child: const Icon(Icons.add),
      ),
    );
  }
}
