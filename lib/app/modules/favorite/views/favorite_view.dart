import 'package:carispot/app/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/favorite_controller.dart';

class FavoriteView extends GetView<FavoriteController> {
  const FavoriteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      body: SafeArea(
        child: Column(
          children: [
            _appBar(),
            Container(
              child: Text('oke'),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _appBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'Jakarta',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
