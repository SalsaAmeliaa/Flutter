import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Latihan',
      home: Scaffold(
        appBar: AppBar(title: const Text("Belajar Flutter")),
        body: Center(
          // Memusatkan seluruh widget di dalam body
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                color: Colors.blue,
                child: Text(
                  "Hello World",
                  style: TextStyle(color: Colors.white),
                ), // Text
              ), // Container
              SizedBox(height: 20),
              ElevatedButton(onPressed: () {}, child: Text("Click Me")),
            ],
          ), // Column
        ), // Center
      ), // Scaffold
    ); // MaterialApp
  }
}