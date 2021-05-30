import 'dart:async';

import 'package:flutter/material.dart';
import 'package:petmerchantapp/view/welcomeScreen.dart';

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';

//final _prefManager = PrefManager();

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var userDatas;

  dynamic valuename;

  getuserlogin() async {
    SharedPreferences getlogin = await SharedPreferences.getInstance();
    valuename = await getlogin.getString('userdata');
    print(valuename);
  }
  // getuserData() async {
  //   userDatas = json.decode(await _prefManager.get("user.datas", "{}"));

  //   print("im in profile $userDatas");
  // }

  @override
  void initState() {
    getuserlogin();
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => valuename == null
            ? Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => WelcomePage()))
            : Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(color: Colors.white),
      Center(
          child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/petcare.png')),
                SizedBox(
                  height: 30,
                ),
                CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 32),
                  child: Text(
                    'Welcome to Petaffix Merchant App',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ))
    ]));
  }
}
