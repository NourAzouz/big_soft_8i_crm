import 'package:big_soft_8i_crm/ui/views/crm/compte/demande_Compte_details_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DemandeCompteDetailsTabView extends StatelessWidget {
  final compte;
  const DemandeCompteDetailsTabView({Key? key, required this.compte})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(compte.nomTiers),
          bottom: const TabBar(
            tabs: [
              Tab(text: "INFORMATIONS"),
              //Tab(text: "ARTICLES"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DemandeCompteDetailsView(
              demandeCompteDetailsViewArguments: compte,
            ),
          ],
        ),
      ),
    );
  }
}
