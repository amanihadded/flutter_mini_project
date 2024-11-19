import 'package:flutter/material.dart';
import '../models/dog.dart';

class DogCard extends StatelessWidget {
  final Dog dog;
  final VoidCallback onTap;

  const DogCard({required this.dog, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            Image.asset(
              dog.image,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dog.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 4),
                  Text('${dog.age} | ${dog.color}',
                      style: TextStyle(fontSize: 14)),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on),
                      Text(dog.location),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: dog.gender == 'Male'
                        ? Colors.blue[100]
                        : Colors.pink[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(dog.gender,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 8),
                Text('Just now'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
