import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: ScreenSatu()));

// SCREEN 1: HALAMAN INPUT DATA

class ScreenSatu extends StatefulWidget {
  const ScreenSatu();

  @override
  State<ScreenSatu> createState() => _ScreenSatuState();
}

class _ScreenSatuState extends State<ScreenSatu> {
  final _suhu = TextEditingController();
  
  String _satuan = 'Celsius'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Konversi Suhu - Input')),
      
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            // 1. KOTAK INPUT ANGKA
            TextField(
              controller: _suhu,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Masukkan Suhu'),
            ),
            
            const SizedBox(height: 20),
            
            // 2. TOMBOL DROPDOWN (PILIHAN)
            DropdownButton<String>(
              value: _satuan,
              isExpanded: true,
              items: ['Celsius', 'Fahrenheit', 'Reamur', 'Kelvin']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => _satuan = val!),
            ),
            
            const SizedBox(height: 30),
            
            // 3. TOMBOL KONVERSI (PINDAH HALAMAN)
            ElevatedButton(
              onPressed: () {
                if (_suhu.text.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScreenDua(
                        suhu: double.parse(_suhu.text), 
                        satuan: _satuan, 
                      ),
                    ),
                  );
                }
              },
              child: const Text('Konversi'),
            )
          ],
        ),
      ),
    );
  }
}

// SCREEN 2: HALAMAN UNTUK MENAMPILKAN HASIL

class ScreenDua extends StatelessWidget {
  final double suhu;
  final String satuan;

  const ScreenDua({required this.suhu, required this.satuan});

  @override
  Widget build(BuildContext context) {
    // --- LOGIKA PERHITUNGAN MATEMATIKA ---
    
    // Langkah 1: Apapun satuan asalnya, kita jadikan suhu Celsius ('c') sebagai patokan tengah
    double c = 0;
    if (satuan == 'Celsius') c = suhu;
    else if (satuan == 'Fahrenheit') c = (suhu - 32) * 5 / 9;
    else if (satuan == 'Reamur') c = suhu * 5 / 4;
    else if (satuan == 'Kelvin') c = suhu - 273.15;

    // Langkah 2: Dari angka patokan Celsius tersebut, kita hitung 3 hasil lainnya
    double f = (c * 9 / 5) + 32;
    double r = c * 4 / 5;
    double k = c + 273.15;

    // --- MENGGAMBAR TAMPILAN HASIL ---
    return Scaffold(
      appBar: AppBar(title: const Text('Konversi Suhu - Hasil')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            Text(
              'Input: $suhu $satuan', 
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 20),
            
            if (satuan != 'Celsius') Text('Celsius: ${c.toStringAsFixed(2)}'),
            if (satuan != 'Fahrenheit') Text('Fahrenheit: ${f.toStringAsFixed(2)}'),
            if (satuan != 'Reamur') Text('Reamur: ${r.toStringAsFixed(2)}'),
            if (satuan != 'Kelvin') Text('Kelvin: ${k.toStringAsFixed(2)}'),
            
            const SizedBox(height: 40),
            
            // TOMBOL KEMBALI
            ElevatedButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}