import 'package:big_soft_8i_crm/core/models/get_details_model.dart';

import 'package:big_soft_8i_crm/ui/views/auth/unite_exercice_view.dart';
import 'package:big_soft_8i_crm/ui/views/crm/activity/activity_details_tab_view.dart';
import 'package:big_soft_8i_crm/ui/views/crm/activity/activity_list_view.dart';
import 'package:big_soft_8i_crm/ui/views/crm/affaire/demande_affaire_details_tab_view.dart';
import 'package:big_soft_8i_crm/ui/views/crm/affaire/demandes_Affaires_list_view.dart';
import 'package:big_soft_8i_crm/ui/views/crm/compte/demande_compte_details_tab_view.dart';
import 'package:big_soft_8i_crm/ui/views/crm/compte/demandes_comptelist_view.dart';
import 'package:big_soft_8i_crm/ui/views/crm/contact/demande_details_tab_view.dart';
import 'package:big_soft_8i_crm/ui/views/crm/contact/demandes_list_view.dart';
import 'package:big_soft_8i_crm/ui/views/crm/demandes_calender.dart';
import 'package:big_soft_8i_crm/ui/views/crm/product/demande_product_details_tab_view.dart';
import 'package:big_soft_8i_crm/ui/views/crm/product/demandes_Product_list_view.dart';
import 'package:big_soft_8i_crm/ui/views/crm/prospect/demande_prospect_details_tab_view.dart';
import 'package:big_soft_8i_crm/ui/views/crm/prospect/demandes_Prospect_list_view.dart';

import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';

import '/ui/views/home_view.dart';
import '/ui/views/intro_view_carousel.dart';
import '/ui/views/root_view.dart';
import '/ui/views/startup_logic_view.dart';
import '../core/models/demandes_Product_list_model.dart';
import '../core/models/demandes_compte_model.dart';
import '../core/models/demandes_contact_list_model.dart';

import 'shared/navigation_router_paths.dart';

import 'views/auth/ip_address_setup_view.dart';
import 'views/auth/login_view.dart';

const String initialRoute = NavigationRouterPaths.STARTUP_LOGIC;

class NavigationRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationRouterPaths.STARTUP_LOGIC:
        return MaterialPageRoute(builder: (_) => StartupLogicView());
        break;
      case NavigationRouterPaths.INTRO:
        return MaterialPageRoute(builder: (_) => IntroViewCarousel());
        break;
      case NavigationRouterPaths.IP_ADDRESS_SETUP:
        return MaterialPageRoute(builder: (_) => IpAddressSetupView());
        break;
      case NavigationRouterPaths.LOGIN:
        return MaterialPageRoute(builder: (_) => LoginView());
        break;
      case NavigationRouterPaths.UNITE_EXERCICE:
        return MaterialPageRoute(builder: (_) => const UniteExerciceView());
        break;
      case NavigationRouterPaths.ROOT_VIEW:
        return MaterialPageRoute(
          builder: (_) => FeatureDiscovery(
            child: const RootView(),
            recordStepsInSharedPreferences: false,
          ),
        );
        break;
      case NavigationRouterPaths.HOME_VIEW:
        return MaterialPageRoute(builder: (_) => const HomeView());
        break;

      case NavigationRouterPaths.Demande_list:
        return MaterialPageRoute(builder: (_) => DemandesListView());
        break;

      case NavigationRouterPaths.Demandes_Calender:
        return MaterialPageRoute(builder: (_) => Callender());
        break;
      case NavigationRouterPaths.Demandes_Compte_list:
        return MaterialPageRoute(builder: (_) => DemandesCompteListView());
        break;
      case NavigationRouterPaths.Demandes_Product_list:
        final code = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => DemandesProdcutListView(
                  code_listPro: code as String,
                ));
        break;
      case NavigationRouterPaths.Demandes_Prospect_list:
        return MaterialPageRoute(builder: (_) => DemandesProspectListView());
        break;
      case NavigationRouterPaths.Demandes_Activity_list:
        final code = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => ActivityListView(
                  code_listAct: code as String,
                ));
      case NavigationRouterPaths.Demandes_Activity_list1:
        return MaterialPageRoute(builder: (_) => ActivityListView());
      case NavigationRouterPaths.Demandes_Affaire_list:
        return MaterialPageRoute(builder: (_) => DemandesAffaireListView());
        break;
      case NavigationRouterPaths.DEMANDE_COMPTE_DETAILS_TAB_VIEW:
        final s = settings.arguments;

        return MaterialPageRoute(
            builder: (_) => DemandeCompteDetailsTabView(
                  compte: s as DemandesCompteListModel,
                ));
        break;

      case NavigationRouterPaths.DEMANDE_PRODUCT_DETAILS_TAB_VIEW:
        final demandeProductDetailsViewArguments = settings.arguments;

        return MaterialPageRoute(
            builder: (_) => DemandeProductDetailsTabView(
                  product: demandeProductDetailsViewArguments
                      as ProductsProductListModel,
                ));
        break;
      case NavigationRouterPaths.DEMANDE_PROSPECT_DETAILS_TAB_VIEW:
        final demandeProspectDetailsViewArguments = settings.arguments;

        return MaterialPageRoute(
            builder: (_) => DemandeProspectDetailsTabView(
                  prospect: demandeProspectDetailsViewArguments as DetailsModel,
                ));
        break;
      case NavigationRouterPaths.DEMANDE_AFFAIRE_DETAILS_TAB_VIEW:
        final demandeAffaireDetailsViewArguments = settings.arguments;

        return MaterialPageRoute(
            builder: (_) => DemandeAffaireDetailsTabView(
                  affaire: demandeAffaireDetailsViewArguments as DetailsModel,
                ));
        break;
      case NavigationRouterPaths.DEMANDE_ACTIVITY_DETAILS_TAB_VIEW:
        final demandeActivityDetailsViewArguments = settings.arguments;

        return MaterialPageRoute(
            builder: (_) => ActivityDetailsTabView(
                  activity: demandeActivityDetailsViewArguments as DetailsModel,
                ));
        break;
      case NavigationRouterPaths.DEMANDE_DETAILS_TAB_VIEW:
        final demandeDetailsViewArguments = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => DemandeDetailsTabView(
            demande: demandeDetailsViewArguments as DemandesContactListModel,
          ),
        );
        break;
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
        break;
    }
  }
}
