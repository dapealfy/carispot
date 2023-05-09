import 'package:carispot/app/modules/main/controllers/main_controller.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  addPlaceToFavorite(data) {
    MainController mainController = Get.find<MainController>();
    if (mainController.box!.get(data['lokasi']) == null) {
      mainController.box!.put(data['lokasi'], data);
    } else {
      mainController.box!.delete(data['lokasi']);
    }
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
