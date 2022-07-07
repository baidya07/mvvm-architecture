import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{

  static void fieldFocusChange(
      BuildContext context,
      FocusNode current,
      FocusNode nextFocus){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG
    );
  }

  static void flushBarErrorMessage(String message, BuildContext context){
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.bounceInOut,
          message: message,
        )..show(context),
    );
  }

  static snackBar(String message, BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.greenAccent,
            content: Text(message))
    );
  }
}