import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/candi.dart';

class DetailScreen extends StatefulWidget {
  final Candi candi;

  const DetailScreen({super.key, required this.candi});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _bulletText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          const Text('• '),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _numberText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text('• $text'),
    );
  }


  bool isFavorite = false;
  bool isSignedIn = false; // Menyimpan status sign in

  @override
  void initState() {
    super.initState();
    _checkSignInStatus(); // Memeriksa status sign in saat layar dimuat
    _loadFavoriteStatus(); // Memeriksa status favorit saat layar dimuat
  }

  // Memeriksa status sign in
  void _checkSignInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool signedIn = prefs.getBool('isSignedIn') ?? false;
    setState(() {
      isSignedIn = signedIn;
    });
  }

  // Memeriksa status favorit
  void _loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool favorite = prefs.getBool('favorite_${widget.candi.name}') ?? false;
    setState(() {
      isFavorite = favorite;
    });
  }

  Future<void> _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Memeriksa apakah pengguna sudah sign in
    if (!isSignedIn) {
      // Jika belum sign in, arahkan ke SignInScreen
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/signin');
      });
      return;
    }

    bool favoriteStatus = !isFavorite;
    prefs.setBool('favorite_${widget.candi.name}', favoriteStatus);

    setState(() {
      isFavorite = favoriteStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE HEADER
            Stack(
              children: [
                Hero(
                  tag: widget.candi.imageAsset,
                  child: Image.asset(
                    widget.candi.imageAsset,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.4),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),

            // CONTENT
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TITLE
                  Text(
                    widget.candi.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // CATEGORY
                  Row(
                    children: const [
                      Icon(Icons.restaurant_menu, size: 16, color: Colors.blue),
                      SizedBox(width: 6),
                      Text(
                        'Kategori Makanan',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // DESKRIPSI
                  _sectionTitle('Deskripsi'),
                  Text(
                    widget.candi.description,
                    style: const TextStyle(height: 1.5),
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

                  // REKOMENDASI
                  _sectionTitle('Rekomendasi Resep Lain'),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.candi.imageUrls.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 140,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: widget.candi.imageUrls[index],
                                  height: 100,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  'Resep ${index + 1}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
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