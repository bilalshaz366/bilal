import 'package:flutter/material.dart';

import 'RegisterationPages/login.dart';
import 'RegisterationPages/registerpage.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff293146),
        appBar: AppBar(
          backgroundColor: Color(0xff293146),
          elevation: 0.0,
          actions: [],
        ),
        body: Stack(
          children: [
            Image.asset(
              'assets/background.png',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Welcome to Petaffix Merchant App',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                      },
                      child: buttons(loginn: "Login")),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterationPage(),
                            ));
                      },
                      child: buttons(loginn: 'Register an account')),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.grey,
                        height: 2,
                        width: 90,
                        child: Text(''),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget buttons({String loginn, Color color, Color textcolor}) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      height: 60,
      width: 250,
      child: Card(
        color: color,
        elevation: 5.0,
        child: Center(
            child: Text(
          '$loginn',
          style: TextStyle(fontWeight: FontWeight.bold, color: textcolor),
        )),
      ),
    );
  }
}
