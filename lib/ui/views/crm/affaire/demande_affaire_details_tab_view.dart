import 'package:big_soft_8i_crm/ui/views/crm/affaire/demande_Affaires_details_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DemandeAffaireDetailsTabView extends StatelessWidget {
  final affaire;
  const DemandeAffaireDetailsTabView({Key? key, required this.affaire})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(affaire.title),
          bottom: const TabBar(
            tabs: [
              Tab(text: "INFORMATIONS"),
              //Tab(text: "ARTICLES"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DemandeAffaireDetailsView(
              demandeAffaireDetailsViewArguments: affaire.code,
            ),
          ],
        ),
      ),
    );
  }
}
