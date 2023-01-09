import 'package:cbq/data/local/pref/app_pref.dart';
import 'package:cbq/data/remote/network/network_api_serivce.dart';
import 'package:cbq/providers/country_provider.dart';
import 'package:cbq/providers/dashboard_provider.dart';
import 'package:cbq/providers/post_details_provider.dart';
import 'package:cbq/providers/register_provider.dart';
import 'package:cbq/repository/dashboard/dashboard_repo_imp.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => NetworkApiService());
  getIt.registerLazySingleton(
      () => DashboardRepoImp(getIt<NetworkApiService>()));
  getIt.registerLazySingleton(() => AppPref());
  getIt.registerFactory(() => CountryProvider());
  getIt.registerFactory(() => DashboardProvider(getIt<DashboardRepoImp>()));
  getIt.registerFactory(() => RegisterProvider(getIt<AppPref>()));
  getIt.registerFactory(() => PostDetailsProvider(getIt<DashboardRepoImp>()));
}
