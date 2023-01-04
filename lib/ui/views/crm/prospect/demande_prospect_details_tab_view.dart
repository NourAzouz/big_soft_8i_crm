import 'package:big_soft_8i_crm/ui/views/crm/prospect/demande_Prospect_details_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DemandeProspectDetailsTabView extends StatelessWidget {
  final prospect;
  const DemandeProspectDetailsTabView({Key? key, required this.prospect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(prospect.title),
          bottom: const TabBar(
            tabs: [
              Tab(text: "INFORMATIONS"),
              //Tab(text: "ARTICLES"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DemandeProspectDetailsView(
              demandeProspectDetailsViewArguments: prospect.code,
            ),
          ],
        ),
      ),
    );
  }
}
