import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harmony_mobile_app/samples/firestoreData.dart';
import 'package:harmony_mobile_app/utils/config.dart';

void main() {
  var configuredApp = AppConfig(
    text: "PROD",
    child: MyApp(),
  );
  runApp(configuredApp);
}
