import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'Dashboard.dart';
import 'addservices.dart';
import 'package:petmerchantapp/view/Services.dart';
import 'package:petmerchantapp/view/Editownerinfo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    // Dashboard(),
    // DayCare(),
    // Profile(),
    // Settings(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return returnhome();
  }

  Widget returnhome() {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            extendBody: true,
            body: ModalProgressHUD(
              inAsyncCall: isLoading,
              // demo of some additional parameters
              opacity: 0.5,
              progressIndicator: CircularProgressIndicator(),
              child: PageStorage(
                child: currentScreen,
                bucket: bucket,
              ),
            ),
            // floatingActionButton: FloatingActionButton(
            //   child: Icon(Icons.add),
            //   onPressed: () {},
            // ),
            //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Color(0x00ffffff),
                  ),
                  child: BottomAppBar(
                    color: Color(0x00ffffff),
                    shape: CircularNotchedRectangle(),
                    notchMargin: 10,
                    child: Container(
                      color: Colors.grey[200],
                      height: 60,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              MaterialButton(
                                minWidth: 10,
                                onPressed: () {
                                  setState(() {
                                    currentScreen =
                                        Dashboard(); // if user taps on this dashboard tab will be active
                                    currentTab = 0;
                                  });
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.person,
                                      color: currentTab == 0
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                    Text(
                                      'Dashboard',
                                      style: TextStyle(
                                        color: currentTab == 0
                                            ? Colors.blue
                                            : Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              MaterialButton(
                                minWidth: 5,
                                onPressed: () {
                                  setState(() {
                                    currentScreen =
                                        AddServices(); // if user taps on this dashboard tab will be active
                                    currentTab = 1;
                                  });
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.room_service_sharp,
                                      color: currentTab == 1
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                    Text(
                                      'Add Services',
                                      style: TextStyle(
                                        color: currentTab == 1
                                            ? Colors.blue
                                            : Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          // Right Tab bar icons

                          Row(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              MaterialButton(
                                minWidth: 10,
                                onPressed: () {
                                  setState(() {
                                    currentScreen =
                                        MyServices(); // if user taps on this dashboard tab will be active
                                    currentTab = 2;
                                  });
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.person,
                                      color: currentTab == 2
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                    Text(
                                      'My Services',
                                      style: TextStyle(
                                        color: currentTab == 2
                                            ? Colors.blue
                                            : Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              MaterialButton(
                                minWidth: 10,
                                onPressed: () {
                                  setState(() {
                                    currentScreen =
                                        EditOwnerPage(); // if user taps on this dashboard tab will be active
                                    currentTab = 3;
                                  });
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.settings,
                                      color: currentTab == 3
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                    Text(
                                      'Settings',
                                      style: TextStyle(
                                        color: currentTab == 3
                                            ? Colors.blue
                                            : Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )));
  }

  Future<bool> _onWillPop() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.QUESTION,
      animType: AnimType.RIGHSLIDE,
      headerAnimationLoop: false,
      title: 'Are You Sure',
      desc: 'Do you want to exit an App!',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        exit(0);
      },
    )..show();
  }
}
