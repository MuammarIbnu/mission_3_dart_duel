import 'package:flutter/material.dart';

// ✅ Good: Menggunakan StatelessWidget karena tidak ada state yang berubah
class CaseTiga extends StatelessWidget {
  // static const routeName = '/case3';
  const CaseTiga({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Good: Ada contoh kata untuk testing palindrome
    // 💡 Tip: Bisa dibuat input TextField agar user bisa test berbagai kata
    String kata = "KodOk";
    // ✅ Excellent: toLowerCase() untuk normalisasi huruf (case-insensitive)
    String kataLowerCase = kata.toLowerCase();
    // ✅ Excellent: Membalikkan kata dengan split, reversed, join - PERFECT!
    // 🌟 GREAT: Cara yang paling idiomatik di Dart!
    String terbalik = kataLowerCase.split('').reversed.join('');

    // ✅ Good: Menggunakan ternary operator untuk pengecekan palindrome
    // 💡 Tip: Variabel bisa lebih deskriptif, misal 'isPalindrome' (bool) lebih baik
    String statusPalindrome =
    (kataLowerCase == terbalik) ? "IYA!" : "TIDAK!";

    // ✅ Excellent: List huruf vokal sudah lengkap dan benar
    List<String> hurufVokal = ['a', 'i', 'u', 'e', 'o'];
    // ✅ Good: Counter untuk jumlah vokal
    int jumlahVokal = 0;
    // ✅ Excellent: Menggunakan for-in loop untuk iterasi setiap huruf
    // ✅ Good: split('') untuk memecah string menjadi list karakter
    for (var huruf in kataLowerCase.split('')) {
      // ✅ Excellent: contains() method untuk cek apakah huruf ada di list vokal
      if (hurufVokal.contains(huruf)) {
        jumlahVokal++;
      }
    }

    // ✅ Good: UI sederhana tapi jelas menampilkan hasil analisis
    return Scaffold(
      appBar: AppBar(title: const Text("Case 3 - Palindrome")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ✅ Good: Menampilkan kata original yang dianalisis
            Text("Analisis Kata: $kata"),
            // ✅ Good: Status palindrome ditampilkan dengan jelas
            Text("Status Palindrome: $statusPalindrome"),
            // ✅ Good: Jumlah vokal ditampilkan
            Text("Jumlah Huruf Vokal: $jumlahVokal"),
            // 💡 Tip: Bisa tambahkan info: "Kata terbalik: $terbalik" untuk edukasi
            // 💡 Tip: Bisa tambahkan styling (fontSize, fontWeight, color)
          ],
        ),
      ),
    );
  }
}


// ✅ Good: Ada alternatif kode untuk running di terminal
//Logic untuk ditampilkan di terminal -> Slash
// void main() {
//   //Palindrome
//   // ✅ Good: Contoh kata palindrome yang valid
//   String kata = ("KodOk");
//   String kataLowerCase = kata.toLowerCase();
//   // ✅ Excellent: Algoritma membalikkan string sudah benar
//   String terbalik = kataLowerCase.split('').reversed.join('');
//
//   print('Analisis Kata: $kata');
//   // print(kataLowerCase);
//   // print(terbalik);
//   // 💡 Tip: Debug print ini bisa diaktifkan untuk development
//
//   // ✅ Good: if-else untuk pengecekan palindrome
//   if (kataLowerCase == terbalik) {
//     print('Status Palindrome: IYA!');
//   } else {
//     print('Status Palindrome: TIDAK!');
//   }
//   //Huruf Vokal
//   // ✅ Excellent: Logic penghitungan vokal sama dengan di Widget
//   List<String> hurufVokal = ['a', 'i', 'u', 'e', 'o'];
//   int jumlahVokal = 0;
//   for (var huruf in kataLowerCase.split('')) {
//     if (hurufVokal.contains(huruf)) {
//       jumlahVokal++;
//     }
//   }
//   print('Jumlah Huruf Vokal: $jumlahVokal');
// }
