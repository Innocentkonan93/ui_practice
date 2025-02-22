import 'package:get/get.dart';

import '../modules/code_scanner/bindings/code_scanner_binding.dart';
import '../modules/code_scanner/views/code_scanner_view.dart';
import '../modules/data_extractor/bindings/data_extractor_binding.dart';
import '../modules/data_extractor/views/data_extractor_view.dart';
import '../modules/dynamic_list/bindings/dynamic_list_binding.dart';
import '../modules/dynamic_list/views/dynamic_list_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/kki_list/bindings/kki_list_binding.dart';
import '../modules/kki_list/views/kki_list_view.dart';
import '../modules/lighter/bindings/lighter_binding.dart';
import '../modules/lighter/views/lighter_view.dart';
import '../modules/loading/bindings/loading_binding.dart';
import '../modules/loading/views/loading_view.dart';
import '../modules/price_card/bindings/price_card_binding.dart';
import '../modules/price_card/views/price_card_view.dart';
import '../modules/scratch_card/bindings/scratch_card_binding.dart';
import '../modules/scratch_card/views/scratch_card_view.dart';
import '../modules/tall_selection/bindings/tall_selection_binding.dart';
import '../modules/tall_selection/views/tall_selection_view.dart';
import '../modules/wallet/bindings/wallet_binding.dart';
import '../modules/wallet/views/wallet_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.DYNAMIC_LIST;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SCRATCH_CARD,
      page: () => const ScratchCardView(),
      binding: ScratchCardBinding(),
    ),
    GetPage(
      name: _Paths.LIGHTER,
      page: () => const LighterView(),
      binding: LighterBinding(),
    ),
    GetPage(
      name: _Paths.PRICE_CARD,
      page: () => const PriceCardView(),
      binding: PriceCardBinding(),
    ),
    GetPage(
      name: _Paths.WALLET,
      page: () => const WalletView(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: _Paths.LOADING,
      page: () => const LoadingView(),
      binding: LoadingBinding(),
    ),
    GetPage(
      name: _Paths.DATA_EXTRACTOR,
      page: () => const DataExtractorView(),
      binding: DataExtractorBinding(),
    ),
    GetPage(
      name: _Paths.CODE_SCANNER,
      page: () => const CodeScannerView(),
      binding: CodeScannerBinding(),
    ),
    GetPage(
      name: _Paths.KKI_LIST,
      page: () => const KkiListView(),
      binding: KkiListBinding(),
    ),
    GetPage(
      name: _Paths.TALL_SELECTION,
      page: () => TallSelectionView(),
      binding: TallSelectionBinding(),
    ),
    GetPage(
      name: _Paths.DYNAMIC_LIST,
      page: () => const DynamicListView(),
      binding: DynamicListBinding(),
    ),
  ];
}
