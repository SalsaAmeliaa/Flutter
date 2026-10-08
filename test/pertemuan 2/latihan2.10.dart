import 'dart:io';

main() {
    print("apakah kamu cinta coding ?");
    stdout.write("jawab (y/t): ");
    String jawab = stdin.readLineSync()!;

    var hasil = (jawab == 'y')
    ? "Kamu cocok menjadi seorang programmer"
    : "Kamu memiliki ketertarikan di bidang lain";

    print("ok berarti $hasil");
}