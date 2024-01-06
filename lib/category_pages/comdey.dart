import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../reusable_widgets/reusable_widget.dart';

List<ComedyMovie> movies = [];

const String _baseURL = 'movieaj.000webhostapp.com';

class ComedyMovie {
  final String name;
  final double rating;
  final String imageData;
  final String description;

  ComedyMovie({
    required this.name,
    required this.rating,
    required this.imageData,
    required this.description,
  });

  factory ComedyMovie.fromJson(Map<String, dynamic> json) {
    return ComedyMovie(
      name: json['title'],
      rating: double.tryParse(json['rating']) ?? 0.0,
      imageData: json['image'],
      description: json['description'],
    );
  }
}


class ComedyPage extends StatefulWidget {
  const ComedyPage({super.key});

  @override
  State<ComedyPage> createState() => _ComedyPageState();
}

class _ComedyPageState extends State<ComedyPage> {

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
        title: const Text('Comedy',
            style: TextStyle(fontSize: 35, fontFamily: 'Rubik')),
        backgroundColor: const Color.fromARGB(255, 168, 125, 12),
        actions: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: Image.asset('assets/images/icons8-comedy-100.png',
                width: 50, height: 50),
            label: const Text(''),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 168, 125, 12),
            ),
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(250, 180, 148, 47),
        child: Column(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    'Are you ready to Laugh?!',
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
                  childAspectRatio:
                  0.7, // Adjust this value to control the height
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
    final response =
    await http.post(Uri.parse('http://$_baseURL/fantasy.php?item_id=1'));
    movies.clear();

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        movies.add(ComedyMovie.fromJson(row));
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
