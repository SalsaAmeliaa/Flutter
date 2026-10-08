import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SizedBox',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SizedBox'),
      ),
      body: Column(
        children: <Widget>[
          Text("A", style: TextStyle(fontSize: 30.0)),
          SizedBox(height: 20.0),
          Text("B", style: TextStyle(fontSize: 30.0)),
        ],
      ),
    );
  }
}
