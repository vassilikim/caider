import 'package:flutter/material.dart';

class MyMessageHandler {
  static void showSnackbar(
      var context, var _scaffoldKey, String message, var color,
      {bool isInHomePage = false}) {
    _scaffoldKey.currentState!.hideCurrentSnackBar();
    _scaffoldKey.currentState!.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Roboto',
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
        margin: EdgeInsets.only(
          bottom: !isInHomePage
              ? MediaQuery.of(context).size.height - 100
              : MediaQuery.of(context).size.height - 170,
          left: 10,
          right: 10,
        ),
      ),
    );
  }
}
