import 'package:flutter/material.dart';
import '../models/dog.dart';
import '../models/owner.dart';
import '../widgets/dog_card.dart';
import 'pet_detail_screen.dart';

class DogListScreen extends StatelessWidget {
  final List<Dog> dogs = [
    Dog(
      id: 1,
      name: 'Rex',
      age: 3,
      gender: 'Male',
      color: 'Brown',
      weight: 15.0,
      location: 'Paris',
      image: 'assets/blue_dog.png',
      about: 'Rex is a friendly dog looking for a loving home.',
      owner: Owner(
          name: 'John Doe',
          bio: 'Loves animals and is an advocate for adoption.',
          image: 'assets/owner.png'),
    ),
    Dog(
      id: 2,
      name: 'Bella',
      age: 4,
      gender: 'Female',
      color: 'White',
      weight: 12.0,
      location: 'Lyon',
      image: 'assets/white_dog.png',
      about: 'Bella is a sweet dog looking for a new family.',
      owner: Owner(
          name: 'Alice Smith',
          bio: 'Passionate about animals, especially dogs.',
          image: 'assets/owner.png'),
    ),
    Dog(
      id: 3,
      name: 'Max',
      age: 3,
      gender: 'Male',
      color: 'Brown',
      weight: 15.0,
      location: 'Paris',
      image: 'assets/red_dog.png',
      about: 'Max is very playful and loves outdoor activities.',
      owner: Owner(
        name: 'John Doe',
        bio: 'A dog lover and outdoor enthusiast.',
        image: 'assets/owner.png',
      ),
    ),
    Dog(
      id: 4,
      name: 'Lucy',
      age: 2,
      gender: 'Female',
      color: 'Black',
      weight: 10.0,
      location: 'Marseille',
      image: 'assets/yellow_dog.png',
      about: 'Lucy is a friendly dog who enjoys meeting new people.',
      owner: Owner(
        name: 'Emma Brown',
        bio: 'Loves traveling and bringing Lucy on adventures.',
        image: 'assets/owner.png',
      ),
    ),
    Dog(
      id: 5,
      name: 'Charlie',
      age: 5,
      gender: 'Male',
      color: 'Golden',
      weight: 20.0,
      location: 'Nice',
      image: 'assets/orange_dog.png',
      about: 'Charlie is calm and enjoys relaxing by the beach.',
      owner: Owner(
        name: 'Lucas Green',
        bio: 'A peaceful person who enjoys time by the sea with Charlie.',
        image: 'assets/owner.png',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chiens disponibles à l\'adoption'),
      ),
      body: ListView.builder(
        itemCount: dogs.length,
        itemBuilder: (context, index) {
          return DogCard(
              dog: dogs[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PetProfileScreen(dog: dogs[index]),
                  ),
                );
              });
        },
      ),
    );
  }
}
