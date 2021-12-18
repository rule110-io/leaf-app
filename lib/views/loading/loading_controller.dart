import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import 'package:leaf_app/core.dart';

class LoadingController extends GetxController {

  final pageController = PageController();
  final animationDuration = const Duration(milliseconds: 350);
  var test = "hello";

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    GetStorage box = GetStorage();
    if (box.read('activeNode') == null){
      Get.toNamed(Routes.WELCOME);
    } else{
      Get.offAllNamed(Routes.HOME);
    }
    super.onReady();
  }

  @override
  void onClose() {
    pageController.dispose();
    Get.delete();
    print("[ LoadingController ] => onClose()");
    super.onClose();
  }



}
