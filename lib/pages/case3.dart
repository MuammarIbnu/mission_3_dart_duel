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