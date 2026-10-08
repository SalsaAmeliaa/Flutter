import 'package:flutter/material.dart';

void main() {
  runApp(const KampusKuApp());
}

class KampusKuApp extends StatelessWidget {
  const KampusKuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KampusKu App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// 1. SCREEN: LOGIN
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username == 'admin' && password == '1234') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username atau password salah!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterScreen()),
                );
              },
              child: const Text('Belum punya akun? Register'),  
            ),
          ],
        ),
      ),
    );
  }
}

// 2. SCREEN: REGISTER

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Username')),
            const TextField(decoration: InputDecoration(labelText: 'Email')),
            const TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Registrasi berhasil, silakan login!'),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text('Daftar'),
            ),
          ],
        ),
      ),
    );
  }
}

// 3. SCREEN: MAIN (HOLDER UNTUK BOTTOM NAV & DRAWER)

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const BeritaScreen(),
    const KontakScreen(),
    const ProfilScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KampusKu App'), 
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu Navigasi',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Berita'),
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Kontak'),
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Profil'),
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Berita'),
          BottomNavigationBarItem(icon: Icon(Icons.contact_phone), label: 'Kontak'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

// 4. SCREEN: HOME (TAB BAR)
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Beranda'), 
              Tab(text: 'Artikel'), 
              Tab(text: 'Akun'),   
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                
                const Center(
                  child: SelectableText(
                    'Selamat datang di aplikasi KampusKu!', 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                _buildArtikelTab(context),
                _buildAkunTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArtikelTab(BuildContext context) {
    final List<Map<String, String>> artikel = List.generate(
      5,
      (index) => {
        'title': 'Artikel ${index + 1}', 
        'summary': 'Ini adalah ringkasan artikel ${index + 1}', 
        'image': 'https://via.placeholder.com/150',
      },
    );

    return ListView.builder(
      itemCount: artikel.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.article), 
          title: Text(artikel[index]['title']!),
          subtitle: Text(artikel[index]['summary']!),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailArtikelScreen(
                  title: artikel[index]['title']!,
                  summary: artikel[index]['summary']!,
                  imageUrl: artikel[index]['image']!,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildAkunTab() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('NIM')),  
          DataColumn(label: Text('Nama')),  
          DataColumn(label: Text('Prodi')),  
        ],
        rows: const [
          DataRow(cells: [
            DataCell(Text('10602050')),  
            DataCell(Text('Salsa Amelia')),   
            DataCell(Text('TRPL')),   
          ]),
          DataRow(cells: [
            DataCell(Text('10602016')),  
            DataCell(Text('Gefira Nazibah Nur Luzain')),   
            DataCell(Text('TRPL')),   
          ]),
          DataRow(cells: [
            DataCell(Text('10602058')),  
            DataCell(Text('Tsenia Amelia')),  
            DataCell(Text('TRPL')),   
          ]),
        ],
      ),
    );
  }
}

class DetailArtikelScreen extends StatelessWidget {
  final String title;
  final String summary;
  final String imageUrl;

  const DetailArtikelScreen({
    Key? key,
    required this.title,
    required this.summary,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(summary, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

// 5. SCREEN: BERITA
class BeritaScreen extends StatelessWidget {
  const BeritaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> berita = List.generate(
      3,
      (index) => {
        'title': 'Berita Kampus ${index + 1}',  
        'summary': 'Ringkasan berita kampus ${index + 1}',  
      },
    );

    return ListView.builder(
      itemCount: berita.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.newspaper),  
          title: Text(berita[index]['title']!),
          subtitle: Text(berita[index]['summary']!),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailBeritaScreen(
                  title: berita[index]['title']!,
                  summary: berita[index]['summary']!,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class DetailBeritaScreen extends StatelessWidget {
  final String title;
  final String summary;

  const DetailBeritaScreen({
    Key? key,
    required this.title,
    required this.summary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Image.network('https://via.placeholder.com/400x200'),
            const SizedBox(height: 16),
            Text(summary, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text('Video Terkait:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.black87,
              child: const Center(
                child: Icon(Icons.play_circle_fill, color: Colors.red, size: 60),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 6. SCREEN: KONTAK

class KontakScreen extends StatelessWidget {
  const KontakScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          leading: Icon(Icons.person),  
          title: Text('Erick Febriyanto,S.Kom.,M.Ti.'),  
          subtitle: Text('08123456789'),  
        ),
        ListTile(
          leading: Icon(Icons.person),  
          title: Text('Mohammad Iqbal,S.Kom.,M.T.'),  
          subtitle: Text('08987654321'),  
        ),
      ],
    );
  }
}

// 7. SCREEN: PROFIL

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1517694712202-14dd9538aa97',
              height: 300,
              width: 300,
              fit: BoxFit.cover,
            ),

            Container(
              width: 300,
              color: Colors.black54,
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Nama Mahasiswa: Salsa Amelia',  
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}