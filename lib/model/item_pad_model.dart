import 'package:calculator/enum/calculations.dart';
import 'package:flutter/material.dart';

@immutable
class ItemPad {
  final String name;
  final Calculations calculations;

  const ItemPad({
    required this.name,
    required this.calculations,
  });
}
