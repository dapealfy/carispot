import 'package:carispot/app/modules/main/controllers/main_controller.dart';
import 'package:carispot/app/utils/constants.dart';
import 'package:carispot/app/utils/location.dart';
import 'package:carispot/app/utils/maps.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/favorite_controller.dart';

class FavoriteView extends GetView<FavoriteController> {
  const FavoriteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.put(MainController());
    return Scaffold(
      backgroundColor: AppConstants.black,
      body: GetBuilder<FavoriteController>(
          init: FavoriteController(),
          builder: (favoriteController) {
            return SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _appBar(),
                    const SizedBox(
                      height: 24,
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: mainController.box == null
                            ? 0
                            : mainController.box!.values.length,
                        itemBuilder: (context, index) {
                          var data = mainController.box!.getAt(index);
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            margin: const EdgeInsets.only(bottom: 36),
                            decoration: BoxDecoration(
                                color: const Color(0xff232323),
                                borderRadius: BorderRadius.circular(
                                  30,
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
                                                  mainController
                                                      .userPosition!.latitude,
                                                  mainController
                                                      .userPosition!.longitude,
                                                  double.parse(
                                                      data['latitude']),
                                                  double.parse(
                                                      data['longitude']))
                                              .toString()
                                              .substring(0, 3) +
                                          ' km',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.7)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  data['alamat'],
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.7)),
                                ),
                                const SizedBox(height: 24),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          MapUtils.openMap(data['latitude'],
                                              data['longitude']);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12),
                                          decoration: BoxDecoration(
                                              color: AppConstants.lime,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: const Center(
                                            child: Text(
                                              'Petunjuk Arah',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
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
                                              favoriteController
                                                  .addPlaceToFavorite(data);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 12),
                                              decoration: BoxDecoration(
                                                  color: AppConstants.black,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Center(
                                                  child: Icon(
                                                favoriteController
                                                        .isFavorited(data)
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
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

Widget _appBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        'Tempat Favoritmu',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppConstants.lime,
        ),
        child: Row(
          children: const [
            Icon(Icons.sunny, color: Colors.black),
            SizedBox(
              width: 8,
            ),
            Text(
              '29°',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    ],
  );
}
