import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PizzaOrderScreen(),
    );
  }
}

class PizzaOrderScreen extends StatefulWidget {
  @override
  _PizzaOrderScreenState createState() => _PizzaOrderScreenState();
}

class _PizzaOrderScreenState extends State<PizzaOrderScreen> {
  // State untuk menyimpan nilai Checkbox (Toppings)
  Map<String, bool> toppings = {
    "Onions": false,
    "Mushrooms": false,
    "Black olives": false,
    "Green peppers": false,
    "Extra cheese": false,
  };

  // State untuk menyimpan nilai Radio Button (Size)
  String selectedSize = "Small";
  List<String> sizes = ["Small", "Medium", "Large"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkbox & Radio Buttons'),
      ),
      body: SingleChildScrollView( // Ditambahkan agar tidak error jika layar kecil
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.0),
            Text(
              'Select Your Pizza Toppings :',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            
            // Generate Checkboxes
            ...toppings.keys.map((String key) {
              return CheckboxListTile(
                title: Text(key, style: TextStyle(fontSize: 20.0)),
                value: toppings[key],
                controlAffinity: ListTileControlAffinity.leading, // Checkbox di kiri
                onChanged: (bool? value) {
                  setState(() {
                    toppings[key] = value!;
                  });
                  // Menampilkan yang dicentang saja ke console
                  List<String> checked = toppings.keys.where((k) => toppings[k] == true).toList();
                  print(checked.toString());
                },
              );
            }).toList(),

            SizedBox(height: 10.0),
            Text(
              'Select Your Pizza Size :',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            
            // Generate Radio Buttons
            ...sizes.map((String size) {
              return RadioListTile<String>(
                title: Text(size, style: TextStyle(fontSize: 20.0)),
                value: size,
                groupValue: selectedSize,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (String? value) {
                  setState(() {
                    selectedSize = value!;
                  });
                  print(selectedSize);
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}