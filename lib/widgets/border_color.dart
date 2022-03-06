import 'package:flutter/material.dart';

OutlineInputBorder borderColor(Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: color,
    ),
  );
}
