import 'package:flutter/cupertino.dart';

class BankAccount {
  String namaPemilik;
  double saldo;

  BankAccount(this.namaPemilik, this.saldo);

  String setor(double jumlah) {
    saldo += jumlah;
    return "Setor Rp$jumlah berhasil. Saldo sekarang: Rp$saldo";
  }

  String tarik(double jumlah) {
    if (jumlah > saldo) {
      double kurang = jumlah - saldo;
      return "Gagal! Saldo tidak cukup. Kurang: Rp$kurang";
    } else {
      saldo -= jumlah;
      return "Sukses! Tarik Rp$jumlah. Saldo tersisa: Rp$saldo";
    }
  }
}
