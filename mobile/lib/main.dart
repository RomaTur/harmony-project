import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harmony_mobile_app/env/prod.dart';
import 'package:harmony_mobile_app/samples/firestoreData.dart';
import 'package:harmony_mobile_app/utils/config.dart';

void main() {
  runApp(ConfigWrapper(config: Config.fromJson(config), child: new MyApp()));
}
