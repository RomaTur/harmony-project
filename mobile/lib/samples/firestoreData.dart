import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:harmony_mobile_app/utils/config.dart';
import 'package:http/http.dart' as http;

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
    var config = ConfigWrapper.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Baby Name Votes --- ${config.text}')),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cloud_download),
        onPressed: _loadData,
      ),
    );
  }

  _loadData() async {
    try {
      final response =
          await http.get('https://api.coinmarketcap.com/v2/ticker/?limit=10');

      if (response.statusCode != 200) {
        int statusCode = response.statusCode;
        throw new Exception("Error -> load data: $statusCode");
      }
      var allData =
          (jsonDecode(response.body) as Map)["data"] as Map<String, dynamic>;

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
        if (!snapshot.hasData) return LinearProgressIndicator();
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
    var config = ConfigWrapper.of(context);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          title: Text("${record.name} --- ${config.num}"),
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
