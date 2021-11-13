import 'package:coffeasy/common_widgets/show_alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

Future<void> showExceptionAlertDialog(
  BuildContext context, {
  required String title,
  required Exception exception,
}) =>
    showAlertDialog(context,
        title: title, content: _message(exception), defaultActionText: 'OK');

String _message(Exception e) {
  if (e is FirebaseException) {
    return e.message!;
  }
  return e.toString();
}
