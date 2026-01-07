import 'package:flutter/material.dart';

class CaseTiga extends StatelessWidget {
  // static const routeName = '/case3';
  const CaseTiga({super.key});

  @override
  Widget build(BuildContext context) {
    String kata = "KodOk";
    String kataLowerCase = kata.toLowerCase();
    String terbalik = kataLowerCase.split('').reversed.join('');

    String statusPalindrome =
    (kataLowerCase == terbalik) ? "IYA!" : "TIDAK!";

    List<String> hurufVokal = ['a', 'i', 'u', 'e', 'o'];
    int jumlahVokal = 0;
    for (var huruf in kataLowerCase.split('')) {
      if (hurufVokal.contains(huruf)) {
        jumlahVokal++;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Case 3 - Palindrome")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Analisis Kata: $kata"),
            Text("Status Palindrome: $statusPalindrome"),
            Text("Jumlah Huruf Vokal: $jumlahVokal"),
          ],
        ),
      ),
    );
  }
}


// //Logic untuk ditampilkan di terminal -> Slash
// void main() {
//   //Palindrome
//   String kata = ("KodOk");
//   String kataLowerCase = kata.toLowerCase();
//   String terbalik = kataLowerCase.split('').reversed.join('');
//
//   print('Analisis Kata: $kata');
//   // print(kataLowerCase);
//   // print(terbalik);
//
//   if (kataLowerCase == terbalik) {
//     print('Status Palindrome: IYA!');
//   } else {
//     print('Status Palindrome: TIDAK!');
//   }
//   //Huruf Vokal
//   List<String> hurufVokal = ['a', 'i', 'u', 'e', 'o'];
//   int jumlahVokal = 0;
//   for (var huruf in kataLowerCase.split('')) {
//     if (hurufVokal.contains(huruf)) {
//       jumlahVokal++;
//     }
//   }
//   print('Jumlah Huruf Vokal: $jumlahVokal');
// }
