import 'package:get_it/get_it.dart';

import '/core/view_models/home_view_model.dart';
import '/core/view_models/intro_view_model.dart';

import 'core/view_models/auth/ip_address_setup_view_model.dart';

import '/core/view_models/root_view_model.dart';
import '/core/view_models/startup_logic_view_model.dart';

import 'core/services/authentication_service.dart';

import 'core/services/crm/demandes_Activity_list_service.dart';
import 'core/services/crm/demandes_Affaire_list_service.dart';
import 'core/services/crm/demandes_Product_list_service.dart';
import 'core/services/crm/demandes_Prospect_list_service.dart';
import 'core/services/crm/demandes_compte_service.dart';
import 'core/services/crm/demandes_list_service.dart';
import 'core/services/crm/documents_service.dart';

import 'core/services/local_storage_service.dart';

import 'core/view_models/auth/login_view_model.dart';
import 'core/view_models/auth/unite_exerice_view_model.dart';
import 'core/view_models/contact_support_alert_view_model.dart';

import 'core/view_models/crm/activity/demande_activity_details_view_model.dart';
import 'core/view_models/crm/activity/demandes_Activity_list_view_model.dart';
import 'core/view_models/crm/affaire/demande_affaire_details_view_model.dart';
import 'core/view_models/crm/affaire/demandes_Affaire_list_view_model.dart';
import 'core/view_models/crm/compte/demande_compte_details_view_model.dart';
import 'core/view_models/crm/compte/demandes_CompteList_view_model.dart';
import 'core/view_models/crm/contact/demande_list_details_view_model.dart';
import 'core/view_models/crm/contact/demandes_list_view_model.dart';
import 'core/view_models/crm/product/demande_product_details_view_model.dart';
import 'core/view_models/crm/product/demandes_Product_list_view_model.dart';
import 'core/view_models/crm/prospect/demande_prospect_details_view_model.dart';
import 'core/view_models/crm/prospect/demandes_Prospect_list_view_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  ///services registration
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => LocalStorageService());

  // CRM PART
  // locator.registerLazySingleton(() => ContactService());
  locator.registerLazySingleton(() => DemandesListService());
  locator.registerLazySingleton(() => DemandesCompteListService());
  locator.registerLazySingleton(() => DemandesProductListService());
  locator.registerLazySingleton(() => DocumentsService());
  locator.registerLazySingleton(() => DemandesProspectListService());
  locator.registerLazySingleton(() => DemandesActivityListService());
  locator.registerLazySingleton(() => DemandesAffaireListService());

  ///view models registration
  locator.registerFactory(() => StartupLogicViewModel());
  locator.registerFactory(() => IntroViewModel());
  locator.registerFactory(() => IpAddressSetupViewModel());
  locator.registerFactory(() => LoginViewModel());
  locator.registerFactory(() => UniteExerciceViewModel());
  locator.registerFactory(() => RootViewModel());
  locator.registerFactory(() => HomeViewModel());

  locator.registerFactory(() => ContactSupportAlertViewModel());

  locator.registerFactory(() => DemandesListViewModel());
  locator.registerFactory(() => DemandesProductListViewModel());
  locator.registerFactory(() => DemandesAffaireListViewModel());
  locator.registerFactory(() => DemandeAffaireDetailsViewModel());
  locator.registerFactory(() => DemandeCompteDetailsViewModel());
  locator.registerFactory(() => DemandeListDetailsViewModel());
  locator.registerFactory(() => DemandeProductDetailsViewModel());
  locator.registerFactory(() => DemandeProspectDetailsViewModel());

  locator.registerFactory(() => DemandesCompteListViewModel());
  locator.registerFactory(() => DemandesProspectListViewModel());

  locator.registerFactory(() => DemandesActivityListViewModel());
  locator.registerFactory(() => DemandeActivityDetailsViewModel());
}
