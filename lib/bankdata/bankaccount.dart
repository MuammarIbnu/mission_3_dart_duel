// ⚠️ Warning: Import tidak digunakan! cupertino.dart tidak diperlukan di file ini
import 'package:flutter/cupertino.dart';

// ✅ Excellent: Class BankAccount sudah dibuat sesuai requirement!
// 💡 Tip: Bisa tambahkan docstring untuk dokumentasi class
class BankAccount {
  // ✅ Good: Property namaPemilik dan saldo sudah ada dengan tipe data yang tepat
  // ⚠️ Warning: Property tidak final, bisa diubah dari luar class (encapsulation issue)
  // 💡 Tip: Pertimbangkan untuk membuat saldo private (_saldo) dan tambahkan getter
  String namaPemilik;
  double saldo;

  // ✅ Excellent: Constructor positional sudah benar dan ringkas!
  // 💡 Tip: Bisa tambahkan validasi saldo awal tidak boleh negatif
  BankAccount(this.namaPemilik, this.saldo);

  // ✅ Excellent: Fungsi setor sudah benar dan mengembalikan String message
  // ⚠️ Warning: Tidak ada validasi jumlah setor (bisa negative atau 0)
  // 💡 Tip: Tambahkan check: if (jumlah <= 0) return "Jumlah harus lebih dari 0"
  String setor(double jumlah) {
    saldo += jumlah;
    // 🤔 Question: Format currency bisa lebih baik dengan NumberFormat atau thousand separator
    return "Setor Rp$jumlah berhasil. Saldo sekarang: Rp$saldo";
  }

  // ✅ Excellent: Fungsi tarik sudah implementasi if-else dengan benar!
  // ✅ Good: Logika pengecekan saldo sudah sesuai requirement
  // ✅ Good: Pesan error dan sukses sudah informatif
  String tarik(double jumlah) {
    // ⚠️ Warning: Tidak ada validasi jumlah tarik (bisa negative atau 0)
    if (jumlah > saldo) {
      double kurang = jumlah - saldo;
      // ✅ Good: Menampilkan berapa kekurangannya, very helpful!
      return "Gagal! Saldo tidak cukup. Kurang: Rp$kurang";
    } else {
      saldo -= jumlah;
      // ✅ Good: Message sukses menampilkan jumlah dan sisa saldo
      return "Sukses! Tarik Rp$jumlah. Saldo tersisa: Rp$saldo";
    }
  }
}
