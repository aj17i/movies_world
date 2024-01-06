import 'package:flutter/material.dart';

class CarouselCard extends StatelessWidget {
  final int index;

  CarouselCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // Set the border radius
      ),
      child: Container(
        width: 100.0, // Card width
        height: 150.0, // Card height
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0), // Adjust the value to change the radius
              child: Image.asset(
                'assets/images/image${index + 1}.jpg',
                height: 130.0,
                width: 200.0,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

