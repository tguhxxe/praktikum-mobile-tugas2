import 'package:flutter/material.dart';

// Impor semua halaman
import 'login.dart'; // Halaman awal baru
import 'signup.dart';
import 'theater_selection_page.dart'; 

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Tiket Bioskop',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1A1A2E), 
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF4C7FFF),
          background: Color(0xFF1A1A2E),
        ),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      
      // Mengubah halaman awal ke Login
      initialRoute: '/login', 
      
      routes: {
        // Halaman Login (Halaman Awal)
        '/login': (context) => LoginPage(),
        
        // Halaman Sign-up
        '/': (context) => const SignUpPage(),
        
        // Halaman Teater
        '/theater_selection': (context) => const TheaterSelectionPage(),
      },
    );
  }
}