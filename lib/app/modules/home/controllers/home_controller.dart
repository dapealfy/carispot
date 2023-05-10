import 'dart:convert';

import 'package:carispot/app/modules/main/controllers/main_controller.dart';
import 'package:carispot/app/utils/location.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  int indexTab = 1;
  List<Placemark>? placemarks;

  void changeTab(int index) {
    indexTab = index;
    update();
  }

  void getUserAddress(Position userPosition) async {
    MainController mainController = Get.find<MainController>();
    placemarks = await placemarkFromCoordinates(
        userPosition.latitude, userPosition.longitude);
    update();
  }
}

class HomeProvider extends GetConnect {
  Future<String> weatherApi() async {
    MainController mainController = Get.find<MainController>();
    final response = await get(
        'https://api.open-meteo.com/v1/forecast?latitude=' +
            mainController.userPosition!.latitude.toString() +
            '&longitude=' +
            mainController.userPosition!.longitude.toString() +
            '&current_weather=true');
    var data = json.decode(response.bodyString.toString());
    if (data != null) {
      return data['current_weather']['temperature'].toString().substring(0, 2);
    } else {
      return '-';
    }
  }
}
