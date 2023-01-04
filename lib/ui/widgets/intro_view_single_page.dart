import 'package:flutter/material.dart';
import '/ui/shared/size_config.dart';

class IntroViewSinglePage extends StatelessWidget {
  final IntroScreenModel? introScreenModel;

  const IntroViewSinglePage({Key? key, this.introScreenModel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          SizeConfig.widthMultiplier * 8,
          SizeConfig.heightMultiplier * 4.8,
          SizeConfig.widthMultiplier * 8,
          0,
        ),
        child: Column(
          children: [
            Text(
              introScreenModel?.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                height: 1.3,
                fontSize: SizeConfig.textMultiplier * 6,
              ),
            ),
            SizedBox(height: SizeConfig.heightMultiplier * 10),
            Image.asset(
              introScreenModel?.imageURL,
              height: SizeConfig.imageSizeMultiplier * 40,
            ),
            SizedBox(height: SizeConfig.heightMultiplier * 5),
            Expanded(
              child: Center(
                child: Text(
                  introScreenModel?.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 4,
                    height: 1.3,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IntroScreenModel {
  final imageURL;
  final title;
  final text;

  IntroScreenModel({
    this.imageURL,
    this.title,
    this.text,
  });
}

class IntroScreenDots extends StatelessWidget {
  final bool isActive;

  const IntroScreenDots(this.isActive);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      height: 6,
      width: 6,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: isActive ? Colors.purple : Colors.grey[300],
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}

List<IntroScreenModel> introScreenList = [
  IntroScreenModel(
    imageURL: "assets/images/Generating new leads-amico.png",
    title: "Gérez votre entreprise depuis votre poche",
    text:
        " Avec l'application mobile BigSoft 8i crm, vous pouvez vous connecter en toute sécurité à votre compte BigSoft et gérer vos activitées lors de vos déplacements.",
  ),
  IntroScreenModel(
    imageURL: "assets/images/Customer relationship management-rafiki.png",
    title: "Gardez une trace de votre entreprise",
    text:
        "Consultez vos factures, vos clients, vos stocks, vos prospects, vos affaires et plus.....",
  ),
];
