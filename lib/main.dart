import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Cook.in/screens/home_screen.dart';
import 'package:Cook.in/screens/main_screen.dart';
import 'package:Cook.in/screens/signInscreen.dart';
import 'package:Cook.in/screens/signUpscreen.dart';

import 'theme/app_theme.dart';
import 'theme/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return AnimatedTheme(
      data: themeProvider.isDarkMode
          ? AppTheme.darkTheme
          : AppTheme.lightTheme,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cook.In',

        // 🔥 Theme global
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeProvider.themeMode,

        home: const MainScreen(),

        initialRoute: '/',
        routes: {
          '/homescreen': (context) => const HomeScreen(),
          '/signin': (context) => const SignInScreen(),
          '/signup': (context) => const SignUpScreen(),
        },
      ),
    );
  }
}
