import 'package:avinutri/screens/main_page.dart';
import 'package:flutter/material.dart';

// import 'package:avinutri/screens/login_screen.dart';


void main()
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(), 
    );
  }
}