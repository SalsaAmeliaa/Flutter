import 'dart:io';

class Barang {
  String nama;
  int harga;
  int stok;

  Barang(this.nama, this.harga, this.stok);
}

void main() {

  List<Barang> barang = [
    Barang("Susu UHT", 10000, 10),
    Barang("Roti Tawar", 15000, 5),
    Barang("Air Mineral", 5000, 20),
  ];

  List<int> jumlahBeli = [0, 0, 0];

  bool ulang = true;

  print("=== Toko AMCC ===");
  print("\nBarang Tersedia:");

  for (int i = 0; i < barang.length; i++) {
    print(
      "${i + 1}. ${barang[i].nama} - Harga ${barang[i].harga}, Stok: ${barang[i].stok}",
    );
  }

  while (ulang) {
    stdout.write("\nPilih nomor barang yang ingin dibeli: ");
    int pilihan = int.parse(stdin.readLineSync()!);

    if (pilihan < 1 || pilihan > barang.length) {
      print("Nomor barang tidak tersedia!");
      continue;
    }

    int index = pilihan - 1;

    stdout.write("Jumlah beli: ");
    int jumlah = int.parse(stdin.readLineSync()!);

    if (jumlah <= 0) {
      print("Jumlah beli tidak valid!");
      continue;
    }

    if (jumlah > barang[index].stok) {
      print("Stok tidak mencukupi!");
      continue;
    }

    barang[index].stok -= jumlah;

    jumlahBeli[index] += jumlah;

    stdout.write("Apakah ingin membeli lagi? (y/n): ");
    String jawaban = stdin.readLineSync()!.toUpperCase();

    if (jawaban == "N") {
      ulang = false;
    }
  }

  int totalBayar = 0;

  print("\n=== Rekapan Belanja ===");

  for (int i = 0; i < barang.length; i++) {
    if (jumlahBeli[i] > 0) {
      int subtotal = jumlahBeli[i] * barang[i].harga;
      totalBayar += subtotal;

      print(
        "- ${barang[i].nama} x${jumlahBeli[i]} = $subtotal",
      );
    }
  }

  print("Total Bayar: $totalBayar");

  print("\nStok tersisa:");

  for (int i = 0; i < barang.length; i++) {
    print("- ${barang[i].nama}: ${barang[i].stok}");
  }
}