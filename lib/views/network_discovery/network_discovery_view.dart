import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:leaf_app/core.dart';
import 'package:leaf_app/views/network_discovery/network_discovery_controller.dart';

class NetworkDiscoveryView extends GetView<NetworkDiscoveryController> {
  @override
  final NetworkDiscoveryController c = Get.put(NetworkDiscoveryController());

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Discover Network'),
          backgroundColor: Color(0xff2a2a2a),
          bottomOpacity: 0.0,
          elevation: 0.0,
        ),
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Column(
                    children: [
                      Obx(() => Column(
                          children: c
                              .networkDevices()
                              .map((networkDevice) => Row(
                                    children: [
                                      Expanded(child: Text(networkDevice.ip)),
                                      Expanded(
                                        child: Text(networkDevice.status),
                                      ),
                                      Expanded(
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            gradient: const LinearGradient(
                                              begin: Alignment.bottomLeft,
                                              end: Alignment.topRight,
                                              colors: [
                                                Color(0xffe5f1fd),
                                                Color(0xffdeccfe),
                                              ],
                                            ),
                                          ),
                                          child: TextButton(
                                            child: const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Text("Connect",
                                                    style: TextStyle(
                                                        color: Color(
                                                            0xff2a2a2a)))),
                                            onPressed: () => c.setActiveNode(
                                                networkDevice.ip),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                              .toList())),
                      const SizedBox(
                        height: 30,
                      ),
                      _buildScanButton(),
                    ],
                  )),
            )
          ],
        ));
  }

  Widget _buildScanButton() {
    return Obx(() => TextButton(
        child: Padding(
          padding: EdgeInsets.only(left: 25, top: 10, bottom: 10, right: 25),
          child: Text(c.isButtonDisabled() ? "Hold on..." : "Re-Scan network",
              style: const TextStyle(color: Colors.white)),
        ),
        onPressed: c.isButtonDisabled() ? null : () => c.discoverDevices(),
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(color: Colors.white))))));
  }
}
