import 'package:flutter/material.dart';
import 'package:qr_code_scanner_for_web_and_mobile_apps/scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      )),
      title: 'Qr Code Scanner',
      home: const MyQrCode(),
      debugShowCheckedModeBanner: false,
    );
  }
}
