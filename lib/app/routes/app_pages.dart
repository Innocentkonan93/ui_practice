import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/lighter/bindings/lighter_binding.dart';
import '../modules/lighter/views/lighter_view.dart';
import '../modules/price_card/bindings/price_card_binding.dart';
import '../modules/price_card/views/price_card_view.dart';
import '../modules/scratch_card/bindings/scratch_card_binding.dart';
import '../modules/scratch_card/views/scratch_card_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.PRICE_CARD;

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
  ];
}
