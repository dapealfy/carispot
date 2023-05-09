import 'dart:convert';

import 'package:carispot/app/modules/main/controllers/main_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class MapsController extends GetxController {
  addPlaceToFavorite(data) {
    MainController mainController = Get.find<MainController>();
    if (mainController.box!.get(data['lokasi']) == null) {
      mainController.box!.put(data['lokasi'], data);
    } else {
      mainController.box!.delete(data['lokasi']);
    }
    print(mainController.box!.values.length);
    update();
  }

  bool isFavorited(data) {
    MainController mainController = Get.find<MainController>();
    if (mainController.box!.get(data['lokasi']) != null) {
      return true;
    } else {
      return false;
    }
  }
}
