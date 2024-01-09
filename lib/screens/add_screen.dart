import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

const String _baseURL = 'movieaj.000webhostapp.com';

class AddMoviesPage extends StatefulWidget {
  const AddMoviesPage({Key? key}) : super(key: key);

  @override
  _AddMoviesPageState createState() => _AddMoviesPageState();
}

class _AddMoviesPageState extends State<AddMoviesPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  bool _loading = false;

  final List<Map<String, dynamic>> genresList = [
    {'id': 1, 'name': 'Comedy'},
    {'id': 2, 'name': 'Action'},
    {'id': 3, 'name': 'Murder Mystery'},
    {'id': 4, 'name': 'Romance'},
    {'id': 5, 'name': 'Sci-Fi'},
    {'id': 6, 'name': 'Drama'},
    {'id': 7, 'name': 'Horror'},
    {'id': 8, 'name': 'Fantasy'},
    {'id': 9, 'name': 'Animation'},
    {'id': 10, 'name': 'Adventure'},
    // Add more genres as needed
  ];

  void addMovie(Function(String text) update, String title, double rating,
      String description, String imageUrl, String genre) async {
    try {
      final response = await http
          .post(Uri.parse('http://$_baseURL/addMovie.php'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              }, // turn into JSON
              body: convert.jsonEncode(<String, String>{
                'title': title,
                'rating': rating.toString(),
                'description': description,
                'imageUrl': imageUrl,
                'genre': genre,
                'key': 'your_key'
              }))
          .timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        // if successful, call the update function
        update(response.body);
      }
    } catch (e) {
      update(e.toString());
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    ratingController.dispose();
    descriptionController.dispose();
    imageUrlController.dispose();
    genreController.dispose();
    super.dispose();
  }

  void update(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(18.0),
          color: const Color.fromARGB(250, 20, 38, 77),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Add a Movie:',
                  style: TextStyle(
                      fontSize: 30, fontFamily: 'Rubik', color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: titleController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: ratingController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: 'Rating',
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the rating';
                    }
                    // You can add additional validation logic for rating if needed
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: descriptionController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: imageUrlController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: 'Image URL (.jpg)',
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the image URL (.jpg)';
                    }
                    // You can add additional validation logic for the image URL if needed
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: genreController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: 'Genre ID',
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: false),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the genre ID';
                    }
                    // You can add additional validation logic for the genre if needed
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('Title: ${titleController.text}');
                        print('Rating: ${ratingController.text}');
                        print('Description: ${descriptionController.text}');
                        print('Image URL: ${imageUrlController.text}');
                        print('Genre: ${genreController.text}');
                      }
                      addMovie(
                          update,
                          titleController.text,
                          double.tryParse(ratingController.text) ?? 0.0,
                          descriptionController.text,
                          imageUrlController.text,
                          genreController.text);
                    },
                    icon: const Icon(Icons.add_box_outlined),
                    label: const Text('Add Movie'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 7, 24, 63),
                    ),
                  ),
                ),
                // Display the available genre IDs
                const SizedBox(height: 16),
                const Text(
                  'Available Genre IDs:',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontFamily: 'Rubik',
                  ),
                ),
                  DataTable(
                    columns: const [
                      DataColumn(
                        label: Text(
                          'Genre ID',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Name',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                    rows: genresList
                        .map(
                          (genre) => DataRow(
                        cells: [
                          DataCell(
                            Text(
                              genre['id'].toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          DataCell(
                            Text(
                              genre['name']!,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )
                        .toList(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
