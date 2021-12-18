import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:leaf_app/routes/app_views.dart';
import 'main_controller.dart';
import 'package:get/get.dart';

class MainView extends GetView<MainController> {
  buildBottomNavigationMenu(context, mainPageController) {
    return Obx(() => BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                    gradient: mainPageController.selectedIndex() == 0
                        ? const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Color(0xffe5f1fd),
                              Color(0xffdeccfe),
                            ],
                          )
                        : const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                            ],
                          ),
                    shape: BoxShape.circle),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.home),
                ),
              ),
              label: 'Overview',
            ),
            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                    gradient: mainPageController.selectedIndex() == 1
                        ? const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Color(0xffe5f1fd),
                              Color(0xffdeccfe),
                            ],
                          )
                        : const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                            ],
                          ),
                    shape: BoxShape.circle),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.speed),
                ),
              ),
              label: 'Performance',
            ),
            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                    gradient: mainPageController.selectedIndex() == 2
                        ? const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Color(0xffe5f1fd),
                              Color(0xffdeccfe),
                            ],
                          )
                        : const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                            ],
                          ),
                    shape: BoxShape.circle),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.account_balance_wallet),
                ),
              ),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                    gradient: mainPageController.selectedIndex() == 3
                        ? const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Color(0xffe5f1fd),
                              Color(0xffdeccfe),
                            ],
                          )
                        : const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                            ],
                          ),
                    shape: BoxShape.circle),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.settings),
                ),
              ),
              label: 'Settings',
            ),
          ],
          backgroundColor: Color(0xff2a2a2a),
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: mainPageController.selectedIndex(),
          onTap: mainPageController.onItemTapped,
          unselectedItemColor: Color(0xfffefefe),
          selectedItemColor: Color(0xff2a2a2a),
        ));
  }

  @override
  Widget build(BuildContext context) {

    final MainController c = Get.put(MainController(), permanent: false);

    GetStorage box = GetStorage();
    if (box.read('activeNode') == null) {
      Get.offAllNamed(Routes.WELCOME);
    }
    else{
      c.updateNodeStatus();

    }



    return Scaffold(
        appBar: AppBar(
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: Color(0xff2a2a2a)),
            bottomOpacity: 0.0,
            elevation: 0.0,
            backgroundColor: const Color(0xff2a2a2a),
            title: Obx(() => c.pageHeaders.elementAt(c.selectedIndex.value)),
            actions: <Widget>[
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (result) => c.handleAction(result),
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem(
                    child: Text('Disconnect'),
                    value: 'logout',
                  ),
                  const PopupMenuItem(
                    child: Text('Update Data'),
                    value: 'update',
                  ),
                ],
              )
            ]),
        body: Center(
          child: Obx(() => IndexedStack(
                index: c.selectedIndex.value,
                children: [c.OverviewPage()],
              )),
        ),
        bottomNavigationBar: buildBottomNavigationMenu(context, c));
  }
}
