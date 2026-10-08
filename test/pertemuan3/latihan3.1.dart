class Kendaraan {
  String merk = "";
  int tahun = 0;

  void jalan() {
    print("$merk sedang berjalan.");
  }
}

void main() {
  var mobil = Kendaraan();
  mobil.merk = "Toyota";
  mobil.tahun = 2022;

  mobil.jalan();
}