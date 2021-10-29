import 'package:coffeasy/common_widgets/custom_raised_button.dart';
import 'package:flutter/material.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton({
    required String assetName,
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
  })  : assert(assetName != null),
        assert(text != null),
        //If there's an error, the error line (in command) will point directly to
        // the file that generated the error (this) instead of Flutter's default
        //it's useful for runtime checks
        super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(assetName),
              Text(
                text,
                style: TextStyle(color: textColor, fontSize: 15),
              ),
              Opacity(
                //wrapping the Image widget in Opacity 0
                //to center the text evenly using spaceBetween
                child: Image.asset(assetName),
                opacity: 0,
              ),
            ],
          ),
          color: color,
          onPressed: onPressed,
        );
}
