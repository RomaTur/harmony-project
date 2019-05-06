//import 'package:barcode_scan/barcode_scan.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:vibrate/vibrate.dart';
//
//import 'fancy_button.dart';
//
////import ''
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby Names',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Baby Name Votes')),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cloud_download),
        onPressed: _loadData,
      ),
    );
  }

  _loadData() async {
    try {
      final response = await http.get('https://api.coinmarketcap.com/v2/ticker/?limit=10');

      if(response.statusCode != 200) {
        int statusCode = response.statusCode;
        throw new Exception("Error -> load data: $statusCode");
      }
      var allData = (jsonDecode(response.body) as Map)["data"] as Map<String, dynamic>;

      allData.forEach((String key, dynamic obj) {
        print(obj['name']);
      });

    } catch (loadError) {
      print(loadError);
    }

  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection("names").snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) return LinearProgressIndicator();
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) =>
          _buildListItem(context, snapshot.data.documents[index]),
        );
      },
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          trailing: Text(record.votes.toString()),
          onTap: () => Firestore.instance.runTransaction((transaction) async {
            final freshSnapshot = await transaction.get(record.reference);
            final fresh = Record.fromSnapshot(freshSnapshot);

            await transaction
                .update(record.reference, {'votes': fresh.votes + 1});
          }),
        ),
      ),
    );
  }
}

class Record {
  final String name;
  final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        name = map['name'],
        votes = map['votes'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$votes>";
}