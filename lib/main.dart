import 'package:flutter/material.dart';
import 'package:movies_world/screens/signin_screen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Infinite Scrolling',
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}
