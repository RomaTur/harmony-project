import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibrate/vibrate.dart';

import 'fancy_button.dart';

//import ''
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HARMONY PROJECT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String result = 'Hey there';

  Future _scanQR() async {
    try {
      String qrString = await BarcodeScanner.scan();
      Vibrate.feedback(FeedbackType.success);
      setState(() {
        result = qrString;
      });
    } on PlatformException catch (e) {
      Vibrate.feedback(FeedbackType.error);
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = 'Camera permission was denied';
        });
      } else {
        setState(() {
          result = 'Unknown platform error --> $e';
        });
      }
    } on FormatException {
      setState(() {
        result = 'You pressed the back button before scanning anything';
      });
    } catch (e) {
      Vibrate.feedback(FeedbackType.error);
      setState(() {
        result = 'Unknown error --> $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topRight,
              end: FractionalOffset.bottomLeft,
              stops: [0, 0.5, 1],
              colors: [
                Colors.pinkAccent[200],
                Colors.indigoAccent[100],
                Colors.indigoAccent[200],
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  result,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FancyButton(onPressed: _scanQR));
  }
}
