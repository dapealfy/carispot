import 'package:carispot/app/modules/favorite/controllers/favorite_controller.dart';
import 'package:carispot/app/modules/main/controllers/main_controller.dart';
import 'package:carispot/app/utils/constants.dart';
import 'package:carispot/app/utils/location.dart';
import 'package:carispot/app/utils/maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../controllers/maps_controller.dart';

class MapsView extends GetView<MapsController> {
  const MapsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _maps(),
          Positioned(top: 20, left: 24, right: 24, child: _searchBar()),
        ],
      ),
    );
  }
}

Widget _maps() {
  MainController mainController = Get.put(MainController());
  return GetBuilder<MainController>(
      init: MainController(),
      initState: (state) {
        mainController.determinePosition();
      },
      builder: (c) {
        return c.userPosition == null
            ? const SizedBox()
            : c.dataPlace == null
                ? const SizedBox()
                : FlutterMap(
                    options: MapOptions(
                      center: LatLng(
                          c.userPosition!.latitude, c.userPosition!.longitude),
                      zoom: 15,
                      interactiveFlags:
                          InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://api.mapbox.com/styles/v1/davearr/clcrnx2li000214r0quwyn5jt/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
                        additionalOptions: const {
                          'accessToken': AppConstants.mapBoxAccessToken,
                        },
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                              point: LatLng(c.userPosition!.latitude,
                                  c.userPosition!.longitude),
                              builder: (context) {
                                return Container(
                                  height: 17,
                                  width: 17,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: Center(
                                    child: Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue),
                                    ),
                                  ),
                                );
                              })
                        ],
                      ),
                      MarkerLayer(
                        markers: (c.dataPlace!['place'] as List).map((data) {
                          return Marker(
                            point: LatLng(double.parse(data['latitude']),
                                double.parse(data['longitude'])),
                            width: 74,
                            height: 74,
                            builder: (context) => Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.bottomSheet(_bottomSheet(data));
                                  },
                                  child: const Icon(
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
      });
}

Widget _searchBar() {
  return GetBuilder<MapsController>(
      init: MapsController(),
      builder: (c) {
        return SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    left: 24, top: 4, bottom: 4, right: 12),
                decoration: BoxDecoration(
                    color: const Color(0xff222222),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 15,
                        spreadRadius: 2,
                      )
                    ],
                    borderRadius: BorderRadius.circular(30)),
                child: TextField(
                  onChanged: c.onSearch,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Cari lokasi..',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                      color: Colors.white,
                    ),
                    hintStyle: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              c.searchResult.length == 0
                  ? SizedBox()
                  : Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      constraints: BoxConstraints(
                        maxHeight: 250.0,
                        minHeight: 0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xff222222),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: c.searchResult.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              Get.bottomSheet(
                                  _bottomSheet(c.searchResult[index]));
                            },
                            leading: Icon(
                              Icons.location_on_outlined,
                              color: AppConstants.lime,
                            ),
                            title: Text(
                              c.searchResult[index]['lokasi'],
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              c.searchResult[index]['alamat'],
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        );
      });
}

Widget _bottomSheet(data) {
  return GetBuilder<MainController>(
      init: MainController(),
      builder: (mainController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
                color: const Color(0xff232323),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    spreadRadius: 5,
                  )
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Text(
                  data['lokasi']
                      .replaceAll(RegExp(' +'), ' ')
                      .split(' ')
                      .map((str) => str.length > 0
                          ? '${str[0].toUpperCase()}${str.substring(1).toLowerCase()}'
                          : '')
                      .join(' '),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: AppConstants.lime,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      distanceBetweenLatLng(
                                  mainController.userPosition!.latitude,
                                  mainController.userPosition!.longitude,
                                  double.parse(data['latitude']),
                                  double.parse(data['longitude']))
                              .toString()
                              .substring(0, 3) +
                          ' km',
                      style: TextStyle(color: Colors.white.withOpacity(0.7)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  data['alamat'],
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          MapUtils.openMap(data['latitude'], data['longitude']);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                              color: AppConstants.lime,
                              borderRadius: BorderRadius.circular(30)),
                          child: const Center(
                            child: Text(
                              'Petunjuk Arah',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    GetBuilder<FavoriteController>(
                        init: FavoriteController(),
                        builder: (favoriteController) {
                          return InkWell(
                            onTap: () {
                              favoriteController.addPlaceToFavorite(data);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: AppConstants.black,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                  child: Icon(
                                favoriteController.isFavorited(data)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.white,
                              )),
                            ),
                          );
                        }),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      });
}
