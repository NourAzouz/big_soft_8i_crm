import 'package:big_soft_8i_crm/ui/views/crm/contact/demande_details_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DemandeDetailsTabView extends StatelessWidget {
  final demande;
  const DemandeDetailsTabView({Key? key, required this.demande})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(demande.compte),
          bottom: const TabBar(
            tabs: [
              Tab(text: "INFORMATIONS"),
              // ignore: avoid_print

              //Tab(text: "ARTICLES"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DemandeDetailsView(
              demandeDetailsViewArguments: demande,
            ),
          ],
        ),
      ),
    );
  }
}
