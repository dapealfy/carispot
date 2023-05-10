import 'package:carispot/app/modules/favorite/controllers/favorite_controller.dart';
import 'package:carispot/app/modules/main/controllers/main_controller.dart';
import 'package:carispot/app/utils/constants.dart';
import 'package:carispot/app/utils/location.dart';
import 'package:carispot/app/utils/maps.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                _appBar(),
                const SizedBox(height: 48),
                _upperText(),
                const SizedBox(height: 24),
                _tabbar(),
                const SizedBox(height: 48),
                _carousel(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _appBar() {
  HomeProvider homeProvider = HomeProvider();
  return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (c) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              c.placemarks == null
                  ? '...'
                  : c.placemarks![0].subAdministrativeArea!,
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
                children: [
                  Icon(Icons.sunny, color: Colors.black),
                  SizedBox(
                    width: 8,
                  ),
                  FutureBuilder<String>(
                    future: homeProvider.weatherApi(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Text(
                            snapshot.data! + '°',
                            style: TextStyle(color: Colors.black),
                          );
                        }
                      } else {
                        return Text(
                          '-°',
                          style: TextStyle(color: Colors.black),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      });
}

Widget _upperText() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const Text(
        'Cari Rumah Sakit dan Restoran.',
        style: TextStyle(
          color: Colors.white,
          fontSize: 34,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(
        height: 12,
      ),
      Text(
        DateFormat.MMMMEEEEd('id').format(DateTime.now()),
        style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 20),
      ),
    ],
  );
}

Widget _tabbar() {
  return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (homeController) {
        return Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => homeController.changeTab(0),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                      color: homeController.indexTab == 0
                          ? AppConstants.lime
                          : Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: Text(
                      'Populer',
                      style: TextStyle(
                          color: homeController.indexTab == 0
                              ? Colors.black
                              : Colors.white,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => homeController.changeTab(1),
                child: Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                      color: homeController.indexTab == 1
                          ? AppConstants.lime
                          : Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: Text(
                      'Terdekat',
                      style: TextStyle(
                          color: homeController.indexTab == 1
                              ? Colors.black
                              : Colors.white,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      });
}

Widget _carousel() {
  return GetBuilder<MainController>(
      init: MainController(),
      builder: (mainController) {
        return mainController.dataPlace == null
            ? SizedBox()
            : SizedBox(
                height: 320,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: mainController.allPlace.length <= 4
                      ? mainController.allPlace.length
                      : 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.bottomSheet(
                            _bottomSheet(mainController.allPlace[index]));
                      },
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            height: 330,
                            width: 330,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                "https://img.okezone.com/content/2022/05/09/301/2591143/inilah-13-restoran-keluarga-di-jakarta-selatan-paling-favorit-yIjGc0IrN0.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 12,
                            left: 12,
                            right: 12,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    mainController.allPlace[index]['lokasi'],
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: Color(0xff999999),
                                      ),
                                      Expanded(
                                        child: Text(
                                          mainController.allPlace[index]
                                              ['alamat'],
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Color(0xff999999)),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
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
