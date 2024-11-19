import 'package:flutter/material.dart';
import '../models/dog.dart';

class PetProfileScreen extends StatelessWidget {
  final Dog dog;

  const PetProfileScreen({required this.dog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dog.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Image.asset(dog.image),
            SizedBox(height: 16),
            Text(
              'About me',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(dog.about),
            SizedBox(height: 24),
            Text(
              'Owner: ${dog.owner.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Image.asset(dog.owner.image),
            SizedBox(height: 8),
            Text(dog.owner.bio),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Logique pour contacter le propriétaire, si nécessaire
                },
                child: Text('Contact Owner'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
