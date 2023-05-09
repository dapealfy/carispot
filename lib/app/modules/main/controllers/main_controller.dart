import 'dart:convert';

import 'package:carispot/app/modules/home/controllers/home_controller.dart';
import 'package:carispot/app/utils/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class MainController extends GetxController {
  int currentPage = 0;
  PageController pageController = PageController();

  Position? userPosition;
  Map<String, dynamic>? dataPlace;
  List allPlace = [];

  Box? box;

  void openBoxFavorite() async {
    box = await Hive.openBox('favoritePlace');
    update();
  }

  void changePage(int index) {
    currentPage = index;
    pageController.jumpToPage(index);
    update();
  }

  void determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Lokasi tidak dapat digunakan.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Lokasi tidak diizinkan');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Izin lokasi tidak dapat kami akses');
    }

    userPosition = await Geolocator.getCurrentPosition();
    HomeController homeController = Get.put(HomeController());
    homeController.getUserAddress(userPosition);
    allPlace =
        sortLocationsByDistance(userPosition!, dataPlace!['place']) as List;
    update();
  }

  Future<void> getData() async {
    final String response =
        await rootBundle.loadString('assets/database/database.json');
    dataPlace = await json.decode(response);

    update();
  }

  updateBox() {
    box = box;
    update();
  }
}
