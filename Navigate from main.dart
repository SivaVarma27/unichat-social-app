import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const UNIchatApp());
}

class UNIchatApp extends StatelessWidget {
  const UNIchatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UNIchat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreen(),
    );
  }
}
