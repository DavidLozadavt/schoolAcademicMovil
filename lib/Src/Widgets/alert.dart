import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Alert extends GetxController {

  static void snacbarError(
      {BuildContext? context,
      String? title,
      String? message,
      Duration? duration}) {
    ScaffoldMessenger.of(context!)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: duration ?? const Duration(seconds: 3),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: title!,
          message: message!,
          contentType: ContentType.failure,
        ),
      ));
  }

  static void snacbarHelp(
      {BuildContext? context,
      String? title,
      String? message,
      Duration? duration}) {
    ScaffoldMessenger.of(context!)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: duration ?? const Duration(seconds: 3),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: title!,
          message: message!,
          contentType: ContentType.help,
        ),
      ));
  }

  static void snacbarWarning(
      {BuildContext? context,
      String? title,
      String? message,
      Duration? duration}) {
    ScaffoldMessenger.of(context!)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: duration ?? const Duration(seconds: 3),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: title!,
          message: message!,
          contentType: ContentType.warning,
        ),
      ));
  }

  static void snacbarSuccess(
      {BuildContext? context,
      String? title,
      String? message,
      Duration? duration}) {
    ScaffoldMessenger.of(context!)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: duration ?? const Duration(seconds: 3),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: title!,
          color: const Color(0xff00C535),
          message: message!,
          contentType: ContentType.success,
        ),
      ));
  }


}
