import 'package:flutter/material.dart';
import 'package:moviesapp/models/cast.dart';
import 'package:moviesapp/models/movie_container.dart';
import 'package:moviesapp/models/movie_detail.dart';
import 'package:moviesapp/models/schedule.dart';
import 'package:moviesapp/services/movie_service.dart';

class MoviePage extends StatefulWidget {
  final MovieContainer movie;

  const MoviePage({super.key, required this.movie});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late Future<MovieDetail> detail;
  late Future<List<CastMember>> cast;
  final List<Days> days = generateCurrentMonthSchedule();
  final movieService = MovieService();
  int indexSelected = 0;

  @override
  void initState() {
    super.initState();
    detail = movieService.fetchMovieDetail(widget.movie.movie.id);
    cast = movieService.getMovieCast(widget.movie.movie.id);
    indexSelected = DateTime.now().day - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Future para los detalles de la pelicula
            FutureBuilder<MovieDetail>(
              future: detail,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('Película no encontrada'));
                }
                final movieDetail = snapshot.data!;
                return _loadMovieContent(movieDetail);
              },
            ),
            // Future Buiiler del Cast
            FutureBuilder<List<CastMember>>(
              future: cast,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('Cast no encontrado'));
                }
                // Obtenemos el valor, que en este caso es la lista
                final cast = snapshot.data!;
                return _loadCast(cast);
              },
            ),
            _loadHorarios(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          child: Text(
            'Comprar Boletos',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _loadHorarios() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Horarios',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          // Dias
          SizedBox(
            height: 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final schedule = days[index];
                return GestureDetector(
                  onTap: () {
                    indexSelected = index;
                    setState(() {});
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: indexSelected == index
                          ? Colors.lightBlue
                          : Colors.white60,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            schedule.day,
                            style: TextStyle(color: Colors.white, fontSize: 28),
                          ),
                          Text(
                            schedule.dayName,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => SizedBox(width: 10),
              itemCount: days.length,
            ),
          ),
          SizedBox(height: 15),
          // Lista de hoorarios
          Column(
            children: List.generate(days[indexSelected].schedules.length, (
              index,
            ) {
              final schedule = days[indexSelected].schedules[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.timelapse_rounded, size: 30, color: Colors.blue),
                  SizedBox(width: 20),
                  Text(
                    schedule.hour,
                    style: TextStyle(fontSize: 28, color: Colors.white),
                  ),
                  Spacer(),
                  Text(
                    schedule.hall,
                    style: TextStyle(fontSize: 16, color: Colors.white60),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _loadCast(List<CastMember> cast) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cast',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          SizedBox(
            height: 150,
            width: double.infinity,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final actor = cast[index];
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: actor.fullProfileUrl.isNotEmpty
                          ? NetworkImage(actor.fullProfileUrl)
                          : null,
                    ),
                    SizedBox(height: 6),
                    Text(
                      actor.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.blue),
                    ),
                    Text(
                      actor.character,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white60),
                    ),
                  ],
                );
              },
              separatorBuilder: (_, __) => SizedBox(width: 15),
              itemCount: cast.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _loadMovieContent(MovieDetail movie) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header
          SizedBox(
            width: double.infinity,
            height: 250,
            child: Stack(
              alignment: Alignment.center, // Centra los hijos del Stack
              children: [
                // Imagen con opacidad
                Opacity(
                  opacity: 0.8, // Ajusta este valor entre 0.0 y 1.0
                  child: Hero(
                    tag: widget.movie.idHero,
                    child: Image.network(
                      movie.fullBackdropUrl,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: double.infinity,
                        height: 250,
                        color: Colors.grey[800],
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                // Texto superpuesto
                Positioned.fill(
                  // Ocupa todo el espacio del Stack
                  child: Center(
                    child: Text(
                      movie.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            // Sombra para mejor legibilidad
                            blurRadius: 20.0,
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.lightBlue),
                    SizedBox(width: 15),
                    Text(
                      movie.formattedRuntime,
                      style: TextStyle(color: Colors.lightBlueAccent),
                    ),
                    Spacer(),
                    Icon(Icons.star, color: Colors.yellow),
                    SizedBox(width: 15),
                    Text(
                      movie.popularity.toString(),
                      style: TextStyle(color: Colors.amberAccent),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                Text(
                  'Sinopsis',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  movie.overview,
                  style: TextStyle(color: Colors.white60),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
