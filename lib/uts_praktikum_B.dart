import 'package:flutter/material.dart';

void main() {
  runApp(const CargoFlowApp());
}

class CargoFlowApp extends StatelessWidget {
  const CargoFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CargoFlow Logistics',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ==========================================
// 1. HALAMAN AUTENTIKASI (LoginScreen)
// ==========================================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    String id = _idController.text;
    String password = _passwordController.text;

    // Validasi data statis (dummy check)
    if (id == 'petugas' && password == '1234') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ID Staf atau Kata Sandi salah!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login CargoFlow')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                hintText: 'Masukkan ID Staf (petugas)',
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                hintText: 'Masukkan Kata Sandi (1234)',
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 2. HALAMAN UTAMA & DASBOR LOGISTIK
// ==========================================
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  // Data rekap resi secara real-time (dimulai dari kosong)
  List<Map<String, String>> rekapResiData = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Fungsi untuk menambah resi baru secara real-time
  void _tambahResiBaru(String armada) {
    setState(() {
      int nextNumber = rekapResiData.length + 1;
      String noResiBaru = 'RS-${nextNumber.toString().padLeft(3, '0')}';
      rekapResiData.add({
        'no': noResiBaru,
        'armada': armada,
        'status': 'Proses'
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      ManifesMuatanScreen(onBookingBerhasil: _tambahResiBaru),
      RekapResiScreen(dataResi: rekapResiData),
      const InformasiDepoScreen(),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Dasbor Logistik')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Identitas Armada\nPT CargoFlow Logistik',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Beranda'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: 'Manifes Muatan'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Rekap Resi'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Informasi Depo'),
        ],
      ),
    );
  }
}

// --- SUB-MENU 1: MANIFES MUATAN ---
class ManifesMuatanScreen extends StatefulWidget {
  final Function(String) onBookingBerhasil;

  const ManifesMuatanScreen({super.key, required this.onBookingBerhasil});

  @override
  State<ManifesMuatanScreen> createState() => _ManifesMuatanScreenState();
}

class _ManifesMuatanScreenState extends State<ManifesMuatanScreen> {
  // Daftar armada dengan file lokal sesuai gambar aset Anda
  final List<Map<String, String>> armadaList = [
    {'nama': 'Colt Diesel', 'kapasitas': '4 Ton', 'gambar': 'assets/Colt-diesel.jpg'},
    {'nama': 'Fuso', 'kapasitas': '8 Ton', 'gambar': 'assets/Fuso.jpg'},
    {'nama': 'Tronton', 'kapasitas': '20 Ton', 'gambar': 'assets/Tronton.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            labelColor: Colors.blue,
            tabs: [
              Tab(text: 'Armada Tersedia'),
              Tab(text: 'Syarat Muatan'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // Tab 1: Armada Tersedia
                ListView.builder(
                  itemCount: armadaList.length,
                  itemBuilder: (context, index) {
                    final armada = armadaList[index];
                    return ListTile(
                      leading: SizedBox(
                        width: 60,
                        height: 60,
                        child: Stack(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Image.asset(
                                armada['gambar']!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                color: Colors.red,
                                child: Text(
                                  armada['kapasitas']!,
                                  style: const TextStyle(color: Colors.white, fontSize: 10),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      title: Text(armada['nama']!),
                      trailing: ElevatedButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CargoBookingScreen(tipeArmada: armada['nama']!),
                            ),
                          );
                          if (result == true) {
                            widget.onBookingBerhasil(armada['nama']!);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Surat jalan ${armada['nama']} berhasil diterbitkan & masuk ke rekap!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        },
                        child: const Text('Pilih'),
                      ),
                    );
                  },
                ),
                // Tab 2: Syarat Muatan Berbahaya (Menggunakan ExpansionPanelList.radio)
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExpansionPanelList.radio(
                      children: [
                        ExpansionPanelRadio(
                          value: '1',
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return const ListTile(
                              title: Text('Bahan Mudah Terbakar (Flammable)', style: TextStyle(fontWeight: FontWeight.bold)),
                            );
                          },
                          body: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Pastikan kontainer memiliki ventilasi udara yang baik. Jauhkan dari sumber panas dan percikan api.'),
                            ),
                          ),
                        ),
                        ExpansionPanelRadio(
                          value: '2',
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return const ListTile(
                              title: Text('Bahan Kimia Korosif (Corrosive)', style: TextStyle(fontWeight: FontWeight.bold)),
                            );
                          },
                          body: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Gunakan kemasan berbahan plastik khusus atau segel ganda anti karat.'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- SUB-MENU 2: REKAP RESI ---
class RekapResiScreen extends StatelessWidget {
  final List<Map<String, String>> dataResi;

  const RekapResiScreen({super.key, required this.dataResi});

  @override
  Widget build(BuildContext context) {
    if (dataResi.isEmpty) {
      return const Center(
        child: Text(
          'Belum ada data resi.\nLakukan booking kargo terlebih dahulu.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
          columns: const [
            DataColumn(label: Text('No. Resi')),
            DataColumn(label: Text('Armada')),
            DataColumn(label: Text('Status')),
          ],
          rows: dataResi.map((resi) {
            return DataRow(cells: [
              DataCell(Text(resi['no']!)),
              DataCell(Text(resi['armada']!)),
              DataCell(Text(resi['status']!)),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}

// --- SUB-MENU 3: INFORMASI DEPO ---
class InformasiDepoScreen extends StatelessWidget {
  const InformasiDepoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Depo Logistik CargoFlow Tanjung Priok", 
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          SelectableText(
            "Kode Tracking API Pusat: API-TRK-998822-CFX",
            style: const TextStyle(fontSize: 16, color: Colors.blue),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            "(Tahan teks untuk menyalin)",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          )
        ],
      ),
    );
  }
}

// ==========================================
// 3. HALAMAN FORMULIR BOOKING KARGO
// ==========================================
class CargoBookingScreen extends StatefulWidget {
  final String tipeArmada;
  const CargoBookingScreen({super.key, required this.tipeArmada});

  @override
  State<CargoBookingScreen> createState() => _CargoBookingScreenState();
}

class _CargoBookingScreenState extends State<CargoBookingScreen> {
  String? _kategoriKargo = 'General Cargo';
  bool _asuransi = false;
  bool _forklift = false;
  bool _pengawalan = false;
  DateTime? _tanggalJemput;
  TimeOfDay? _waktuBerangkat;
  double _tonase = 1.0;
  bool _isReeferOn = false;

  void _pilihTanggal() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => _tanggalJemput = picked);
  }

  void _pilihWaktu() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) setState(() => _waktuBerangkat = picked);
  }

  void _tampilkanBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Rincian Biaya Surat Jalan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text('Armada: ${widget.tipeArmada}'),
              Text('Kategori: $_kategoriKargo'),
              Text('Tonase Estimasi: ${_tonase.toStringAsFixed(1)} Ton'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _tampilkanDialogKonfirmasi();
                },
                child: const Text('Konfirmasi Akhir'),
              )
            ],
          ),
        );
      },
    );
  }

  void _tampilkanDialogKonfirmasi() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Penerbitan Surat Jalan'),
          content: const Text('Apakah Anda yakin ingin menerbitkan surat jalan ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, true); // Kembali ke layar utama dengan sinyal sukses
              },
              child: const Text('Setuju'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Booking: ${widget.tipeArmada}')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text('Kategori Muatan:', style: TextStyle(fontWeight: FontWeight.bold)),
          RadioListTile<String>(
            title: const Text('General Cargo'),
            value: 'General Cargo',
            groupValue: _kategoriKargo,
            onChanged: (val) => setState(() => _kategoriKargo = val),
          ),
          RadioListTile<String>(
            title: const Text('Makanan Beku/Perishable'),
            value: 'Makanan Beku/Perishable',
            groupValue: _kategoriKargo,
            onChanged: (val) => setState(() => _kategoriKargo = val),
          ),
          RadioListTile<String>(
            title: const Text('Alat Berat'),
            value: 'Alat Berat',
            groupValue: _kategoriKargo,
            onChanged: (val) => setState(() => _kategoriKargo = val),
          ),

          const Divider(),
          const Text('Proteksi Pengiriman:', style: TextStyle(fontWeight: FontWeight.bold)),
          CheckboxListTile(
            title: const Text('Asuransi Barang Rusak'),
            value: _asuransi,
            onChanged: (val) => setState(() => _asuransi = val!),
          ),
          CheckboxListTile(
            title: const Text('Jasa Forklift Muat'),
            value: _forklift,
            onChanged: (val) => setState(() => _forklift = val!),
          ),
          CheckboxListTile(
            title: const Text('Pengawalan Prioritas'),
            value: _pengawalan,
            onChanged: (val) => setState(() => _pengawalan = val!),
          ),

          const Divider(),
          const Text('Jadwal Pengambilan:', style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _pilihTanggal,
                  child: Text(_tanggalJemput == null ? 'Pilih Tanggal' : '${_tanggalJemput!.toLocal()}'.split(' ')[0]),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: _pilihWaktu,
                  child: Text(_waktuBerangkat == null ? 'Pilih Waktu' : _waktuBerangkat!.format(context)),
                ),
              ),
            ],
          ),

          const Divider(),
          const Text('Pengaturan Muatan:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Tonase Estimasi: ${_tonase.toStringAsFixed(1)} Ton'),
          Slider(
            value: _tonase,
            min: 1.0,
            max: 20.0,
            divisions: 19,
            label: _tonase.toStringAsFixed(1),
            onChanged: (val) => setState(() => _tonase = val),
          ),
          SwitchListTile(
            title: const Text('Sistem Mesin Pendingin (Reefer)'),
            value: _isReeferOn,
            onChanged: (val) => setState(() => _isReeferOn = val),
          ),
          
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16.0)),
            onPressed: _tampilkanBottomSheet,
            child: const Text('Hitung Biaya Logistik', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}