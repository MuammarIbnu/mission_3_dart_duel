import 'package:flutter/material.dart';
// 🚀 BONUS: Menggunakan SharedPreferences untuk persistent storage! Beyond expectation!
import 'package:shared_preferences/shared_preferences.dart';
import '../bankdata/bankaccount.dart';

// ✅ Excellent: Menggunakan StatefulWidget karena ada state yang berubah
// 🌟 AMAZING: Implementasi full banking app dengan login/register system!
class CaseDua extends StatefulWidget {
  // static const routeName = '/case2';
  const CaseDua({super.key});

  @override
  State<CaseDua> createState() => _CaseDuaState();
}

class _CaseDuaState extends State<CaseDua> {
  // ✅ Good: Nullable BankAccount untuk handle state sebelum login
  BankAccount? nasabah;
  // 🌟 GREAT: Menyimpan log aktivitas untuk tracking transaksi
  List<String> logAktivitas = [];

  // ✅ Good: Menggunakan TextEditingController untuk handle input
  final TextEditingController namaController = TextEditingController();
  final TextEditingController saldoController = TextEditingController();
  final TextEditingController jumlahController = TextEditingController();

  // ✅ Good: State management untuk login status
  bool isLogin = false;
  // 🌟 SMART: Flag untuk membedakan login vs register
  bool namaTerdaftar = false;

  // 🔹 Simpan saldo per user
  // 🚀 EXCELLENT: Async function untuk save data dengan SharedPreferences
  // 💡 Tip: Bisa tambahkan error handling try-catch
  Future<void> saveData(String nama, double saldo) async {
    final prefs = await SharedPreferences.getInstance();
    // 🌟 CLEVER: Menggunakan prefix 'saldo_' untuk key multiple users
    await prefs.setDouble('saldo_$nama', saldo);
  }

  // 🔹 Ambil saldo per user
  // ✅ Good: Load data dan update state
  Future<void> loadData(String nama) async {
    final prefs = await SharedPreferences.getInstance();
    double? savedSaldo = prefs.getDouble('saldo_$nama');
    if (savedSaldo != null) {
      setState(() {
        nasabah = BankAccount(nama, savedSaldo);
        isLogin = true;
      });
    }
  }

  // 🌟 SMART: Real-time check apakah nama sudah terdaftar
  // 💡 Tip: Bisa tambahkan debouncing untuk optimasi (tidak call setiap keystroke)
  void checkNama() async {
    String nama = namaController.text.trim();
    if (nama.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    double? savedSaldo = prefs.getDouble('saldo_$nama');

    setState(() {
      namaTerdaftar = savedSaldo != null;
    });
  }

  // ✅ Excellent: Satu function untuk handle register DAN login
  // 🌟 SMART LOGIC: Membedakan berdasarkan apakah data sudah ada atau belum
  void registerOrLogin() async {
    String nama = namaController.text.trim();
    // ✅ Good: Validasi input kosong
    if (nama.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    double? savedSaldo = prefs.getDouble('saldo_$nama');

    if (savedSaldo != null) {
      // login
      // ✅ Good: Reuse loadData function
      await loadData(nama);
    } else {
      // register → saldo wajib diisi
      // ✅ Good: Validasi saldo wajib diisi untuk register
      if (saldoController.text.isEmpty) {
        // ✅ Good: User feedback dengan SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Saldo awal wajib diisi untuk register")),
        );
        return;
      }
      // ✅ Good: Menggunakan tryParse untuk handle invalid input
      // ⚠️ Warning: Default 0 bisa misleading, lebih baik return error
      double saldoAwal = double.tryParse(saldoController.text) ?? 0;
      nasabah = BankAccount(nama, saldoAwal);
      await saveData(nama, saldoAwal);
      setState(() {
        isLogin = true;
      });
    }
  }

  // ✅ Good: Function setor memanggil method dari BankAccount class
  // 🌟 GREAT: Menyimpan log dan persist data ke SharedPreferences
  void setor() async {
    double jumlah = double.tryParse(jumlahController.text) ?? 0;
    // ✅ Good: Null check sebelum akses nasabah
    if (nasabah != null) {
      setState(() {
        // 🌟 EXCELLENT: Menyimpan hasil setor ke log
        logAktivitas.add(nasabah!.setor(jumlah));
      });
      // 🚀 GREAT: Auto-save setelah transaksi
      await saveData(nasabah!.namaPemilik, nasabah!.saldo);
    }
  }

  // ✅ Good: Function tarik memanggil method dari BankAccount class
  void tarik() async {
    double jumlah = double.tryParse(jumlahController.text) ?? 0;
    if (nasabah != null) {
      setState(() {
        // 🌟 EXCELLENT: Menyimpan hasil tarik ke log (termasuk error message)
        logAktivitas.add(nasabah!.tarik(jumlah));
      });
      await saveData(nasabah!.namaPemilik, nasabah!.saldo);
    }
  }

  // 🌟 GREAT: Implement logout untuk clear state
  // ✅ Good: Clear semua state dan controller
  void logout() {
    setState(() {
      isLogin = false;
      nasabah = null;
      logAktivitas.clear();
      namaController.clear();
      saldoController.clear();
      jumlahController.clear();
      namaTerdaftar = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Case 2 - Bank Account"),
        actions: [
          // 🌟 SMART: Conditional logout button hanya muncul saat login
          if (isLogin)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: logout,
            )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // 🌟 EXCELLENT: Conditional rendering berdasarkan isLogin
        child: !isLogin
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Register jika belum memeiliki akun", // ⚠️ Typo: "memeiliki" -> "memiliki"
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text("Cukup gunakan Nama untuk login",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            // ✅ Good: TextField dengan controller
            TextField(
              controller: namaController,
              decoration: InputDecoration(
                  labelText: "Nama",
                  // 🌟 SMART: Dynamic hint text berdasarkan status terdaftar
                  hintText: namaTerdaftar
                    ? "Cukup masukkan nama untuk login"
                    : "Masukkan nama baru untuk register",
                    ),
              // 🌟 GREAT: Real-time check saat user mengetik
              onChanged: (_) => checkNama(),
            ),
            // 🌟 EXCELLENT: Conditional field saldo hanya muncul saat register
            if (!namaTerdaftar)
              TextField(
                controller: saldoController,
                decoration:
                const InputDecoration(
                    labelText: "Saldo Awal",
                    hintText: "Saldo awal wajib diisi untuk register"),
                // ✅ Good: Keyboard type number untuk input angka
                keyboardType: TextInputType.number,
              ),
            const SizedBox(height: 10),
            // 🌟 SMART: Dynamic button text berdasarkan status
            ElevatedButton(
              onPressed: registerOrLogin,
              child: Text(namaTerdaftar ? "Login" : "Register"),
            ),
          ],
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Good: Menampilkan info nasabah
            // ⚠️ Warning: Menggunakan ! operator tanpa additional null check
            Text("Nasabah: ${nasabah!.namaPemilik}",
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            Text("Saldo: Rp${nasabah!.saldo}"),
            // 💡 Tip: Format saldo dengan NumberFormat untuk thousand separator
            const Divider(),
            TextField(
              controller: jumlahController,
              decoration:
              const InputDecoration(labelText: "Jumlah Transaksi"),
              keyboardType: TextInputType.number,
            ),
            // ✅ Good: Button setor dan tarik tersedia
            Row(
              children: [
                ElevatedButton(onPressed: setor, child: const Text("Setor")),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: tarik, child: const Text("Tarik")),
              ],
            ),
            const Divider(),
            const Text("Log Aktivitas:",
                style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            // 🌟 EXCELLENT: Menampilkan semua log aktivitas transaksi
            // 💡 Tip: Bisa dibungkus dengan Expanded + ListView untuk scrollable
            ...logAktivitas.map((log) => Text(log)).toList(),
          ],
        ),
      ),
    );
  }
}