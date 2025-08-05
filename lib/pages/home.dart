import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moviesapp/models/movie.dart';
import 'package:moviesapp/models/movie_container.dart';
import 'package:moviesapp/pages/favorites_view.dart';
import 'package:moviesapp/pages/home_view.dart';
import 'package:moviesapp/services/movie_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Lista de vistas
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // Inicializamos las vistas
    _pages = [HomeViewPage(), FavoritesViewPage()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            'Movie App',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Cartelera'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Mis Pelis Favoritas',
          ),
        ],
      ),
    );
  }
}
