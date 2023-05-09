import 'package:carispot/app/modules/main/controllers/main_controller.dart';
import 'package:get/get.dart';

class MapsController extends GetxController {
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
}
