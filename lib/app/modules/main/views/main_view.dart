import 'package:carispot/app/modules/favorite/views/favorite_view.dart';
import 'package:carispot/app/modules/home/controllers/home_controller.dart';
import 'package:carispot/app/modules/home/views/home_view.dart';
import 'package:carispot/app/modules/maps/views/maps_view.dart';
import 'package:carispot/app/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.put(MainController());

    return Scaffold(
      backgroundColor: AppConstants.black,
      body: GetBuilder<MainController>(
          init: MainController(),
          initState: (state) {
            mainController.getData();
            mainController.determinePosition();
            mainController.openBoxFavorite();
          },
          builder: (c) {
            return Stack(
              children: [
                IndexedStack(
                  index: c.currentPage,
                  children: const [HomeView(), MapsView(), FavoriteView()],
                ),
                Positioned(
                  bottom: 24,
                  left: 24,
                  right: 24,
                  child: Center(
                    child: Container(
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
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            width: 8,
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              splashColor: AppConstants.black,
                              onTap: () {
                                c.changePage(0);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.home_filled,
                                      color: c.currentPage == 0
                                          ? Colors.white
                                          : Colors.white.withOpacity(0.5),
                                    ),
                                    c.currentPage == 0
                                        ? Container(
                                            height: 5,
                                            width: 5,
                                            padding:
                                                const EdgeInsets.only(top: 4),
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              splashColor: AppConstants.black,
                              onTap: () {
                                c.changePage(1);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.map_rounded,
                                      color: c.currentPage == 1
                                          ? Colors.white
                                          : Colors.white.withOpacity(0.5),
                                    ),
                                    c.currentPage == 1
                                        ? Container(
                                            height: 5,
                                            width: 5,
                                            padding:
                                                const EdgeInsets.only(top: 4),
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              splashColor: AppConstants.black,
                              onTap: () {
                                c.changePage(2);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.favorite_border_rounded,
                                      color: c.currentPage == 2
                                          ? Colors.white
                                          : Colors.white.withOpacity(0.5),
                                    ),
                                    c.currentPage == 2
                                        ? Container(
                                            height: 5,
                                            width: 5,
                                            padding:
                                                const EdgeInsets.only(top: 4),
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
