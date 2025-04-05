import 'package:flutter/material.dart';

final myTheme = ThemeData(
// Colori primari e di accento
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.greenAccent[400] ?? Colors.greenAccent,
    primary: Colors.greenAccent[400] ?? Colors.greenAccent,
    secondary: Colors.deepPurple[900] ?? Colors.deepPurple,
    background: Colors.deepPurple[50] ?? Colors.grey[100],
  ),

// Appbar
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.white,
    centerTitle: true,
    elevation: 0,
  ),

// Floating Action Button
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.greenAccent[400],
    foregroundColor: Colors.black87,
  ),

// Card
  cardTheme: CardTheme(
    color: Colors.deepPurple[900],
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),

// Lista
  listTileTheme: ListTileThemeData(
    tileColor: Colors.transparent,
    textColor: Colors.greenAccent[400],
    iconColor: Colors.greenAccent[400],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
      side: BorderSide(
          color: Colors.greenAccent[400] ?? Colors.greenAccent,
          width: 3),
    ),
  ),

// Pulsanti
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.greenAccent[400],
      foregroundColor: Colors.black87,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
    ),
  ),

// Input
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
          color: Colors.deepPurple[200] ?? Colors.deepPurple),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
          color: Colors.greenAccent[400] ?? Colors.greenAccent, width: 2),
    ),
  ),

// Testo
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontWeight: FontWeight.bold),
  ),

// Scaffolds
  scaffoldBackgroundColor: Colors.deepPurple[900] ?? Colors.deepPurple,
);