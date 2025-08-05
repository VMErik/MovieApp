import 'package:flutter/material.dart';

class MyTikets extends StatefulWidget {
  final ValueChanged<int> onTotalTicketsChanged; // 👈 Callback al padre
  const MyTikets({super.key, required this.onTotalTicketsChanged});

  @override
  State<MyTikets> createState() => _MyTiketsState();
}

class _MyTiketsState extends State<MyTikets> {
  int childrens = 0;
  int adults = 0;
  double totalPrice = 0;

  _calculateTotal() {
    setState(() {
      totalPrice = childrens * 80;
      totalPrice = totalPrice + (adults * 120);

      int totalTickets = childrens + adults;
      widget.onTotalTicketsChanged(totalTickets);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Boletos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '\$ $totalPrice',
              style: TextStyle(
                fontSize: 18,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Niños',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.remove_outlined,
                        color: Colors.black,
                        size: 28,
                      ), // Icono blanco y tamaño
                      onPressed: () {
                        if (childrens > 0) {
                          setState(() {
                            childrens = childrens - 1;
                            _calculateTotal();
                          });
                        }
                      },
                    ),
                    Text(
                      childrens.toString(),
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 28,
                      ), // Icono blanco y tamaño
                      onPressed: () {
                        setState(() {
                          childrens = childrens + 1;
                          _calculateTotal();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Adultos',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.remove_outlined,
                        color: Colors.black,
                        size: 28,
                      ), // Icono blanco y tamaño
                      onPressed: () {
                        if (adults > 0) {
                          setState(() {
                            adults = adults - 1;
                            _calculateTotal();
                          });
                        }
                      },
                    ),
                    Text(
                      adults.toString(),
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 28,
                      ), // Icono blanco y tamaño
                      onPressed: () {
                        setState(() {
                          adults = adults + 1;
                          _calculateTotal();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
