import 'package:flutter/material.dart';

ThemeData theme(){
  return ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0.0
    ),
    useMaterial3: true
  );
}