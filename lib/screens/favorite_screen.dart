import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/menu_data.dart';
import '../models/menu.dart';
import 'detail_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Menu> favoriteMenus = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteNames = prefs.getStringList('favorites') ?? [];

    setState(() {
      favoriteMenus = menuList
          .where((menu) => favoriteNames.contains(menu.nama))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: favoriteMenus.isEmpty
          ? Center(
        child: Text(
          'Belum Ada Makanan Favorit',
          style: theme.textTheme.bodyMedium,
        ),
      )
          : ListView.builder(
        itemCount: favoriteMenus.length,
        itemBuilder: (context, index) {
          final menu = favoriteMenus[index];

          return Card(
            margin:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  menu.imageAsset,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(menu.nama),
              subtitle: Text(menu.deskripsi,
                  maxLines: 1, overflow: TextOverflow.ellipsis),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailScreen(menu: menu),
                  ),
                );
                _loadFavorites();
              },
            ),
          );
        },
      ),
    );
  }
}
