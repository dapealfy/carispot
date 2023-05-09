import 'package:carispot/app/modules/home/controllers/home_controller.dart';
import 'package:carispot/app/modules/main/controllers/main_controller.dart';
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
    MainController mainController = Get.put(MainController());
    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<MainController>(
              init: MainController(),
              initState: (state) {
                mainController.determinePosition();
              },
              builder: (c) {
                return c.userPosition == null && c.dataPlace == null
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
                          MarkerLayer(
                            markers:
                                (c.dataPlace!['place'] as List).map((data) {
                              return Marker(
                                point: LatLng(double.parse(data['latitude']),
                                    double.parse(data['longitude'])),
                                width: 74,
                                height: 74,
                                builder: (context) => Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.bottomSheet(Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(30),
                                            ),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 24),
                                            decoration: BoxDecoration(
                                                color: Color(0xff232323),
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                  top: Radius.circular(30),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    blurRadius: 15,
                                                    spreadRadius: 5,
                                                  )
                                                ]),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                SizedBox(
                                                  height: 24,
                                                ),
                                                Text(
                                                  data['lokasi']
                                                      .replaceAll(
                                                          RegExp(' +'), ' ')
                                                      .split(' ')
                                                      .map((str) => str.length >
                                                              0
                                                          ? '${str[0].toUpperCase()}${str.substring(1).toLowerCase()}'
                                                          : '')
                                                      .join(' '),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(height: 8),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      color: AppConstants.lime,
                                                    ),
                                                    SizedBox(width: 4),
                                                    Text(
                                                      '1 km',
                                                      style: TextStyle(
                                                          color: Colors.white
                                                              .withOpacity(
                                                                  0.7)),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  data['alamat'],
                                                  style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.7)),
                                                ),
                                                SizedBox(height: 24),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 12),
                                                        decoration: BoxDecoration(
                                                            color: AppConstants
                                                                .lime,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30)),
                                                        child: Center(
                                                          child: Text(
                                                            'Petunjuk Arah',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 12,
                                                              horizontal: 12),
                                                      decoration: BoxDecoration(
                                                          color: AppConstants
                                                              .black,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30)),
                                                      child: Center(
                                                          child: Icon(
                                                        Icons.favorite_border,
                                                        color: Colors.white,
                                                      )),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 24),
                                              ],
                                            ),
                                          ),
                                        ));
                                      },
                                      child: Icon(
                                        Icons.location_pin,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      );
              }),
          Positioned(
            top: 20,
            left: 24,
            right: 24,
            child: GetBuilder<MainController>(
                init: MainController(),
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
                              onPressed: () {},
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
