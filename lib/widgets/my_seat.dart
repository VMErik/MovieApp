import 'package:flutter/material.dart';
import 'package:moviesapp/models/seat.dart';

class MySeat extends StatefulWidget {
  final Seat seat;
  final ValueChanged<int> decrementSeats; // 👈 Callback al padre
  final ValueChanged<int> increaseSets; // 👈 Callback al padre

  const MySeat({
    super.key,
    required this.seat,
    required this.decrementSeats,
    required this.increaseSets,
  });

  @override
  State<MySeat> createState() => _MySeatState();
}

class _MySeatState extends State<MySeat> {
  @override
  Widget build(BuildContext context) {
    final seat = widget.seat;
    final color = seat.isOccupied
        ? Colors.grey
        : seat.isSelected
        ? Colors.blueAccent
        : Colors.white;

    return GestureDetector(
      onTap: seat.isOccupied
          ? null
          : () {
              setState(() {
                seat.isSelected = !seat.isSelected;
                if (seat.isSelected) {
                  widget.increaseSets(0);
                } else {
                  widget.decrementSeats(0);
                }
              });
            },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(),
          borderRadius: BorderRadius.circular(6),
        ),
        alignment: Alignment.center,
        child: Text('${seat.row}${seat.number}'),
      ),
    );
  }
}
