
import 'package:coffeasy/common_widgets/custom_raised_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormSubmitButton extends CustomRaisedButton{
  FormSubmitButton({
    required String text,
    required VoidCallback onPressed,
}) : super(
    child: Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: 20
      ),
    ),
    height: 44,
    color: Colors.indigo,
    borderRadius: 4,
    onPressed: onPressed,
  );
}