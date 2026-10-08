import 'dart:io';

main(){
  stdout.write("jumlah perulangan: ");
  int n = int.parse(stdin.readLineSync()!);

  for(int i = 1; i <= n; i++) {
    print("Perulangan ke-$i");
  }
}