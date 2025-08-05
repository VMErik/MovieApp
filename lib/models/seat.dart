class Seat {
  final String row;
  final int number;
  bool isSelected;
  bool isOccupied;

  Seat({
    required this.row,
    required this.number,
    this.isSelected = false,
    this.isOccupied = false,
  });
}
