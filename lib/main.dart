import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'app/routes/app_pages.dart';

void main() async {
  Hive.init('./');
  runApp(
    GetMaterialApp(
      title: "CariSpot",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(fontFamily: 'Poppins'),
    ),
  );
}
