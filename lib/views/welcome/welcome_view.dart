import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaf_app/core.dart';

class WelcomeView extends StatelessWidget{
  @override

  Widget build(BuildContext context){
    return Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg.png"),
                  alignment: Alignment.bottomRight,
                  scale: 1.2

                ),
              ),
            ),
            Container(
            padding: const EdgeInsets.only(top: 125.0, left:50.0, right:75.0, bottom: 25.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Flexible(
                          child: Text(
                              "Welcome to our Leaf App",
                              style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              height:1.2
                              )),
                      )

                    ),
                  ],
                ),
                const SizedBox(
                  height:30
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: const Flexible(
                          child: Text(
                              "With our app you can manage your home Leaf "
                                  "device, check its status and get notified "
                                  "about mining rewards.",
                              style: TextStyle(
                                color: Colors.white,
                                  fontSize: 14,
                                height:1.5
                              )),
                        )
                    ),
                  ],
                ),
                const SizedBox(
                    height:50
                ),
                Row(
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
                              padding: EdgeInsets.only(left: 25, top:5, bottom: 5, right: 25),
                              child: Text("Find My Device",
                                  style: TextStyle(
                                    color: Color(0xff2a2a2a)
                                  )
                              )
                          ),
                          onPressed: () => Get.toNamed(Routes.NETWORKDISCOVERY),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

        ])
    );
  }
}