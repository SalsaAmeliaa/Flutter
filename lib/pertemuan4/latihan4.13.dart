import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Latihan 4.13',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Form Field'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(hintText: "Username"),
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(hintText: "Password"),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text("Login"),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}