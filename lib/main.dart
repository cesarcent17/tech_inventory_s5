import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tech_inventory/pages/tech_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const MaterialColor uisraelBlue = MaterialColor(
    0xFF003366,
    <int, Color>{
      50: Color(0xFFE6EAF2),
      100: Color(0xFFB9C5DD),
      200: Color(0xFF8BA0C8),
      300: Color(0xFF5D7BC3),
      400: Color(0xFF3458B7),
      500: Color(0xFF0033AB),
      600: Color(0xFF00309F),
      700: Color(0xFF002E91),
      800: Color(0xFF002B85),
      900: Color(0xFF001F65),
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inventario Tecnología - César Centurión 7A',
      theme: ThemeData(
        primarySwatch: uisraelBlue,
        scaffoldBackgroundColor: Colors.white,

        appBarTheme: const AppBarTheme(
          backgroundColor: uisraelBlue,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: uisraelBlue,
          foregroundColor: Colors.white,
        ),

        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),

      home: TechListPage(), // ✔ corregido, sin const
    );
  }
}
