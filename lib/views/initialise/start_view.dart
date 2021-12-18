import 'package:leaf_app/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartView extends GetView<MainController> {
  @override
  Widget build(BuildContext context) {
    final MainController c = Get.put(MainController());

    return Scaffold(
        appBar: AppBar(
          title: const Text('Initialise your Node'),
          backgroundColor: Color(0xff2a2a2a),
          bottomOpacity: 0.0,
          elevation: 0.0,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                child: const Flexible(
                              child: Text("Let's get started!",
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      height: 1.2)),
                            )),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                child: const Flexible(
                              child: Text(
                                  "For a node to operate properly you need to"
                                  " have at least 2 things: A local wallet"
                                  " the node needs to operate and a wallet"
                                  " address where the node should mine to."
                                  "\n\nLet's create and add them!",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      height: 1.5)),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
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
                                    left: 25, top: 5, bottom: 5, right: 25),
                                child: Text("Start Initialising Node",
                                    style:
                                        TextStyle(color: Color(0xff2a2a2a)))),
                            onPressed: () =>
                                Get.toNamed(Routes.INIT_CREATE_WALLET),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
}
