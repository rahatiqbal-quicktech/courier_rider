import 'package:courier/GlobalUtils/UI_Colors.dart';
import 'package:flutter/material.dart';

class CustomDecoration {
  DecorationImage watermark() {
    return DecorationImage(
        colorFilter: new ColorFilter.mode(
            Colors.white.withOpacity(0.1), BlendMode.dstATop),
        image: AssetImage("assets/images/icon.png"),
        fit: BoxFit.fitWidth);
  }

  BoxDecoration buttonDecoration() {
    return BoxDecoration(
      // color: UIColors.primaryColor,
      borderRadius: BorderRadius.circular(10),
      gradient: new LinearGradient(
          colors: [
            UIColors.primaryColor,
            UIColors.primaryDarkColor,
          ],
          begin: const FractionalOffset(0.0, 0.5),
          end: const FractionalOffset(0.9, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(.5),
          blurRadius: 4,
          offset: Offset(4, 4), // changes position of shadow
        ),
      ],
    );
  }

  BoxDecoration textFieldDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(.5),
          blurRadius: 4,
          offset: Offset(4, 4), // changes position of shadow
        ),
      ],
    );
  }
}
