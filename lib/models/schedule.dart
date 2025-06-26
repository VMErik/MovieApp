import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class Days {
  final String day;
  final String dayName;
  final List<Schedule> schedules;

  Days({required this.day, required this.dayName, required this.schedules});
}

class Schedule {
  final String hour;
  final String hall;

  Schedule({required this.hour, required this.hall});
}

List<Days> generateCurrentMonthSchedule() {
  final now = DateTime.now();
  final daysInMonth = DateUtils.getDaysInMonth(now.year, now.month);
  final dayFormatter = DateFormat('dd');
  final weekdayFormatter = DateFormat.EEEE('es');
  final random = Random();

  return List.generate(daysInMonth, (index) {
    final date = DateTime(now.year, now.month, index + 1);

    // Genera entre 1 y 5 horarios aleatorios
    final scheduleCount = random.nextInt(5) + 1;

    final schedules = List.generate(scheduleCount, (_) {
      final hour = 8 + random.nextInt(12); // Entre 8 AM y 8 PM
      final minute = random.nextBool() ? "00" : "30"; // Media hora o exacta
      final hallNumber = 1 + random.nextInt(5); // Salas 1 a 5

      return Schedule(
        hour: '${hour.toString().padLeft(2, '0')}:$minute',
        hall: 'Sala $hallNumber',
      );
    });

    return Days(
      day: dayFormatter.format(date),
      dayName: weekdayFormatter.format(date),
      schedules: schedules,
    );
  });
}
