import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../reusable_widgets/reusable_widget.dart';

List<FantasyMovie> movies = [];

const String _baseURL = 'movieaj.000webhostapp.com';

class FantasyMovie {
  final String name;
  final double rating;
  final String imageData;
  final String description;

  FantasyMovie(
      {required this.name, required this.rating, required this.imageData, required this.description, });

  factory FantasyMovie.fromJson(Map<String, dynamic> json) {
    return FantasyMovie(
      name: json['title'],
      rating: double.tryParse(json['rating']) ?? 0.0,
      imageData: json['image'],
      description: json['description'],
    );
  }

}

class FantasyPage extends StatefulWidget {
  const FantasyPage({super.key});

  @override
  State<FantasyPage> createState() => _FantasyPageState();
}

class _FantasyPageState extends State<FantasyPage> {
  bool _load = false;

  void update(bool success) {
    setState(() {
      _load = true; // show product list
      if (!success) {
        // API request failed
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('failed to load data')));

      }
    });
  }

  @override
  void initState() {
    // update data when the widget is added to the tree the first tome.
    getMovies(update);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fantasy',
            style: TextStyle(fontSize: 35, fontFamily: 'Rubik')),
        backgroundColor: const Color.fromARGB(255, 42, 7, 63),
        actions: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: Image.asset('assets/images/icons8-fantasy-100.png',
                width: 60, height: 60),
            label: const Text(''),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 42, 7, 63),
            ),
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(250, 63, 15, 91),
        child: Column(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    'Expecto Patronum!',
                    style: TextStyle(
                        fontSize: 30, fontFamily: 'Rubik', color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 0.6, // Adjust this value to control the height
                ),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return MovieContainer(
                    name: movies[index].name,
                    rating: movies[index].rating,
                    imageUrl: movies[index].imageData,
                    description: movies[index].description,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void getMovies(Function(bool success) update) async {
  try {
    final response = await http.post(Uri.parse('http://$_baseURL/fantasy.php?item_id=8'));
    movies.clear();

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        movies.add(FantasyMovie.fromJson(row));
      }
      update(true);
    } else {
      print('HTTP error: ${response.statusCode}');
      print('HTTP response: ${response.body}');
      update(false);
    }
  } catch (e) {
    print('Error: $e');
    update(false);
  }
}

