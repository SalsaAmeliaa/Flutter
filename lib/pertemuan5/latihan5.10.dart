import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Root App
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Screen0());
  }
}

// ------------------- Screen 0 -------------------
class Screen0 extends StatefulWidget {
  @override
  _Screen0State createState() => _Screen0State();
}

class _Screen0State extends State<Screen0> {
  String nama = "Budi"; // variabel yang akan dikirim
  int umur = 21; // variabel yang akan dikirim
  String statusBalikan = ""; // menampung variabel dari Screen1

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue, title: Text('Screen 0')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Nama: $nama, Umur: $umur"),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text('Kirim Data ke Screen 1'),
              onPressed: () async {
                // Kirim variabel nama & umur
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Screen1(nama: nama, umur: umur);
                    }
                  ), // MaterialPageRoute
                );

                // Update hasil balikan dari Screen 1
                if (result != null) {
                  setState(() {
                    statusBalikan = result; // variabel balikan
                  });
                }
              },
            ), // ElevatedButton
            SizedBox(height: 20),
            Text(
              "Status balikan dari Screen 1: $statusBalikan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ), // Text
          ], // <Widget>[]
        ), // Column
      ), // Center
    ); // Scaffold
  }
}

// ------------------- Screen 1 -------------------
class Screen1 extends StatefulWidget {
  final String nama;
  final int umur;

  Screen1({required this.nama, required this.umur});

  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  TextEditingController statusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue, title: Text('Screen 1')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Data dari Screen 0:", style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text(
                "Nama: ${widget.nama}, Umur: ${widget.umur}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ), // Text
              SizedBox(height: 20),
              TextField(
                controller: statusController,
                decoration: InputDecoration(
                  labelText: "Masukkan status balikan",
                  border: OutlineInputBorder(),
                ), // InputDecoration
              ), // TextField
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text('Kembalikan Data ke Screen 0'),
                onPressed: () {
                  // Ambil variabel dari input
                  String status = statusController.text.isEmpty
                      ? "Belum ada status"
                      : statusController.text;

                  // Kirim balik ke Screen0
                  Navigator.pop(context, status);
                },
              ), // ElevatedButton
            ], // <Widget>[]
          ), // Column
        ), // Center
      ), // Padding
    ); // Scaffold
  }
}