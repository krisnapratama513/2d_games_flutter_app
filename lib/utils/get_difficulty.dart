import 'package:flutter/material.dart';

Map<String, dynamic> getDifficulty(double value, {bool levelAsString = true}) {
  if (value <= 0.111) {
    return {
      'label': 'MUDAH',
      'color': Color(0xFF4CAF50),
      'level': levelAsString ? 'mudah' : 1,
    };
  } else if (value <= 0.375) {
    return {
      'label': 'SEDANG',
      'color': Color(0xFFFF9800),
      'level': levelAsString ? 'sedang' : 5,
    };
  } else if (value <= 0.875) {
    return {
      'label': 'SULIT',
      'color': Color(0xFFF44336),
      'level': levelAsString ? 'sulit' : 11,
    };
  } else {
    return {
      'label': 'SANGAT SULIT',
      'color': Color(0xFF9C27B0),
      'level': levelAsString ? 'sangat sulit' : 23,
    };
  }
}
