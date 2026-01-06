import 'package:flutter/material.dart';
import 'case1.dart';
import 'case2.dart';
import 'case3.dart';

class HomePage extends StatefulWidget{
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MISSION 3',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
      ),

      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              // "Halaman Home ini dapat mengakses 3 case yang telah diberikan, Case 1: Informasi Ultah Teman, Case 2: Informasi Ultah Teman, Case 3: Informasi Ultah Teman",
              "Halaman Home ini dapat mengakses 3 case yang telah disediakan:\n"
                  "Case 1: Sistem Pengingat Ultah\n"
                  "Case 2: Pengelola (harta) digital\n"
                  "Case 3: Detektif kata otomatis",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                ),
              textAlign: TextAlign.center,
              ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });

          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CaseSatu ()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CaseDua()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CaseTiga()),
            );
          }
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.cases_sharp), label: 'Case 1'),
          BottomNavigationBarItem(icon: Icon(Icons.cases_sharp), label: 'Case 2'),
          BottomNavigationBarItem(icon: Icon(Icons.cases_sharp),label: 'Case 3'),
        ],
      ),
    );
  }
}