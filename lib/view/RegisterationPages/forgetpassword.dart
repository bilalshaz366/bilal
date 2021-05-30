import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:petmerchantapp/languages/global.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _emailController = TextEditingController(text: "");
  bool _onEditing = true;
  String _code;
  bool isLoading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xff293146),
      body: ModalProgressHUD(
          inAsyncCall: isLoading,
          // demo of some additional parameters
          opacity: 0.5,
          progressIndicator: CircularProgressIndicator(),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 88.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Text(
                        '$passwordrecovery',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0),
                      child: Text(
                        '$enteryouremailaddresstorecoverpassword',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Email',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                          SizedBox(
                            height: 10,
                          ),
                          fadeanimation(_emailController, 'example@gmail.com'),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // forgetpasswordapi();
                     //   resetPassword(_emailController.text);
                      },
                      child: Padding(
                          padding: EdgeInsets.only(top: 148.0),
                          child: Center(
                            child: Container(
                              height: 50,
                              width: 190,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[800]),
                              child: Center(
                                child: Text('$sendemail',
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.white)),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget fadeanimation(TextEditingController textcontroller, String hinttext) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(143, 148, 251, .2),
                blurRadius: 20.0,
                offset: Offset(0, 10))
          ]),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(1.0),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[100]))),
            child: TextFormField(
              controller: textcontroller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "$hinttext",
                  hintStyle: TextStyle(color: Colors.grey[400])),
            ),
          ),
        ],
      ),
    );
  }
}
