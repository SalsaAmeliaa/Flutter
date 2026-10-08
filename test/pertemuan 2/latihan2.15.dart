import 'dart:io';

void main() {
  var languages = List.filled(5, "");

  print("Sebutkan ${languages.length} bahasa yang ingin kamu pelajari!");

  for (int i = 0; i < languages.length; i++) {
    stdout.write("$i. ");
    languages[i] = stdin.readLineSync() ?? "";
  }

  print(languages);
}