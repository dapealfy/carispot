import 'package:carispot/app/modules/main/controllers/main_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List<Placemark>? placemarks;

  void getUserAddress(userPosition) async {
    MainController mainController = Get.find<MainController>();
    placemarks = await placemarkFromCoordinates(
        userPosition.latitude, userPosition.longitude);
    update();
  }
}
