import 'package:leaf_app/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaf_app/widgets/primary_button.dart';
import 'package:leaf_app/widgets/secondary_button.dart';

class CreateWalletView extends GetView<MainController> {
  @override
  Widget build(BuildContext context) {
    final MainController c = Get.put(MainController());

    return Scaffold(
        appBar: AppBar(
          title: const Text('Create local wallet'),
          backgroundColor: const Color(0xff2a2a2a),
          bottomOpacity: 0.0,
          elevation: 0.0,
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
              child:
              Obx(() => c.loading() ? Column(
                  children:const [
                    CircularProgressIndicator()
                  ]
              ) : Column(
                    children: [
                      Container(
                          child: const Text(
                              "A local wallet is needed for a node to operate. It "
                                  "normally doesn't hold any NKN Tokens and is just "
                                  "needed for identifying and paying the initial "
                                  "mining fee.\n\nLet's chose a password for your "
                                  "node's wallet:",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14, height: 1.5))),


                      const SizedBox(height: 25),
                      c.node.value.walletPresent ? Container(
                        child: Column(
                            children: [
                              const Text('Your wallet data:', style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  height:1.2
                              )),
                              SizedBox(height: 25),
                              Text('Wallet address: ${c.node.value.address}'),
                              SizedBox(height: 15),
                              Text('Wallet private Key: ${c.node.value.publicKey}'),
                            ]),
                      ) : Column(
                        children: [
                          TextFormField(
                            onChanged: (text) {c.updatePassword(text);},
                            obscureText: true,
                            cursorColor: Colors.white,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                labelStyle: TextStyle(color: Colors.white),
                                floatingLabelStyle: TextStyle(color: Color(0xffdeccfe)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xffdeccfe))),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)),
                                labelText: 'Chose your wallet password'),
                          ),
                          TextFormField(
                            onChanged: (text) {c.updatePasswordRepeat(text);},
                            obscureText: true,
                            cursorColor: Colors.white,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                labelStyle: TextStyle(color: Colors.white),
                                floatingLabelStyle: TextStyle(color: Color(0xffdeccfe)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xffdeccfe))),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)),
                                labelText: 'Repeat wallet password'),
                          ),

                          const SizedBox(height: 50),
                          Container(
                            child: Column(
                              children: [
                                Obx(() =>
                                    PrimaryButton(
                                        onPressed: !c.createWalletButtonEnabled.value ? null : () => c.createWallet(),
                                        text: 'Create Wallet'
                                    ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),


                      const SizedBox(height: 50),
                      const Expanded(
                          child: Text('Note: You will be able to download your'
                              ' local wallet file from the settings page later.')),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                TextButton(
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          left: 25, top: 5, bottom: 5, right: 25),
                                      child: Text("Back",
                                          style: TextStyle(color: Colors.white)),
                                    ),
                                    onPressed: () => Get.back(),
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(50.0),
                                                side: const BorderSide(
                                                    color: Colors.white
                                                )
                                            )
                                        )
                                    )
                                )
                              ],
                            ),
                          ),
                          const Expanded(
                            child: Text(''),
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Obx( () =>
                                  Column(
                                    children: [
                                      !c.node.value.walletPresent ? Container() : DecoratedBox(
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
                                              padding:
                                              EdgeInsets.only(left: 25, right: 25),
                                              child: Text("Next",
                                                  style: TextStyle(
                                                      color: Color(0xff2a2a2a)))),
                                          onPressed: () => Get.toNamed(
                                              Routes.INIT_SET_BENEFICIARY_WALLET),
                                        ),
                                      ),
                                    ],
                                  ),
                              )
                          ),
                        ],
                      )
                    ],
                  )),
            )
        ));
  }
}
