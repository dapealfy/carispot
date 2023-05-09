import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MapsController extends GetxController {
  Future<void> getData() async {
    final String response =
        await rootBundle.loadString('assets/database/database.json');
    final data = await json.decode(response);
  }
}
