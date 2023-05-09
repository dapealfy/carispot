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
    return Scaffold(
      backgroundColor: AppConstants.black,
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            children: [HomeView(), MapsView(), MapsView()],
          ),
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Center(
              child: Container(
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        customBorder: CircleBorder(),
                        splashColor: AppConstants.black,
                        onTap: () {
                          controller.currentPage.value = 0;
                          controller.pageController.jumpTo(0);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.home_filled,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Container(
                                height: 5,
                                width: 5,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        customBorder: CircleBorder(),
                        splashColor: AppConstants.black,
                        onTap: () {
                          controller.currentPage.value = 1;
                          controller.pageController.jumpTo(1);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.map_rounded,
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        customBorder: CircleBorder(),
                        splashColor: AppConstants.black,
                        onTap: () {
                          controller.currentPage.value = 2;
                          controller.pageController.jumpTo(2);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.favorite_border_rounded,
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
