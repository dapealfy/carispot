import 'dart:convert';

import 'package:carispot/app/modules/main/controllers/main_controller.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';

class MapsController extends GetxController {
  MapController mapController = MapController();
  List searchResult = [];

  void onSearch(String value) {
    searchResult.clear();
    MainController mainController = Get.find<MainController>();
    if (value != '') {
      for (var data in mainController.dataPlace!['place']) {
        if (data['lokasi'].toLowerCase().contains(value.toLowerCase())) {
          if (!searchResult.contains(data)) {
            searchResult.add(data);
          }
        }
      }
    }
    update();
  }

  void resetSearch() {
    searchResult.clear();
    update();
  }
}
