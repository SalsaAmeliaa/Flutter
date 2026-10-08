import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buttons',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buttons'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
              child: Text("Elevated Button"),
              onPressed: () {},
            ),
            SizedBox(height: 12),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lime,
              ),
              child: Text("Material Button"),
              onPressed: () {},
            ),
            SizedBox(height: 12),

            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.lightGreenAccent,
              ),
              child: Text("Text Button"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}