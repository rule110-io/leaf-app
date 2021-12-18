import 'package:leaf_app/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaf_app/widgets/primary_button.dart';

class SetBeneficiaryWallet extends GetView<MainController> {
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
              child:
              Obx(() => c.loading() ? Column(
                  children:const [
                    CircularProgressIndicator()
                  ]
              ) : Column(
                children: [
                  Container(
                      child: const Text(
                          "Lastly your node needs a wallet it should send the "
                              "mined NKN to. This needs to be an NKN Mainnet "
                              "address. So make sure it starts with 'NKN'!",
                          style: TextStyle(
                              color: Colors.white, fontSize: 14, height: 1.5))),


                  const SizedBox(height: 25),
                  c.node.value.beneficiarySet ? Container(
                    child: Column(
                        children: [
                          const Text('Your node will mine to:', style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              height:1.2
                          )),
                          SizedBox(height: 25),
                          Text('Wallet address: ${c.node.value.beneficiaryAddr}'),
                        ]),
                  ) : Column(
                    children: [
                      TextFormField(
                        onChanged: (text) {c.updateBeneficiary(text);},
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
                            labelText: 'Your NKN mainnet wallet address'),
                      ),

                      const SizedBox(height: 50),
                      Container(
                        child: Column(
                          children: [
                            Obx(() =>
                                PrimaryButton(
                                    onPressed: !c.setBeneficiaryButtonEnabled.value ? null : () => c.setBeneficiaryAddr(),
                                    text: 'Set Beneficiary Address'
                                ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: Text('')),

                  const SizedBox(height: 50),
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
                                  !c.node.value.beneficiarySet ? Container() : DecoratedBox(
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
                                          Routes.INIT_FINISH),
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
