import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

toast({String? msg, Color? backgroundColor}) {
  Fluttertoast.showToast(
      msg: msg!,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor!,
      textColor: Colors.white,
      fontSize: 16.0);
}
