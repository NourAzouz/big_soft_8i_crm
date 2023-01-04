import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '/core/models/demandes_Product_list_model.dart';
import '/ui/shared/navigation_router_paths.dart';
import '/ui/shared/size_config.dart';
import '/ui/widgets/contact_support_alert_view.dart';
import '/ui/widgets/loading_error_view.dart';
import '../../../../core/view_models/crm/product/demandes_Product_list_view_model.dart';
import '../../../widgets/search_bar.dart';
import '../../base_view.dart';

late List<ProductsProductListModel> productsResultsList;
late List<ProductsProductListModel> productsToShowInListView;
var _productsResult;
late bool dataLoadingError;
bool paginationFinish = false;
bool isListViewScrollable = false;
late ProductsProductListModel slectedDemandeSearchResult;
bool isProductsListViewBusy = false;
bool isProductsViewBusy = false;
late GlobalKey<FormState> _formKey;

List<ProductsProductListModel> getProductsListToSearchFrom() {
  return productsResultsList;
}

setProductToShowInListView(var demande) {
  productsToShowInListView.clear();
  productsToShowInListView.add(demande);
}

bool isLoadingProductDataError() {
  return dataLoadingError;
}

class DemandesProdcutListView extends StatefulWidget {
  //late GlobalKey<FormState> _formKey;
  final code_listPro;
  const DemandesProdcutListView({Key? key, this.code_listPro})
      : super(key: key);
  @override
  _DemandesProdcutListViewState createState() =>
      _DemandesProdcutListViewState();
}

class _DemandesProdcutListViewState extends State<DemandesProdcutListView> {
  late String code_listPro;

  late GlobalKey<ScaffoldState> _scaffoldKey;
  late GlobalKey<FormState> _formKey;
  bool dataFinishLoading = false;
  late String dataLoadingErrorMessage;
  int _indexToStartPaginatingFrom = 25;
  int _attachementFetchLimit = 25;
  late List<ProductsProductListModel> products;
  String query = '';

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _formKey = GlobalKey<FormState>();
    productsResultsList = [];
    productsToShowInListView = [];
    dataLoadingError = false;
    products = productsToShowInListView;
    code_listPro = widget.code_listPro;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BaseView<DemandesProductListViewModel>(
      onModelReady: (viewModel) async {
        print('jjjj: ');
        print(code_listPro);
        if (code_listPro != "") {
          print('pros here with no null');
          await getProductsProspect(viewModel: viewModel, context: context);
        } else {
          print('pros here with  null');
          await getProducts(viewModel: viewModel, context: context);
        }

        //await getProducts(viewModel: viewModel, context: context);
        // .whenComplete(() => startFeatureDiscovery(viewModel));
      },
      builder: (context, viewModel, child) => Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            Container(
              // Here the height of the container is 28% of our total height
              height: size.height * .28,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.purple,
                    Colors.white,
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: SizeConfig.heightMultiplier * 5),
                    Text(
                      "Produits",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(fontWeight: FontWeight.w900),
                    ),
                    buildSearch(),
                    SizedBox(height: SizeConfig.heightMultiplier * 3),
                    Expanded(
                      child: dataFinishLoading
                          ? SafeArea(
                              child: productsResultsList.isNotEmpty
                                  ? NotificationListener<ScrollNotification>(
                                      onNotification: (onScrollNotification) {
                                        if (onScrollNotification
                                            is ScrollUpdateNotification) {
                                          isListViewScrollable = true;
                                          if (onScrollNotification
                                                      .metrics.pixels >
                                                  0 &&
                                              onScrollNotification
                                                  .metrics.atEdge) {
                                            fetchMoreData(
                                              viewModel,
                                              _scaffoldKey.currentState,
                                              context,
                                            );
                                          }
                                        }
                                        return true;
                                      },
                                      child: RefreshIndicator(
                                        onRefresh: () async {
                                          code_listPro != ""
                                              ? await getProductsProspect(
                                                  viewModel: viewModel,
                                                  context: context,
                                                  scaffoldState:
                                                      _scaffoldKey.currentState,
                                                )
                                              : await getProducts(
                                                  viewModel: viewModel,
                                                  context: context,
                                                  scaffoldState:
                                                      _scaffoldKey.currentState,
                                                );
                                        },
                                        child:
                                            GroupedListView<dynamic, dynamic>(
                                          elements: products,
                                          groupBy: (element) => element.libelle,
                                          groupHeaderBuilder:
                                              (dynamic element) => Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 1,
                                            ),
                                            child: const Text(
                                              "",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          indexedItemBuilder: (context,
                                              dynamic element, index) {
                                            var circleAvatarIndex = index + 1;
                                            return Column(
                                              children: [
                                                ListTile(
                                                  title: Text(
                                                    '${products[index].libelle}',
                                                  ),
                                                  subtitle: code_listPro != ""
                                                      ? Text(
                                                          '${products[index].codeProduit}',
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        )
                                                      : Text(
                                                          '${products[index].codeArticle}',
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                  leading: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.purple,
                                                    foregroundColor:
                                                        Colors.white,
                                                    child: Text(
                                                        "$circleAvatarIndex"),
                                                  ),
                                                  onTap: () => {
                                                    if (code_listPro == "")
                                                      {
                                                        navigateToDemandeDetailsView(
                                                          _scaffoldKey
                                                              .currentContext!,
                                                          products[index],
                                                          viewModel,
                                                          _scaffoldKey
                                                              .currentState,
                                                        ),
                                                      }
                                                  },
                                                ),
                                                const Divider(
                                                  height: 0,
                                                ),
                                                !paginationFinish &&
                                                        isListViewScrollable &&
                                                        index ==
                                                            products.length - 1
                                                    ? const Padding(
                                                        padding: EdgeInsets.all(
                                                            16.0),
                                                        child: Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Colors.purple,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  : RefreshIndicator(
                                      onRefresh: () async {
                                        code_listPro != ""
                                            ? await getProductsProspect(
                                                viewModel: viewModel,
                                                context: context,
                                                scaffoldState:
                                                    _scaffoldKey.currentState,
                                              )
                                            : await getProducts(
                                                viewModel: viewModel,
                                                context: context,
                                                scaffoldState:
                                                    _scaffoldKey.currentState,
                                              );
                                      },
                                      child: SingleChildScrollView(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        child: Container(
                                          child: const Center(
                                            child: LoadingErrorView(
                                              imageURL:
                                                  "assets/images/add_file.png",
                                              errorMessage:
                                                  "Aucun produit enregistré",
                                            ),
                                          ),
                                          height:
                                              SizeConfig.heightMultiplier * 86,
                                        ),
                                      ),
                                    ),
                            )
                          : dataLoadingError
                              ? SafeArea(
                                  child: RefreshIndicator(
                                    onRefresh: () async {
                                      code_listPro != ""
                                          ? await getProductsProspect(
                                              viewModel: viewModel,
                                              context: context,
                                              scaffoldState:
                                                  _scaffoldKey.currentState,
                                            )
                                          : await getProducts(
                                              viewModel: viewModel,
                                              context: context,
                                              scaffoldState:
                                                  _scaffoldKey.currentState,
                                            );
                                    },
                                    child: SingleChildScrollView(
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      child: Container(
                                        child: Center(
                                          child: LoadingErrorView(
                                            imageURL: "assets/images/error.png",
                                            errorMessage:
                                                dataLoadingErrorMessage,
                                          ),
                                        ),
                                        height:
                                            SizeConfig.heightMultiplier * 86,
                                      ),
                                    ),
                                  ),
                                )
                              : const Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.purple),
                                  ),
                                ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSearch() => SearchBar(
        text: query,
        hintText: 'N° ou nom tiers',
        onChanged: searchProduct,
      );

  void searchProduct(String query) {
    final products = productsToShowInListView.where((product) {
      final codeArt = product.codeArticle.toLowerCase();
      final libArt = product.libelle.toLowerCase();
      final search = query.toLowerCase();

      return codeArt.contains(search) || libArt.contains(search);
    }).toList();

    setState(() {
      this.query = query;
      this.products = products;
    });
  }

  onPressAction(DemandesProductListViewModel viewModel, String code) async {
    var dd = await viewModel.deleteDemande(code);
    print(dd);
  }

  Future<void> getProducts({
    required DemandesProductListViewModel viewModel,
    required BuildContext context,
    int startIndex = 0,
    int fetchLimit = 25,
    bool isPagination = false,
    scaffoldState,
  }) async {
    isProductsListViewBusy = true;
    isListViewScrollable = false;
    dataLoadingError = false;
    _productsResult = await viewModel.getProductsList(startIndex, fetchLimit);
    if (_productsResult is List<ProductsProductListModel>) {
      if (isPagination) {
        productsResultsList += _productsResult;
        if (_productsResult.isEmpty) paginationFinish = true;
      } else {
        productsResultsList = _productsResult;
        _indexToStartPaginatingFrom = 25;
        paginationFinish = false;
      }
      productsToShowInListView.clear();
      for (var demande in productsResultsList) {
        productsToShowInListView.add(demande);
      }
      setState(() {
        dataFinishLoading = true;
      });
    } else if (_productsResult is int) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: const ContactSupportAlertView(),
          );
        },
      );
    } else {
      setState(() {
        dataLoadingErrorMessage = _productsResult;
        dataLoadingError = true;
      });
      if (dataFinishLoading) {
        scaffoldState.showSnackBar(
          SnackBar(
            content: Text(
              dataLoadingErrorMessage,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }
    isProductsListViewBusy = false;
  }

  Future<void> getProductsProspect({
    required DemandesProductListViewModel viewModel,
    required BuildContext context,
    int startIndex = 0,
    int fetchLimit = 25,
    bool isPagination = false,
    scaffoldState,
  }) async {
    isProductsListViewBusy = true;
    isListViewScrollable = false;
    dataLoadingError = false;
    _productsResult = await viewModel.getProductsProspectList(code_listPro);
    if (_productsResult is List<ProductsProductListModel>) {
      if (isPagination) {
        productsResultsList += _productsResult;
        if (_productsResult.isEmpty) paginationFinish = true;
      } else {
        productsResultsList = _productsResult;
        _indexToStartPaginatingFrom = 25;
        paginationFinish = false;
      }
      productsToShowInListView.clear();
      for (var demande in productsResultsList) {
        productsToShowInListView.add(demande);
      }
      setState(() {
        dataFinishLoading = true;
      });
    } else if (_productsResult is int) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: const ContactSupportAlertView(),
          );
        },
      );
    } else {
      setState(() {
        dataLoadingErrorMessage = _productsResult;
        dataLoadingError = true;
      });
      if (dataFinishLoading) {
        scaffoldState.showSnackBar(
          SnackBar(
            content: Text(
              dataLoadingErrorMessage,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }
    isProductsListViewBusy = false;
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  fetchMoreData(viewModel, scaffoldState, BuildContext context) async {
    if (!paginationFinish) {
      code_listPro != ""
          ? await getProductsProspect(
              viewModel: viewModel,
              context: context,
              scaffoldState: _scaffoldKey.currentState,
            )
          : await getProducts(
              viewModel: viewModel,
              context: context,
              scaffoldState: _scaffoldKey.currentState,
            );
      if (!dataLoadingError) {
        setState(() {
          _indexToStartPaginatingFrom += 25;
        });
      }
    }
  }

  navigateToDemandeDetailsView(BuildContext context,
      ProductsProductListModel product, viewModel, scaffoldState) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    Navigator.pushNamed(
      context,
      NavigationRouterPaths.DEMANDE_PRODUCT_DETAILS_TAB_VIEW,
      arguments: product,
    ).then(
      (_) async {
        productsToShowInListView.clear();
        dataFinishLoading = false;
        code_listPro != ""
            ? await getProductsProspect(
                viewModel: viewModel,
                context: context,
                scaffoldState: _scaffoldKey.currentState,
              )
            : await getProducts(
                viewModel: viewModel,
                context: context,
                scaffoldState: _scaffoldKey.currentState,
              );
      },
    );
  }

  DemandeProductDetailsViewArguments getDemandeDetailsViewArguments(
    int index,
  ) {
    return DemandeProductDetailsViewArguments(
      codeArticle: productsToShowInListView[index].codeArticle,
      libelle: productsToShowInListView[index].libelle,
      modele: productsToShowInListView[index].modele,
      reference: productsToShowInListView[index].reference,
      famille: productsToShowInListView[index].famille,
      stock: productsToShowInListView[index].stock,
      siteWeb: productsToShowInListView[index].siteWeb,
      codeBarres: productsToShowInListView[index].codeBarres,
      codeMesure: productsToShowInListView[index].codeMesure,
      collab: productsToShowInListView[index].collab,
      tva: productsToShowInListView[index].tva,
      refArt: productsToShowInListView[index].refArt,
      prix: productsToShowInListView[index].prix,
      dateInitf: productsToShowInListView[index].dateInitf,
    );
  }
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  return htmlText.replaceAll(exp, '');
}

class DemandeProductDetailsViewArguments {
  final String codeArticle;
  final String libelle;
  final String modele;
  final String reference;
  final String famille;
  final String stock;
  final String siteWeb;
  final String dateInitf;
  final String codeBarres;
  final String prix;
  final String codeMesure;
  final String tva;
  final String collab;
  final String refArt;
  DemandeProductDetailsViewArguments({
    required this.codeArticle,
    required this.libelle,
    required this.modele,
    required this.reference,
    required this.famille,
    required this.stock,
    required this.codeBarres,
    required this.codeMesure,
    required this.collab,
    required this.dateInitf,
    required this.prix,
    required this.refArt,
    required this.siteWeb,
    required this.tva,
  });
}
