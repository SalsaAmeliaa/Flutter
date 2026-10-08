import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 93,
                color: Colors.grey[200],
              ),

              const SizedBox(height: 19),

              Container(
                width: double.infinity,
                height: 93,
                color: Colors.grey[200],
              ),

              const SizedBox(height: 19),

              Container(
                width: double.infinity,
                height: 93,
                color: Colors.grey[200],
              ),

              const SizedBox(height: 19),

              Container(
                width: double.infinity,
                height: 93,
                color: Colors.grey[200],
              ),

              const SizedBox(height: 19),

              Container(
                width: double.infinity,
                height: 93,
                color: Colors.grey[200],
              ),
            ],
          ),
        ),
      ),
    );
  }
}