import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'favorite_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';
import '../theme/theme_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const HomeScreen(),
    const SearchScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Cook.In'),
        actions: [
          Switch(
            value: themeProvider.isDarkMode,
            onChanged: themeProvider.toggleTheme,
          ),
        ],
      ),

      // ❌ TIDAK DIUBAH
      body: _children[_currentIndex],

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
