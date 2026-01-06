import 'package:flutter/material.dart';
import '../models/menu.dart';
import '../data/menu_data.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String query = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // FILTER MENU BERDASARKAN NAMA
    final List<Menu> filteredMenus = menuList.where((menu) {
      return menu.nama.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: colorScheme.background,

      body: Column(
        children: [
          // HEADER
          Container(
            height: 55,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: colorScheme.onPrimary),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'SEARCH',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),

          // SEARCH FIELD
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Cari Resep',
                  prefixIcon: Icon(
                    Icons.search,
                    color: colorScheme.onSurface.withOpacity(0.7),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          // HASIL SEARCH
          Expanded(
            child: query.isEmpty
                ? const SizedBox()
                : filteredMenus.isEmpty
                ? Center(
              child: Text(
                'Resep tidak ditemukan',
                style: theme.textTheme.bodyMedium,
              ),
            )
                : ListView.builder(
              itemCount: filteredMenus.length,
              itemBuilder: (context, index) {
                final menu = filteredMenus[index];

                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      menu.imageAsset,
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: _highlightText(menu.nama, query, theme),
                  subtitle: Text(
                    menu.tipe,
                    style: theme.textTheme.bodySmall,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(menu: menu),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _highlightText(String text, String query, ThemeData theme) {
    if (query.isEmpty) {
      return Text(text, style: theme.textTheme.bodyMedium);
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();

    final startIndex = lowerText.indexOf(lowerQuery);
    if (startIndex == -1) {
      return Text(text, style: theme.textTheme.bodyMedium);
    }

    final endIndex = startIndex + query.length;

    return RichText(
      text: TextSpan(
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onBackground,
        ),
        children: [
          TextSpan(text: text.substring(0, startIndex)),
          TextSpan(
            text: text.substring(startIndex, endIndex),
            style: const TextStyle(
              backgroundColor: Colors.yellow,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(text: text.substring(endIndex)),
        ],
      ),
    );
  }
}
