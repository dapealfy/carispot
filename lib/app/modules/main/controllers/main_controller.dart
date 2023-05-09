import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  RxInt currentPage = 0.obs;
  PageController pageController = PageController();
}
