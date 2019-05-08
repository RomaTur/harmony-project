import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harmony_mobile_app/samples/animatedButton/animated_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HARMONY PROJECT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: AnimatedButton(
              onTap: () {
                print("Animated button pressed");
              },
              animationDuration: Duration(milliseconds: 1500),
              initialText: "Принять",
              finalText: "Подписан",
              iconData: Icons.check,
              iconSize: 32.0,
              buttonStyle: ButtonStyle(
                  primaryColor: Colors.green.shade600,
                  secondaryColor: Colors.white,
                  elevation: 10.0,
                  borderRadius: 10.0,
                  initialTextStyle:
                      TextStyle(fontSize: 22.0, color: Colors.white),
                  finalTextStyle:
                      TextStyle(fontSize: 22.0, color: Colors.green.shade600))),
        ),
      ),
    );
  }
}
