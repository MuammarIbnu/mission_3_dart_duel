import 'package:flutter/material.dart';

class CaseSatu extends StatelessWidget {
  static const routeName = '/case1';
  const CaseSatu({super.key});


  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> teman = [
      {'nama': 'SBY', 'ultah': '2000-01-15'},
     {'nama': 'Pabowo', 'ultah': '1945-01-20'},
     {'nama': 'Jokowi', 'ultah': null},
     {'nama': 'Hbibi', 'ultah': '1987-03-22'},
    ];

    int tahunSekarang = 2026;
    int bulanSekarang = DateTime.now().month; // bulan sekarang

    List<String> hasil = [];
    int index = 0;

    for (var t in teman) {
      String? ultah = t['ultah'];
      String nama = t['nama'];

      if (ultah == null || ultah.isEmpty) {
        hasil.add("- Data $nama tidak lengkap, dilewati...");
        continue;
      }

      DateTime tanggalUltah = DateTime.parse(ultah);
      if (tanggalUltah.month == bulanSekarang) {
        int umur = tahunSekarang - tanggalUltah.year;
        index++;
        hasil.add("Risers $nama: Wah, lagi ultah nih! Umurnya sekarang $umur tahun.");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Case 1 - Reminder Ulang Tahun"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "DAFTAR ULANG TAHUN BULAN JANUARI:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...hasil.map((h) => Text(h)),
            const Divider(),
            Text("(Total ada $index teman yang harus kamu hubungi!)"),
          ],
        ),
      ),
    );
  }
}


//Logic untuk ditampilkan di terminal -> Slash
// void main() {
//
//   List<Map<String, dynamic>> teman = [
//     {'nama': 'SBY', 'ultah': '2000-01-15'},
//     {'nama': 'Pabowo', 'ultah': '1945-01-20'},
//     {'nama': 'Jokowi', 'ultah': null},
//     {'nama': 'Hbibi', 'ultah': '1987-03-22'},
//   ];
//
//   int bulanSekarang = DateTime.now().month;
//   int tahunSekarang = DateTime.now().year;
//   int index = 0;
//
//   for( var _teman in teman) {
//     String nama = _teman['nama'];
//     String? ultah = _teman['ultah'];
//
//     if (ultah == null || ultah.isEmpty) {
//       print("- Data $nama tidak lengkap, dilewati...");
//       continue;
//     }
//
//     DateTime tanggalUltah = DateTime.parse(ultah);
//     if (tanggalUltah.month == bulanSekarang) {
//       int umur = tahunSekarang - tanggalUltah.year;
//       index++;
//       print("Risers $nama: Wah, lagi ultah nih! Umurnya sekarang $umur tahun.");
//     }
//   }
// }