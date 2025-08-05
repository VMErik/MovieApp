import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moviesapp/models/seat.dart';
import 'package:moviesapp/widgets/my_seat.dart';
import 'package:moviesapp/widgets/my_tickets.dart';

class TicketsModal extends StatefulWidget {
  final String movie;
  final String day;
  final String hall;
  final String hour;

  const TicketsModal({
    super.key,
    required this.movie,
    required this.day,
    required this.hall,
    required this.hour,
  });

  @override
  State<TicketsModal> createState() => _TicketsModalState();
}

class _TicketsModalState extends State<TicketsModal> {
  int childrens = 0;
  int adults = 0;
  double totalPrice = 0;
  late List<Seat> seats;
  int totalBoletos = 0;
  int totalAsignados = 0;

  List<Seat> generateSeats({int rows = 5, int seatsPerRow = 8}) {
    List<Seat> seats = [];
    for (int row = 0; row < rows; row++) {
      String rowLetter = String.fromCharCode(65 + row); // 65 = 'A'
      for (int num = 1; num <= seatsPerRow; num++) {
        seats.add(
          Seat(
            row: rowLetter,
            number: num,
            isOccupied: Random().nextBool(), // o false por defecto
          ),
        );
      }
    }
    return seats;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    seats = generateSeats(rows: 5, seatsPerRow: 6);
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, state) {
        return FractionallySizedBox(
          heightFactor: 0.80, // 👈 3/4 de la pantalla
          widthFactor: 0.90,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Adquiere tus entradas',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.calendar_month,
                      size: 34,
                      color: Colors.blueAccent,
                    ),
                    Text(
                      widget.day,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          widget.hall,
                          style: TextStyle(
                            color: Colors.blueGrey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          widget.hour,
                          style: TextStyle(
                            color: Colors.blueGrey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                MyTikets(
                  onTotalTicketsChanged: (total) {
                    setState(() {
                      totalBoletos = total;
                      print('Total boletos es ' + totalBoletos.toString());
                    });
                  },
                ),
                Text(
                  'Asientos Disponibles',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: seats.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6, // 8 asientos por fila
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return MySeat(
                      seat: seats[index],
                      decrementSeats: (total) {
                        totalAsignados--;
                        print('Total asignados' + totalAsignados.toString());
                      },
                      increaseSets: (total) {
                        totalAsignados++;
                        print('Total asignados' + totalAsignados.toString());
                      },
                    );
                  },
                ),
                Spacer(),
                // Boton Inferior
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      // Acción del botón
                      if (totalBoletos != totalAsignados) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Aviso'),
                              content: Text(
                                'NO puede asignar una cantidad diferente de asientos que los boletos adquiridos',
                              ),
                              actions: [
                                TextButton(
                                  child: Text('Cerrar'),
                                  onPressed: () {
                                    Navigator.of(
                                      context,
                                    ).pop(); // Cierra el diálogo
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        return;
                      }
                    },
                    child: Text(
                      "Terminar compra",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
