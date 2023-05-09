import 'package:carispot/app/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        'Jakarta',
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
        'Rabu, 10 Mei',
        style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 20),
      ),
    ],
  );
}

Widget _tabbar() {
  return Row(
    children: [
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30)),
          child: const Center(
            child: Text(
              'Populer',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(left: 8),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
              color: AppConstants.lime,
              borderRadius: BorderRadius.circular(30)),
          child: const Center(
            child: Text(
              'Terdekat',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _carousel() {
  return SizedBox(
    height: 320,
    child: ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: 4,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Stack(
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
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Restoran Enak',
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
                      children: const [
                        Icon(
                          Icons.location_on_outlined,
                          color: Color(0xff999999),
                        ),
                        Text(
                          'Cipete, Jakarta Selatan',
                          style: TextStyle(color: Color(0xff999999)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    ),
  );
}
