import 'package:flutter/material.dart';
import 'screens/pet_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AdoPet - Adoption de Chiens',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DogListScreen(),
    );
  }
}
