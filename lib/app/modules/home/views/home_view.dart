import 'package:carispot/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
          init: HomeController(),
          initState: (state) {
            controller.determinePosition();
          },
          builder: (c) {
            return c.userPosition == null
                ? const SizedBox()
                : FlutterMap(
                    options: MapOptions(
                      center: LatLng(
                          c.userPosition!.latitude, c.userPosition!.longitude),
                      zoom: 13,
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
    );
  }
}
