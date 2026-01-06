import 'package:flutter/material.dart';

class CaseSatu extends StatelessWidget {
  static const routeName = '/case1';
  const CaseSatu({super.key});


  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> teman = [
      {'nama': 'Muammar', 'ultah': '2000-01-15'},
      {'nama': 'Ibnu', 'ultah': '1945-01-20'},
      {'nama': 'Jokowi', 'ultah': null},
    ];

    int tahunSekarang = 2026;
    int bulanSekarang = DateTime.now().month; // bulan sekarang

    List<String> hasil = [];
    int total = 0;

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
        total++;
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
            ...hasil.map((h) => Text(h)).toList(),
            const Divider(),
            Text("(Total ada $total teman yang harus kamu hubungi!)"),
          ],
        ),
      ),
    );
  }
}