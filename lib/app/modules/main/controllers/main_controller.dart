import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  int currentPage = 0;
  PageController pageController = PageController();

  void changePage(int index) {
    currentPage = index;
    update();
  }
}
