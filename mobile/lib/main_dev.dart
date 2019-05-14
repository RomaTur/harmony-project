import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:harmony_mobile_app/samples/firestoreData.dart';
import 'package:harmony_mobile_app/utils/config.dart';

void main() {
  Stetho.initialize();

  var configuredApp = AppConfig(
    text: "DEV",
    child: MyApp(),
  );
  runApp(configuredApp);
}
