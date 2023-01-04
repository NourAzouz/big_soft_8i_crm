import 'package:flutter/material.dart';

import '../shared/size_config.dart';

class LoadingErrorView extends StatelessWidget {
  final imageURL;
  final errorMessage;

  const LoadingErrorView({
    Key? key,
    @required this.imageURL,
    @required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 6,
              ),
              child: IntrinsicHeight(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        imageURL,
                        height: SizeConfig.imageSizeMultiplier * 40,
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 6,
                      ),
                      Text(
                        errorMessage ??
                            "Une erreur est survenue lors du chargement des données",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 4.5,
                          height: 1.5,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
