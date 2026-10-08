import 'package:flutter/material.dart';

void main() {
  runApp(const SmartRetailApp());
}

class SmartRetailApp extends StatelessWidget {
  const SmartRetailApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartRetail POS',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// 1. Halaman Autentikasi Pengguna (LoginScreen)

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_usernameController.text == 'admin' && _passwordController.text == '1234') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username atau Password salah!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SmartRetail Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Masukkan Username',
                prefixIcon: const Icon(Icons.person),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
                enabledBorder: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Masukkan Password',
                prefixIcon: const Icon(Icons.lock),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
                enabledBorder: const OutlineInputBorder(),
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

// 2. Halaman Utama & Dasbor Kasir

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  final List<bool> _isExpanded = [false, false];

  final List<Map<String, dynamic>> _katalogProduk = [
    {'nama': 'Laptop', 'harga': 'Rp 7.500.000', 'gambar': 'assets/Laptop.jpg'},
    {'nama': 'PC Desktop', 'harga': 'Rp 10.000.000', 'gambar': 'assets/Pc.jpg'},
    {'nama': 'Printer Inkjet', 'harga': 'Rp 2.500.000', 'gambar': 'assets/Printer.jpg'},
    {'nama': 'Keyboard Mekanik', 'harga': 'Rp 500.000', 'gambar': 'assets/Keyboard.jpg'},
    {'nama': 'Mouse Wireless', 'harga': 'Rp 150.000', 'gambar': 'assets/Mouse.jpg'},
  ];

  final List<Map<String, dynamic>> _riwayatTransaksi = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _pesanProduk(Map<String, dynamic> produk) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderFormScreen(produk: produk)),
    );

    if (!mounted) return;

    if (result != null && result is String) {
      setState(() {
        _riwayatTransaksi.add({
          'id': 'TRX${(_riwayatTransaksi.length + 1).toString().padLeft(3, '0')}',
          'nama': produk['nama'],
          'total': result, 
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Transaksi untuk ${produk['nama']} sukses!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dasbor Kasir")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Kasir: Admin', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Beranda'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Katalog'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Informasi Toko'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0: return _buildKatalog();
      case 1: return _buildRiwayat();
      case 2: return _buildInformasi();
      default: return _buildKatalog();
    }
  }

  Widget _buildKatalog() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            labelColor: Colors.blue,
            tabs: [Tab(text: "Produk"), Tab(text: "Ketentuan Promo")],
          ),
          Expanded(
            child: TabBarView(
              children: [
                ListView.builder(
                  itemCount: _katalogProduk.length,
                  itemBuilder: (context, index) {
                    final produk = _katalogProduk[index];
                    return ListTile(
                      leading: SizedBox(
                        width: 50,
                        height: 50,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.asset(
                                produk['gambar'],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.image_not_supported, color: Colors.grey),
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                color: Colors.red,
                                padding: const EdgeInsets.all(2),
                                child: const Text('50%', style: TextStyle(color: Colors.white, fontSize: 10)),
                              ),
                            )
                          ],
                        ),
                      ),
                      title: Text(produk['nama']),
                      subtitle: Text(produk['harga']),
                      trailing: ElevatedButton(
                        onPressed: () => _pesanProduk(produk),
                        child: const Text('Pesan'),
                      ),
                    );
                  },
                ),
                SingleChildScrollView(
                  child: ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        _isExpanded[index] = !isExpanded;
                      });
                    },
                    children: [
                      ExpansionPanel(
                        headerBuilder: (context, isExpanded) => const ListTile(title: Text("Promo Akhir Tahun")),
                        body: const ListTile(title: Text("Diskon 50% untuk pembelian di atas 100rb.")),
                        isExpanded: _isExpanded[0],
                      ),
                      ExpansionPanel(
                        headerBuilder: (context, isExpanded) => const ListTile(title: Text("Cashback Member")),
                        body: const ListTile(title: Text("Cashback 10% untuk member prioritas.")),
                        isExpanded: _isExpanded[1],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiwayat() {
    if (_riwayatTransaksi.isEmpty) {
      return const Center(child: Text("Belum ada transaksi."));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('ID Transaksi')),
          DataColumn(label: Text('Barang')),
          DataColumn(label: Text('Total Pembayaran')),
        ],
        rows: _riwayatTransaksi.map((trx) {
          return DataRow(cells: [
            DataCell(Text(trx['id'])),
            DataCell(Text(trx['nama'])),
            DataCell(Text(trx['total'], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green))),
          ]);
        }).toList(),
      ),
    );
  }

  Widget _buildInformasi() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("SmartRetail Official Store", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SelectableText(
            "Kode Lisensi Resmi: SMRT-2026-X890",
            style: const TextStyle(fontSize: 16, color: Colors.blue),
          ),
          const Text("(Tahan teks untuk menyalin)")
        ],
      ),
    );
  }
}

// 3. Halaman Formulir Pemesanan (OrderFormScreen)

class OrderFormScreen extends StatefulWidget {
  final Map<String, dynamic> produk;
  const OrderFormScreen({Key? key, required this.produk}) : super(key: key);

  @override
  State<OrderFormScreen> createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends State<OrderFormScreen> {
  String _pengiriman = 'Reguler';
  bool _asuransi = false;
  bool _bubbleWrap = false;
  bool _packingKayu = false;
  DateTime? _tanggalPengambilan;
  TimeOfDay? _waktuPengambilan;
  double _diskonMember = 0;
  bool _isDropship = false;

  void _pilihTanggal() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => _tanggalPengambilan = picked);
  }

  void _pilihWaktu() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) setState(() => _waktuPengambilan = picked);
  }

  String _formatRupiah(int angka) {
    String str = angka.toString();
    String result = '';
    int count = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      result = str[i] + result;
      count++;
      if (count == 3 && i != 0) {
        result = '.$result';
        count = 0;
      }
    }
    return 'Rp $result';
  }

  void _prosesTransaksi() {
    final BuildContext parentContext = context; 

    String hargaStr = widget.produk['harga'].replaceAll(RegExp(r'[^0-9]'), '');
    int hargaAsli = int.tryParse(hargaStr) ?? 0;
    int potongan = (hargaAsli * _diskonMember / 100).round();
    int hargaAkhir = hargaAsli - potongan;
    String hargaAkhirTeks = _formatRupiah(hargaAkhir);

    String teksTanggal = _tanggalPengambilan != null 
        ? "${_tanggalPengambilan!.day}/${_tanggalPengambilan!.month}/${_tanggalPengambilan!.year}" 
        : "-";
    String teksWaktu = _waktuPengambilan != null 
        ? _waktuPengambilan!.format(context) 
        : "-";

    showModalBottomSheet(
      context: parentContext,
      builder: (BuildContext bottomSheetContext) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Rincian Biaya', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text('Produk: ${widget.produk['nama']}'),
              Text('Pengiriman: $_pengiriman'),
              Text('Jadwal Ambil: $teksTanggal | $teksWaktu'),
              Text('Harga Normal: ${widget.produk['harga']}'),
              Text('Potongan Diskon: ${_diskonMember.toInt()}% (-${_formatRupiah(potongan)})'),
              const Divider(),
              Text(
                'Total Pembayaran: $hargaAkhirTeks', 
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: bottomSheetContext,
                    builder: (BuildContext dialogContext) {
                      return AlertDialog(
                        title: const Text('Konfirmasi Transaksi'),
                        content: const Text('Apakah Anda yakin ingin memproses transaksi ini?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            child: const Text('Batal'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(dialogContext); 
                              Navigator.pop(bottomSheetContext); 
                              Navigator.pop(parentContext, hargaAkhirTeks); 
                            },
                            child: const Text('Setuju'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Konfirmasi Akhir'),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pesan: ${widget.produk['nama']}")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text("Metode Pengiriman:", style: TextStyle(fontWeight: FontWeight.bold)),
          RadioListTile(title: const Text('Reguler'), value: 'Reguler', groupValue: _pengiriman, onChanged: (val) => setState(() => _pengiriman = val.toString())),
          RadioListTile(title: const Text('Kargo'), value: 'Kargo', groupValue: _pengiriman, onChanged: (val) => setState(() => _pengiriman = val.toString())),
          RadioListTile(title: const Text('Instan'), value: 'Instan', groupValue: _pengiriman, onChanged: (val) => setState(() => _pengiriman = val.toString())),
          
          const Divider(),
          const Text("Layanan Ekstra:", style: TextStyle(fontWeight: FontWeight.bold)),
          CheckboxListTile(title: const Text('Asuransi Pengiriman'), value: _asuransi, onChanged: (val) => setState(() => _asuransi = val!)),
          CheckboxListTile(title: const Text('Bubble Wrap Ekstra'), value: _bubbleWrap, onChanged: (val) => setState(() => _bubbleWrap = val!)),
          CheckboxListTile(title: const Text('Packing Kayu'), value: _packingKayu, onChanged: (val) => setState(() => _packingKayu = val!)),

          const Divider(),
          const Text("Jadwal Pengambilan:", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  ElevatedButton(onPressed: _pilihTanggal, child: const Text("Pilih Tanggal")),
                  const SizedBox(height: 5),
                  Text(
                    _tanggalPengambilan == null 
                        ? "Belum dipilih" 
                        : "${_tanggalPengambilan!.day}/${_tanggalPengambilan!.month}/${_tanggalPengambilan!.year}",
                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  ElevatedButton(onPressed: _pilihWaktu, child: const Text("Pilih Jam")),
                  const SizedBox(height: 5),
                  Text(
                    _waktuPengambilan == null 
                        ? "Belum dipilih" 
                        : _waktuPengambilan!.format(context),
                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),

          const Divider(),
          Text("Diskon Member: ${_diskonMember.toInt()}%", style: const TextStyle(fontWeight: FontWeight.bold)),
          Slider(
            value: _diskonMember,
            min: 0,
            max: 50,
            divisions: 10,
            label: '${_diskonMember.toInt()}%',
            onChanged: (val) => setState(() => _diskonMember = val),
          ),

          const Divider(),
          SwitchListTile(
            title: const Text('Aktifkan mode Dropship'),
            value: _isDropship,
            onChanged: (val) => setState(() => _isDropship = val),
          ),

          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
            onPressed: _prosesTransaksi,
            child: const Text('Proses Transaksi', style: TextStyle(fontSize: 16)),
          )
        ],
      ),
    );
  }
}