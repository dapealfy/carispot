import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Position? userPosition;

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
    update();
  }
}
