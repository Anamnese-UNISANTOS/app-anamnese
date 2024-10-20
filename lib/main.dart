import 'package:flutter/material.dart';
import 'boasvindas_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PCG Anamnese",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BoasVindasPage(),
    );
  }
}
