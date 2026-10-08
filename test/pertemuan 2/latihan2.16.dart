import 'dart:io';

int luasPersegi(int sisi) {
  return sisi * sisi;
}

main () {
  print("--- Program luas persegi ---");
  stdout.write("Input panjang sisi: ");
  int s = int.parse(stdin.readLineSync()!);

  int hasil = luasPersegi(s);

  print("Luas: $hasil");
}