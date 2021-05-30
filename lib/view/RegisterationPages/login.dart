import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:petmerchantapp/controllers/controller.dart';

import 'package:petmerchantapp/languages/global.dart';
import 'package:petmerchantapp/utils/customcontainers.dart';
import 'package:petmerchantapp/utils/errorutils.dart';
import 'package:petmerchantapp/utils/prefmanager.dart';
import 'package:petmerchantapp/view/RegisterationPages/registerpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Home.dart';
import 'forgetpassword.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _validateemail = false;

  bool _validatepass = false;

  bool _validateconfpass = false;

  final _emailController = TextEditingController(text: "");

  final _passwordController = TextEditingController(text: "");

  final _password2Controller = TextEditingController();

  final _phoneController = TextEditingController(text: countrycode);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map userDatas;

  getuserData() async {
    userDatas = json.decode(await _prefManager.get("user.data", "{}"));

    print(userDatas);
  }

  @override
  Widget build(BuildContext context) {
    getuserData();

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xff293146),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xff293146),
          actions: [
            Text(
              'English',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 30,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Text(
                    'Login Page',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Email',
                          style: TextStyle(
                            //fontSize: 30,
                            color: Colors.white,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      fadeanimation(
                        _emailController,
                        'example@gmail.com',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Password',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      fadeanimation(_passwordController, '**********',
                          istrue: true),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgetPassword(),
                        ));
                  },
                  child: Center(
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: InkWell(
                        onTap: () {
                          handleLogin();
                        },
                        child: buttons('Login')),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.grey,
                      height: 2,
                      width: 90,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    // Text('$orloginwith',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //     )),
                    // SizedBox(
                    //   width: 5,
                    // ),
                    // Container(
                    //   color: Colors.grey,
                    //   height: 2,
                    //   width: 90,
                    // ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     InkWell(
                //         onTap: () {
                //           setState(() {
                //             action = 'google';
                //           });
                //         },
                //         child: buttons1('google.png')),
                //     InkWell(onTap: () {}, child: buttons1('facebook.png')),
                //   ],
                // ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$createanaccount ? ',
                      style: TextStyle(color: Colors.white),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterationPage(),
                            ));
                      },
                      child: Text('$register',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ],
                ),
              ]),
        ));
  }

  String action;

  final _prefManager = PrefManager();

  //final _repository = Repository();

  final passwordFocusNode = new FocusNode();

  void handleLogin() async {
    if (verify()) {
      String email = _emailController.text;
      String password = _passwordController.text;
      _prefManager.set("email", email);
      _prefManager.set("password", password);
      showLoadingDialog(context, "Login...");
      signin(context);

      // await context
      //     .read<AuthService>()
      //     .login(email, password, context)
      //     .then((value) => {
      //           print(value),
      //           if (value == "Logged in")
      //             {
      //               Navigator.of(context).pop(),
      //               Navigator.of(context),
      //               _prefManager.set("sign_in", "login"),
      //               _prefManager.set("user.datas", json.encode(value)),
      //               Navigator.of(context).pushReplacement(
      //                   MaterialPageRoute(builder: (context) => Home()))
      //             }
      //         });
    }
  }

  saveuserdata(data) async {
    SharedPreferences savelogin = await SharedPreferences.getInstance();

    await savelogin.setString(
        'userdata',
        json.encode({
          "id": data['_id'],
          "email": data['email'],
          "contactno": data['contactno']
        }));
  }

  bool isLoading = false;
  Future<dynamic> signin(context) async {
    setState(() {
      isLoading = true;
    });
    await Controller()
        .signin(_emailController.text, _passwordController.text)
        .then((value) => {
              setState(() {
                isLoading = false;
              }),
              if (value != "Unauthorized")
                {
                  saveuserdata(value),
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home())),
                }
              else if (value == "User not exist")
                {
                  dialogbox(
                    context,
                    'Sorry',
                    'User not exist',
                  ),
                }
              else
                {
                  dialogbox(
                    context,
                    'Sorry',
                    'Wrong email or Password',
                  ),
                },
              print(value)
            });
    return "Success";
  }

  bool verify() {
    String email = _emailController.text;
    String password = _passwordController.text;
    if (email.isEmpty) {
      showMessage("Please enter your email or phone");
      return false;
    }
    if (password.isEmpty) {
      showMessage("Password can't be empty");
      return false;
    }

    return true;
  }

  showMessage(String message, [color]) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color ?? Colors.orange,
    ));
  }
}
