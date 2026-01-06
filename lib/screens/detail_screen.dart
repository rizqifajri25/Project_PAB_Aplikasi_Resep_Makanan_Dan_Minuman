import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/menu.dart';
import '../data/menu_data.dart'; // 🔹 tambahan untuk rekomendasi

class DetailScreen extends StatefulWidget {
  final Menu menu;

  const DetailScreen({super.key, required this.menu});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false;
  bool isSignedIn = false;

  @override
  void initState() {
    super.initState();
    _checkSignInStatus();
    _loadFavoriteStatus();
  }

  // ================= SIGN IN CHECK =================
  void _checkSignInStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isSignedIn = prefs.getBool('isSignedIn') ?? false;
    });
  }

  // ================= LOAD FAVORITE =================
  void _loadFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];

    setState(() {
      isFavorite = favorites.contains(widget.menu.nama);
    });
  }

  // ================= TOGGLE FAVORITE =================
  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();

    if (!isSignedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/signin');
      });
      return;
    }

    List<String> favorites = prefs.getStringList('favorites') ?? [];

    setState(() {
      if (favorites.contains(widget.menu.nama)) {
        favorites.remove(widget.menu.nama);
        isFavorite = false;
      } else {
        favorites.add(widget.menu.nama);
        isFavorite = true;
      }
      prefs.setStringList('favorites', favorites);
    });
  }

  // ================= UI HELPER =================
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _bulletText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: Theme.of(context).textTheme.bodyMedium),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _numberText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        '• $text',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  // ================= BUILD =================
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= IMAGE HEADER =================
            Stack(
              children: [
                Hero(
                  tag: widget.menu.imageAsset,
                  child: Image.asset(
                    widget.menu.imageAsset,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.5),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.5),
                    child: IconButton(
                      icon: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.redAccent,
                      ),
                      onPressed: _toggleFavorite,
                    ),
                  ),
                ),
              ],
            ),

            // ================= CONTENT =================
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TITLE
                  Text(
                    widget.menu.nama,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  // CATEGORY
                  Row(
                    children: [
                      Icon(Icons.restaurant_menu,
                          size: 16, color: colorScheme.primary),
                      const SizedBox(width: 6),
                      Text(
                        'Kategori Makanan',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // DESKRIPSI
                  _sectionTitle('Deskripsi'),
                  Text(
                    widget.menu.deskripsi,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(height: 1.5),
                  ),

                  const SizedBox(height: 20),

                  // BAHAN
                  _sectionTitle('Bahan'),
                  _bulletText('2 piring nasi putih'),
                  _bulletText('2 siung bawang putih'),
                  _bulletText('1 butir telur'),
                  _bulletText('Kecap secukupnya'),

                  const SizedBox(height: 20),

                  // CARA MEMBUAT
                  _sectionTitle('Cara Membuat'),
                  _numberText('Panaskan minyak dan tumis bawang'),
                  _numberText('Masukkan telur dan aduk'),
                  _numberText('Masukkan nasi dan kecap'),
                  _numberText('Aduk hingga matang'),

                  const SizedBox(height: 20),

                  // ================= REKOMENDASI =================
                  _sectionTitle('Rekomendasi Resep Lain'),
                  const SizedBox(height: 10),

                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: menuList
                          .where(
                              (menu) => menu.nama != widget.menu.nama)
                          .length,
                      itemBuilder: (context, index) {
                        final rekomendasiMenu = menuList
                            .where((menu) =>
                        menu.nama != widget.menu.nama)
                            .toList()[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    DetailScreen(menu: rekomendasiMenu),
                              ),
                            );
                          },
                          child: Container(
                            width: 140,
                            margin:
                            const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: colorScheme.surface,
                              borderRadius:
                              BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .shadowColor,
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius:
                                  const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                  child: Image.asset(
                                    rekomendasiMenu.imageAsset,
                                    height: 100,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.all(8),
                                  child: Text(
                                    rekomendasiMenu.nama,
                                    maxLines: 2,
                                    overflow:
                                    TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                        fontWeight:
                                        FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
