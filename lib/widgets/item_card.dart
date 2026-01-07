import 'package:flutter/material.dart';
import 'package:Cook.in/models/menu.dart';
import 'package:Cook.in/screens/detail_screen.dart';

class ItemCard extends StatelessWidget {
//   TODO: 1. Deklarasikan variabel yang dibutuhkan dan pasang pada konstruktor
  final Menu menu;

  const ItemCard({
    super.key,
    required this.menu,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: 6. Implementasi routing ke DetailScreen
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(menu: menu),
          ),
        );
      },
      child: Card(
        //   TODO: 2. Tetapkan parameter shape, margin, dan elevation dari Cari
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(4),
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //   TODO: 3. Buat Image sebagai anak dari Column
            Expanded(
              child: Hero(
                tag: menu.nama, // HARUS SAMA DENGAN DETAIL SCREEN
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    menu.imageAsset,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            //   TODO: 4. Buat Text sebagai anak dari Column
            Padding(
              padding: EdgeInsets.only(left: 16, top: 8),
              child: Text(menu.nama,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //   TODO: 5. Buat Text sebagai anak dari Column
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 8),
              child: Text(menu.tipe,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}