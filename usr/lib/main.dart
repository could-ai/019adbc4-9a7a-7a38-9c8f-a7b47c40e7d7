import 'package:flutter/material.dart';
import 'presentation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proiect Arabia Saudita',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Folosim culori stridente pentru a imita stilul unui copil
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Courier', // Un font mai "brut"
      ),
      home: const SaudiPresentation(),
    );
  }
}
