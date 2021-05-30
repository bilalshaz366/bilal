import 'package:flutter/material.dart';

Widget buttons(String txt, {color = 0xff6E7482}) {
  return Container(
    decoration: BoxDecoration(
        color: Color(color), borderRadius: BorderRadius.circular(10)),
    height: 50,
    width: 270,
    child: Center(
      child: Text(
        '$txt',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget buttons1(String asset) {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/$asset')),
        borderRadius: BorderRadius.circular(10)),
    height: 50,
    width: 150,
  );
}

Widget fadeanimation(TextEditingController textcontroller, String hinttext,
    {bool istrue = false}) {
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
            obscureText: istrue,
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
