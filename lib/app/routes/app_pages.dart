import 'package:get/get.dart';

import '../modules/favorite/bindings/favorite_binding.dart';
import '../modules/favorite/views/favorite_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/maps/bindings/maps_binding.dart';
import '../modules/maps/views/maps_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAPS,
      page: () => const MapsView(),
      binding: MapsBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITE,
      page: () => const FavoriteView(),
      binding: FavoriteBinding(),
    ),
  ];
}
