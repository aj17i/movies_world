import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final String categoryId;

  const CategoryCard({super.key, required this.categoryName, required this.categoryId});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          // handle category selection
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              categoryName,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              categoryId,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}