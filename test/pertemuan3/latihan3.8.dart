class Mobil {
  String merk;
  String warna;
  int kecepatan;

  Mobil(this.merk, this.warna, this.kecepatan);

  void jalan() {
    print("$merk sedang berjalan dengan kecepatan $kecepatan km/jam.");
  }

  void rem(){
    print("$merk berhenti.");
  }

  void klakson() {
    print("$merk membunyikan klakson: Beep Beep!");
  }
}

void main() {
  var avanza = Mobil("Toyota Avanza", "Hitam", 80);
  avanza.jalan();
  avanza.klakson();
  avanza.rem();

  var civic = Mobil("Honda Civic", "Merah", 120);
  civic.jalan();
}