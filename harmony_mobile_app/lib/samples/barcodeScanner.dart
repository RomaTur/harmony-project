//import 'package:barcode_scan/barcode_scan.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/foundation.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:vibrate/vibrate.dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'HARMONY PROJECT',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: MyHomePage(),
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key}) : super(key: key);
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  String result = 'Hey there';
//
//  Future _scanQR() async {
//    try {
//      String qrString = await BarcodeScanner.scan();
//      Vibrate.feedback(FeedbackType.success);
//      setState(() {
//        result = qrString;
//      });
//    } on PlatformException catch (e) {
//      Vibrate.feedback(FeedbackType.error);
//      if (e.code == BarcodeScanner.CameraAccessDenied) {
//        setState(() {
//          result = 'Camera permission was denied';
//        });
//      } else {
//        setState(() {
//          result = 'Unknown platform error --> $e';
//        });
//      }
//    } on FormatException {
//      setState(() {
//        result = 'You pressed the back button before scanning anything';
//      });
//    } catch (e) {
//      Vibrate.feedback(FeedbackType.error);
//      setState(() {
//        result = 'Unknown error --> $e';
//      });
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        body: Container(
//          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//          decoration: BoxDecoration(
//            gradient: LinearGradient(
//              begin: FractionalOffset.topRight,
//              end: FractionalOffset.bottomLeft,
//              stops: [0, 0.5, 1],
//              colors: [
//                Colors.pinkAccent[200],
//                Colors.indigoAccent[100],
//                Colors.indigoAccent[200],
//              ],
//            ),
//          ),
//          child: Center(
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.start,
//              children: <Widget>[
//                Text(
//                  result,
//                ),
//              ],
//            ),
//          ),
//        ),
//        floatingActionButton: FancyButton(onPressed: _scanQR));
//  }
//}
//
//class FancyButton extends StatelessWidget {
//  FancyButton({@required this.onPressed});
//
//  final GestureTapCallback onPressed;
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return RawMaterialButton(
//        fillColor: Colors.deepOrange,
//        splashColor: Colors.orange,
//        onPressed: onPressed,
//        child: Padding(
//          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
//          child: Row(
//            mainAxisSize: MainAxisSize.min,
//            children: <Widget>[
//              const Icon(
//                Icons.camera_alt,
//                color: Colors.white,
//              ),
//              const SizedBox(
//                width: 8.0,
//              ),
//              const Text(
//                "SCAN",
//                style: TextStyle(color: Colors.white),
//              ),
//            ],
//          ),
//        ),
//        shape: const StadiumBorder());
//  }
//}
