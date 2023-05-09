import 'package:carispot/app/modules/home/controllers/home_controller.dart';
import 'package:carispot/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../controllers/maps_controller.dart';

class MapsView extends GetView<MapsController> {
  const MapsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<HomeController>(
              init: HomeController(),
              initState: (state) {
                homeController.determinePosition();
              },
              builder: (c) {
                return c.userPosition == null
                    ? const SizedBox()
                    : FlutterMap(
                        options: MapOptions(
                          center: LatLng(c.userPosition!.latitude,
                              c.userPosition!.longitude),
                          zoom: 15,
                          interactiveFlags:
                              InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                "https://api.mapbox.com/styles/v1/davearr/clcrnx2li000214r0quwyn5jt/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
                            additionalOptions: {
                              'accessToken': AppConstants.mapBoxAccessToken,
                            },
                          ),
                        ],
                      );
              }),
          Positioned(
            top: 20,
            left: 24,
            right: 24,
            child: GetBuilder<MapsController>(
                init: MapsController(),
                builder: (c) {
                  return SafeArea(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 24, top: 4, bottom: 4, right: 12),
                      decoration: BoxDecoration(
                          color: Color(0xff222222),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 15,
                              spreadRadius: 2,
                            )
                          ],
                          borderRadius: BorderRadius.circular(30)),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Cari lokasi..',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                c.getData();
                              },
                              color: Colors.white,
                            ),
                            hintStyle: TextStyle(color: Colors.white)),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
