import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Stack Widget'),
        ),
        body: Stack(
          children: <Widget>[
            // Kotak 1: Kiri Atas
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                color: Colors.teal,
                width: 100.0,
                height: 100.0,
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'top: 0,\nleft: 0,',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            // Kotak 2: Kanan Atas
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                color: Colors.teal,
                width: 100.0,
                height: 100.0,
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'top: 0,\nright: 0,',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            // Kotak 3: Tengah Kanan (Agak ke atas)
            Positioned(
              top: 150,
              right: 50,
              child: Container(
                color: Colors.teal,
                width: 100.0,
                height: 100.0,
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'top: 150,\nright: 50,',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            // Kotak 4: Kiri Bawah (Agak ke tengah)
            Positioned(
              bottom: 200,
              left: 0,
              child: Container(
                color: Colors.teal,
                width: 100.0,
                height: 100.0,
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'bottom: 200,\nleft: 0,',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            // Kotak 5: Tengah Bawah
            Positioned(
              bottom: 200,
              left: 200,
              child: Container(
                color: Colors.teal,
                width: 100.0,
                height: 100.0,
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'bottom: 200,\nleft: 200,',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            // Kotak 6: Kiri Bawah (Pojok)
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                color: Colors.teal,
                width: 100.0,
                height: 100.0,
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'bottom: 0,\nleft: 0,',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            // Kotak 7: Kanan Bawah (Pojok)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                color: Colors.teal,
                width: 100.0,
                height: 100.0,
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'bottom: 0,\nright: 0,',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}