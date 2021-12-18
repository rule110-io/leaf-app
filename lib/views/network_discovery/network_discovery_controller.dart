import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:leaf_app/core.dart';
import 'package:leaf_app/providers/api_provider.dart';
import 'package:network_info_plus/network_info_plus.dart';

class NetworkDiscoveryController extends GetxController {
  ApiProvider _apiProvider = ApiProvider();

  final pageController = PageController();
  final animationDuration = const Duration(milliseconds: 350);

  final networkDevices = [].obs;
  final isButtonDisabled = true.obs;

  @override
  void onInit() {
    discoverDevices();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    pageController.dispose();
    Get.delete();
    print("[ NetworkDiscoveryController ] => onClose()");
    super.onClose();
  }

  void discoverDevicesStub() async {
    print("Discover start");
    isButtonDisabled(true);
    networkDevices.value = [];
    var timer = Timer(Duration(seconds: 2), () {
      networkDevices.add(NetworkDevice(
          name: "test",
          mac: "00:00:00:00",
          ip: "10.0.0.208",
          status: 'ONLINE'));
      isButtonDisabled(false);
      print("Discover end");
    });
  }

  void discoverDevices() async {
    NetworkInfo().getWifiIP().then((value) {
      isButtonDisabled(true);
      networkDevices.value = [];

      var ip = value!.replaceAll(RegExp(r'(?<=\.)\d+$'), '255');

      if (ip != "") {
        var DESTINATION_ADDRESS = InternetAddress(ip);

        RawDatagramSocket.bind(InternetAddress.anyIPv4, 9074)
            .then((RawDatagramSocket udpSocket) {
          print('Discovering started');
          udpSocket.broadcastEnabled = true;
          udpSocket.listen((e) {
            Datagram? dg = udpSocket.receive();
            if (dg != null) {
              String s = new String.fromCharCodes(dg.data);
              var data = jsonDecode(s);
              networkDevices.add(NetworkDevice(
                  name: "test",
                  mac: data['mac'],
                  ip: dg.address.address,
                  status: data['status']));
            }
          });
          List<int> data = utf8.encode('TEST');
          udpSocket.send(data, DESTINATION_ADDRESS, 5001);
          var timer = Timer(Duration(seconds: 2), () {
            udpSocket.close();
            print('Discovering ended');
            networkDevices.forEach((element) {
              inspect(element);
            });
            print("end");
            isButtonDisabled(false);
          });
        });
      }
    });
  }

  void setActiveNode(String ip) {
    _apiProvider.getStatus(ip).then((value) {

      GetStorage box = GetStorage();
      box.write('activeNode', {
        'ip' : value['ip']
      });
      Get.offAllNamed(Routes.HOME);
    }).onError((error, stackTrace) => Get.offAllNamed(Routes.WELCOME));
  }
}
