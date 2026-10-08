import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Latihan 4.14',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('InkWell'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            print("Ditekan");
          },
          child: Container(
            width: 100.0,
            height: 100.0,
            color: Colors.pink,
          ),
        ),
      ),
    );
  }
}