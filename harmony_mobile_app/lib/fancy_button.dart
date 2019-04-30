import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FancyButton extends StatelessWidget {
  FancyButton({@required this.onPressed});

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RawMaterialButton(
        fillColor: Colors.deepOrange,
        splashColor: Colors.orange,
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              const SizedBox(
                width: 8.0,
              ),
              const Text(
                "SCAN",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        shape: const StadiumBorder());
  }
}
