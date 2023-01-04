import 'package:big_soft_8i_crm/ui/views/crm/product/demande_Product_details_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DemandeProductDetailsTabView extends StatelessWidget {
  final product;
  const DemandeProductDetailsTabView({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.libelle),
          bottom: const TabBar(
            tabs: [
              Tab(text: "INFORMATIONS"),
              //Tab(text: "ARTICLES"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DemandeProductDetailsView(
              demandeProductDetailsViewArguments: product,
            ),
          ],
        ),
      ),
    );
  }
}
