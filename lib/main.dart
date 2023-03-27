import 'package:flutter/material.dart';
import 'package:todo_list/screen/main_screen.dart';
import 'package:todo_list/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: MainScreen()
    );
  }
}
