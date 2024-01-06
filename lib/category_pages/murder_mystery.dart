import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../reusable_widgets/reusable_widget.dart';

List<MurderMysteryMovie> movies = [];

const String _baseURL = 'movieaj.000webhostapp.com';

class MurderMysteryMovie {
  final String name;
  final double rating;
  final String imageData;
  final String description;

  MurderMysteryMovie({
    required this.name,
    required this.rating,
    required this.imageData,
    required this.description,
  });

  factory MurderMysteryMovie.fromJson(Map<String, dynamic> json) {
    return MurderMysteryMovie(
      name: json['title'],
      rating: double.tryParse(json['rating']) ?? 0.0,
      imageData: json['image'],
      description: json['description'],
    );
  }
}


class MurderMysteryPage extends StatefulWidget {
  const MurderMysteryPage({super.key});

  @override
  State<MurderMysteryPage> createState() => _MurderMysteryPageState();
}

class _MurderMysteryPageState extends State<MurderMysteryPage> {

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
        title: const Text('Murder-Mystery',
            style: TextStyle(fontSize: 22, fontFamily: 'Rubik')),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        actions: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: Image.asset('assets/images/icons8-murder-64.png', width: 43, height: 60),
            label: const Text(''),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(200, 0, 0, 0),
        child: Column(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    'Are you ready for the Thrill?!',
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
    await http.post(Uri.parse('http://$_baseURL/fantasy.php?item_id=3'));
    movies.clear();

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        movies.add(MurderMysteryMovie.fromJson(row));
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