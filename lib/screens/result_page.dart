import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../reusable_widgets/reusable_widget.dart';

const String _baseURL = 'movieaj.000webhostapp.com';

class ResultPage extends StatefulWidget {
  final String searchQuery;

  const ResultPage({Key? key, required this.searchQuery}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool _load = false;
  List<ResultMovie> searchResults = [];

  @override
  void initState() {
    super.initState();
    getMovies(widget.searchQuery);
  }

  void getMovies(String query) async {
    try {
      final response = await http.post(
        Uri.https(_baseURL, 'search_movies.php'),
        body: {'query': query},
      );
      searchResults.clear();

      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        for (var row in jsonResponse) {
          searchResults.add(ResultMovie.fromJson(row));
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

  void update(bool success) {
    setState(() {
      _load = true; // show product list
      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load data')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Results',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Rubik',
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 7, 24, 63),
      ),
      body: Container(
        color: const Color.fromARGB(250, 20, 38, 77),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              const SizedBox(height: 16.0),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio:
                        0.7,
                  ),
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    return MovieContainer(
                      name: searchResults[index].name,
                      rating: searchResults[index].rating,
                      imageUrl: searchResults[index].imageData,
                      description: searchResults[index].description,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultMovie {
  final String name;
  final double rating;
  final String imageData;
  final String description;

  ResultMovie({
    required this.name,
    required this.rating,
    required this.imageData,
    required this.description,
  });

  factory ResultMovie.fromJson(Map<String, dynamic> json) {
    return ResultMovie(
      name: json['title'],
      rating: double.tryParse(json['rating']) ?? 0.0,
      imageData: json['image'],
      description: json['description'],
    );
  }
}
