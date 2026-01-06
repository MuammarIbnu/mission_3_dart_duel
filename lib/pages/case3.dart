// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

void main() {
  //Palindrome
  String kata = ("Muammar");
  String kataLowerCase = kata.toLowerCase();
  String terbalik = kataLowerCase.split('').reversed.join('');

  print(kata);
  print(kataLowerCase);
  print(terbalik);

  if (kataLowerCase == terbalik) {
    print('Status Palindrome: IYA!');
  } else {
    print('Status Palindrome: TIDAK!');
  }
  //Huruf Vokal
  List<String> hurufVokal = ['a', 'i', 'u', 'e', 'o'];
  int jumlahVokal = 0;
  for (var huruf in kataLowerCase.split('')) {
    if (hurufVokal.contains(huruf)) {
      jumlahVokal++;
    }
  }
  print('Jumlah Huruf Vokal: $jumlahVokal');
}


// class CaseTiga extends StatelessWidget {
//   static const routeName = '/case3';
//
//   const CaseTiga({super.key});
//
//   @override
//   bool operator ==(Object other) {
//     // TODO: implement ==
//     return super == other;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
