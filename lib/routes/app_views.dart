import 'package:get/get.dart';
import '../core.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOADING;

  static final routes = [
    GetPage(
      name: Routes.LOADING,
      page: () => LoadingView(),
    ),
    GetPage(
      name: Routes.WELCOME,
      page: () => WelcomeView(),
    ),
    GetPage(
      name: Routes.NETWORKDISCOVERY,
      page: () => NetworkDiscoveryView(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => MainView(),
    ),
    GetPage(
      name: Routes.INIT_CREATE_WALLET,
      page: () => CreateWalletView(),
    ),
    GetPage(
      name: Routes.INIT_FINISH,
      page: () => FinishView(),
    ),
    GetPage(
      name: Routes.INIT_START,
      page: () => StartView(),
    ),
    GetPage(
      name: Routes.INIT_SET_BENEFICIARY_WALLET,
      page: () => SetBeneficiaryWallet(),
    ),
  ];
}