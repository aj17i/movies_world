import 'package:flutter/material.dart';
import 'package:movies_world/category_pages/action.dart';
import 'package:movies_world/category_pages/adventure.dart';
import 'package:movies_world/category_pages/animation.dart';
import 'package:movies_world/category_pages/comdey.dart';
import 'package:movies_world/category_pages/drama.dart';
import 'package:movies_world/category_pages/fantasy.dart';
import 'package:movies_world/category_pages/horror.dart';
import 'package:movies_world/category_pages/murder_mystery.dart';
import 'package:movies_world/category_pages/romance.dart';
import 'package:movies_world/category_pages/sci_fi.dart';
import 'package:movies_world/screens/profile_screen.dart';
import 'package:movies_world/screens/result_page.dart';
import '../horizontal_carousel.dart';

const String _baseURL = 'movieaj.000webhostapp.com';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPage = 0;
  List<String> categories = [
    'Action',
    'Adventure',
    'Animation',
    'Comedy',
    'Drama',
    'Fantasy',
    'Horror',
    'Murder Mystery',
    'Romance',
    'Sci-Fi',
  ];

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Movies 4U',
            style: TextStyle(fontSize: 35, fontFamily: 'Rubik')),
        backgroundColor: const Color.fromARGB(255, 7, 24, 63),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Search Movies'),
                      content: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: 'Enter movie name',
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {

                            // Navigate to ResultPage with search results or no results
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultPage(
                                  searchQuery: searchController.text,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 7, 24, 63),
                          ),
                          child: const Text('Search'),
                        ),
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.youtube_searched_for),
            label: const Text(''),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 7, 24, 63),
            ),
          ),
        ],
      ),
      body: _currentPage == 0
          ? Container(
              color: const Color.fromARGB(250, 20, 38, 77),
              //color: const Color.fromARGB(255, 150, 160, 187),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 0,
                    ),
                  ),
                  HorizontalCarousel(),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        'Categories:',
                        style: TextStyle(
                            fontSize: 45,
                            fontFamily: 'Rubik',
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(20),
                      itemCount: categories.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                            height:
                                20); // Adjust the height based on your preference
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 200.0,
                          height: 100.0,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to the respective recipe page
                              switch (index) {
                                case 0:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ActionPage()),
                                  );
                                  break;
                                case 1:
                                  // Navigate to ItalianPage
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AdventurePage()),
                                  );
                                  break;
                                case 2:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AnimationPage()),
                                  );
                                  break;
                                case 3:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ComedyPage()),
                                  );
                                  break;
                                case 4:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DramaPage()),
                                  );
                                  break;
                                case 5:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FantasyPage()),
                                  );
                                  break;
                                case 6:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HorrorPage()),
                                  );
                                  break;
                                case 7:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MurderMysteryPage()),
                                  );
                                  break;
                                case 8:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RomancePage()),
                                  );
                                  break;
                                case 9:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SciFiPage()),
                                  );
                                  break;

                                // Add cases for other cuisines
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 23, 72, 99),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  categories[index] as String,
                                  style: const TextStyle(
                                      fontSize: 27, fontFamily: 'Rubik'),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(
                                  Icons.navigate_next,
                                  size: 50.0,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : ProfilePage(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 7, 24, 63),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedIconTheme: const IconThemeData(color: Colors.white),
        currentIndex: _currentPage,
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
        ],
      ),
    );
  }
}
