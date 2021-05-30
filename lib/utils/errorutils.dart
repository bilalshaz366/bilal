import 'package:flutter/material.dart';

showError(scaffoldKey, msg) {
  scaffoldKey.currentState.showSnackBar(
    SnackBar(
      content: Text(msg, style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.black87,
    ),
  );
}

void showLoadingDialog(BuildContext context, [String message]) {
  // flutter defined function
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              width: 32,
            ),
            Expanded(child: Text(message ?? "loading")),
          ],
        ),
      );
    },
  );
}
