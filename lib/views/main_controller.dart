import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:leaf_app/core.dart';
import 'package:leaf_app/providers/api_provider.dart';
import 'package:leaf_app/routes/app_views.dart';
import 'package:http/http.dart' as http;

class MainController extends GetxController {
  ApiProvider _apiProvider = ApiProvider();

  final pageController = PageController();
  final animationDuration = const Duration(milliseconds: 350);
  final status = "hallo".obs;
  final node = NodeStatus(
          ip: "",
          beneficiarySet: false,
          ports: {},
          serviceRunning: false,
          syncState: "OFFLINE",
          walletPresent: false)
      .obs;
  String password = '';
  String passwordRepeat = '';
  String beneficiaryAddr = '';
  final createWalletButtonEnabled = false.obs;
  final setBeneficiaryButtonEnabled = false.obs;
  final loading = false.obs;
  final selectedIndex = 0.obs;
  late Timer _timer;


  List<Widget> pageHeaders = <Widget>[
    Text('Overview'),
    Text('Performance'),
    Text('Wallet'),
    Text('Settings'),
  ];

  OverviewPage() {
    return Container(
      padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
      color: Color(0xff2a2a2a),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    child: Obx(() => Text(node().statusString()!,
                        style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)))),
                Container(
                  child: const SizedBox(width: 10),
                ),
                Container(
                  child: Icon(
                    Icons.circle_rounded,
                    color: node().statusColor(),
                    size: 16.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Container(
              padding: EdgeInsets.only(right: 10, left: 10),
              child: infoCard()),
        ],
      ),
    );
  }

  infoCard() {
    if (node().syncState == "NEEDS_INITIALIZATION") {
      return Card(
          color: Color(0xFFe6dcf5),
          elevation: 10,
          child: Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                    subtitle: const Text(
                        'You need to set up your node first to get it running.',
                        style: TextStyle(color: Color(0xff2a2a2a))),
                    trailing: TextButton(
                        child: const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Text("Set up",
                              style: TextStyle(color: Color(0xff2a2a2a))),
                        ),
                        onPressed: () => Get.toNamed(Routes.INIT_START),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: BorderSide(
                                        color: Color(0xff2a2a2a))))))),
              ],
            ),
          ));
    }
    else if (node().syncState == "NEEDS_GENERATE_ID") {
      return Card(
          color: Color(0xFFe6dcf5),
          elevation: 10,
          child: Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                    subtitle: Text(
                        'Please send 10 NKN to your nodes wallet: ${node.value.address}',
                        style: const TextStyle(color: Color(0xff2a2a2a))
                    )
                )
              ],
            ),
          ));
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();
    GetStorage box = GetStorage();
    if (box.read('activeNode') == null) {
      // Get.offAllNamed(Routes.WELCOME);
    }
    else{
      updateNodeStatus();
      _timer = new Timer.periodic(Duration(seconds: 5),
              (_) => updateNodeStatus());
    }

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _timer.cancel();
    pageController.dispose();
    Get.delete();
    print("[ MainController ] => onClose()");
    super.onClose();
  }


  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  updatePassword(text){
    password = text;
    if ((passwordRepeat == password) && passwordRepeat!=''){
      createWalletButtonEnabled.value = true;
    } else{
      createWalletButtonEnabled.value = false;
    }
  }
  updatePasswordRepeat(text){
    passwordRepeat = text;
    if ((passwordRepeat == password) && passwordRepeat!=''){
      createWalletButtonEnabled.value = true;
    } else{
      createWalletButtonEnabled.value = false;
    }
  }

  updateBeneficiary(text){
    beneficiaryAddr = text;
    if (beneficiaryAddr!=''){
      setBeneficiaryButtonEnabled.value = true;
    } else{
      setBeneficiaryButtonEnabled.value = false;
    }
  }





  void createWallet(){
    loading.value = true;
    _apiProvider.createWallet(node.value.ip, password).then((value) {
      updateNodeStatus();
      loading.value = false;
    }, onError: (err) {
      print(err);
      //Get.toNamed(Routes.WELCOME);
    });
  }

  void setBeneficiaryAddr(){
    loading.value = true;
    _apiProvider.setConfig(node.value.ip, 'BeneficiaryAddr', beneficiaryAddr).then((value) {
      updateNodeStatus();
      loading.value = false;
    }, onError: (err){
      print(err);
    });
  }

  void handleAction(String action) {
    if (action == "logout") {
      GetStorage box = GetStorage();
      box.write('activeNode', null);
      Get.offAllNamed(Routes.NETWORKDISCOVERY);
      Get.snackbar(
        "Success",
        "Logged out from Node",
        borderRadius: 50,
        padding: EdgeInsets.only(left: 30, top: 15, bottom: 15, right: 30),
        backgroundGradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color(0xffe5f1fd),
            Color(0xffdeccfe),
          ],
        ),
        colorText: Colors.white,
        icon: Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (action == "update") {
      updateNodeStatus().then((response) {
        Get.snackbar(
          "Success",
          "Node Data updated",
          borderRadius: 50,
          padding: EdgeInsets.only(left: 30, top: 15, bottom: 15, right: 30),
          backgroundGradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xffe5f1fd),
              Color(0xffdeccfe),
            ],
          ),
          colorText: Colors.white,
          icon: Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
        );
      }, onError: (err) {
        print("error");
      });
    }
  }

  Future<void> updateNodeStatus() async {
    GetStorage box = GetStorage();
    var ip = box.read('activeNode')["ip"];
    _apiProvider.getStatus(ip).then((response) {

      node.value.ip = response['ip'];
      node.value.beneficiarySet = response['beneficiarySet'];
      node.value.ports = response['ports'];
      node.value.serviceRunning = response['serviceRunning'];
      node.value.syncState = response['syncState'];
      node.value.walletPresent = response['walletPresent'];

      _apiProvider.getWallet(ip).then((response){

        node.value.address = response['address'];
        node.value.publicKey = response['publicKey'];

        _apiProvider.getConfig(ip).then((response){
          node.value.beneficiaryAddr = response['BeneficiaryAddr'];
          GetStorage box = GetStorage();
          box.write('activeNode', node.value.toMap());
          node.refresh();
        });
      });


    }, onError: (err) {
      print(err);
      //Get.toNamed(Routes.WELCOME);
    });
  }
}
