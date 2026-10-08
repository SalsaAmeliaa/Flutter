import 'dart:io';

main(){
  print("=== Login ===");
  stdout.write("password: ");
  String password = stdin.readLineSync()!.trim();

  if(password == "kopi"){
    print("Selamat data bos!");
  } else {
    print("Kamu siapa? Pergi sana!");
  }
}