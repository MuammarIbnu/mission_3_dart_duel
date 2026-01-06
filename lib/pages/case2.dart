import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bankdata/bankaccount.dart';

class CaseDua extends StatefulWidget {
  static const routeName = '/case2';

  const CaseDua({super.key});

  @override
  State<CaseDua> createState() => _CaseDuaState();
}

class _CaseDuaState extends State<CaseDua> {
  BankAccount? nasabah;
  List<String> logAktivitas = [];

  final TextEditingController namaController = TextEditingController();
  final TextEditingController saldoController = TextEditingController();
  final TextEditingController jumlahController = TextEditingController();

  bool isLogin = false;
  bool namaTerdaftar = false;

  // 🔹 Simpan saldo per user
  Future<void> saveData(String nama, double saldo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('saldo_$nama', saldo);
  }

  // 🔹 Ambil saldo per user
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

  void checkNama() async {
    String nama = namaController.text.trim();
    if (nama.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    double? savedSaldo = prefs.getDouble('saldo_$nama');

    setState(() {
      namaTerdaftar = savedSaldo != null;
    });
  }

  void registerOrLogin() async {
    String nama = namaController.text.trim();
    if (nama.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    double? savedSaldo = prefs.getDouble('saldo_$nama');

    if (savedSaldo != null) {
      // login
      await loadData(nama);
    } else {
      // register → saldo wajib diisi
      if (saldoController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Saldo awal wajib diisi untuk register")),
        );
        return;
      }
      double saldoAwal = double.tryParse(saldoController.text) ?? 0;
      nasabah = BankAccount(nama, saldoAwal);
      await saveData(nama, saldoAwal);
      setState(() {
        isLogin = true;
      });
    }
  }

  void setor() async {
    double jumlah = double.tryParse(jumlahController.text) ?? 0;
    if (nasabah != null) {
      setState(() {
        logAktivitas.add(nasabah!.setor(jumlah));
      });
      await saveData(nasabah!.namaPemilik, nasabah!.saldo);
    }
  }

  void tarik() async {
    double jumlah = double.tryParse(jumlahController.text) ?? 0;
    if (nasabah != null) {
      setState(() {
        logAktivitas.add(nasabah!.tarik(jumlah));
      });
      await saveData(nasabah!.namaPemilik, nasabah!.saldo);
    }
  }

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
          if (isLogin)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: logout,
            )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: !isLogin
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Register jika belum memeiliki akun",
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
            TextField(
              controller: namaController,
              decoration: InputDecoration(
                  labelText: "Nama",
                  hintText: namaTerdaftar
                    ? "Cukup masukkan nama untuk login"
                    : "Masukkan nama baru untuk register",
                    ),
              onChanged: (_) => checkNama(),
            ),
            if (!namaTerdaftar)
              TextField(
                controller: saldoController,
                decoration:
                const InputDecoration(
                    labelText: "Saldo Awal",
                    hintText: "Saldo awal wajib diisi untuk register"),
                keyboardType: TextInputType.number,
              ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: registerOrLogin,
              child: Text(namaTerdaftar ? "Login" : "Register"),
            ),
          ],
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nasabah: ${nasabah!.namaPemilik}",
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            Text("Saldo: Rp${nasabah!.saldo}"),
            const Divider(),
            TextField(
              controller: jumlahController,
              decoration:
              const InputDecoration(labelText: "Jumlah Transaksi"),
              keyboardType: TextInputType.number,
            ),
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
            ...logAktivitas.map((log) => Text(log)).toList(),
          ],
        ),
      ),
    );
  }
}