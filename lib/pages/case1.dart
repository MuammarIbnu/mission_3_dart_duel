import 'package:flutter/material.dart';

// ✅ Good: Sudah menggunakan StatelessWidget karena tidak ada state yang berubah
class CaseSatu extends StatelessWidget {
  static const routeName = '/case1';
  const CaseSatu({super.key});


  @override
  Widget build(BuildContext context) {
    // ✅ Good: Struktur data sudah sesuai - List<Map<String, dynamic>>
    // ✅ Good: Sudah ada data dengan nilai null untuk testing null safety
    // 💡 Tip: Nama variabel bisa lebih deskriptif, misal 'daftarTeman' atau 'temanList'
    List<Map<String, dynamic>> teman = [
      {'nama': 'SBY', 'ultah': '2000-01-15'},
     {'nama': 'Pabowo', 'ultah': '1945-01-20'}, // ⚠️ Warning: Indentasi tidak konsisten (spasi awal kurang)
     {'nama': 'Jokowi', 'ultah': null}, // ✅ Good: Ada data null untuk testing
     {'nama': 'Hbibi', 'ultah': '1987-03-22'},
    ];

    // ⚠️ CRITICAL BUG: Hardcoded tahun 2026! Seharusnya DateTime.now().year
    // ❌ Bug: Jika running di tahun lain, umur akan salah!
    int tahunSekarang = 2026;
    // ✅ Good: Menggunakan DateTime.now().month untuk mendapatkan bulan sekarang
    int bulanSekarang = DateTime.now().month; // bulan sekarang

    // 💡 Tip: Variabel 'hasil' bisa diberi nama lebih deskriptif seperti 'hasilPesan' atau 'pesanHasil'
    List<String> hasil = [];
    // 🤔 Question: Variabel 'index' hanya digunakan untuk counter, bisa diberi nama 'jumlahUltah' atau 'counterUltah'
    int index = 0;

    // ✅ Good: Menggunakan for-in loop untuk iterasi
    for (var t in teman) {
      // 💡 Tip: Variabel 't' terlalu singkat, lebih baik 'dataTeman' atau 'teman' (singular)
      String? ultah = t['ultah'];
      String nama = t['nama'];

      // ✅ Excellent: Null safety check sudah benar!
      // ✅ Good: Menggunakan continue untuk skip data yang tidak lengkap
      if (ultah == null || ultah.isEmpty) {
        hasil.add("- Data $nama tidak lengkap, dilewati...");
        continue;
      }

      // ✅ Good: Menggunakan DateTime.parse untuk parsing string tanggal
      // ⚠️ Warning: Tidak ada try-catch untuk handle format tanggal yang salah
      DateTime tanggalUltah = DateTime.parse(ultah);
      // ✅ Good: Pengecekan bulan ultah dengan bulan sekarang sudah benar
      if (tanggalUltah.month == bulanSekarang) {
        // ⚠️ Bug: Perhitungan umur tidak akurat! Tidak memperhitungkan tanggal.
        // Jika ultah belum lewat di bulan ini, seharusnya umur - 1
        int umur = tahunSekarang - tanggalUltah.year;
        index++;
        // ✅ Good: Message output sudah cukup informatif
        hasil.add("Risers $nama: Wah, lagi ultah nih! Umurnya sekarang $umur tahun.");
      }
    }

    // ✅ Good: UI sudah diimplementasikan dengan baik menggunakan Scaffold
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
              // 🤔 Question: Hardcoded "JANUARI" - sebaiknya dynamic berdasarkan bulan sekarang
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // ✅ Good: Menggunakan spread operator untuk menampilkan list hasil
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
// ✅ Good: Ada kode alternatif untuk running di terminal
// 💡 Tip: Kode ini bisa dipisah ke file terpisah atau dibuat sebagai fungsi reusable
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
//   // ✅ Good: Di sini sudah menggunakan DateTime.now().year (konsisten!)
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