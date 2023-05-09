import 'dart:convert';

import 'package:carispot/app/modules/main/controllers/main_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class MapsController extends GetxController {
  addPlaceToFavorite(data) {
    MainController mainController = Get.find<MainController>();
    mainController.box.put(DateTime.now().toString(), data);
    update();
  }
}
