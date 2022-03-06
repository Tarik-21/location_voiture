import 'package:flutter/material.dart';

class Company with ChangeNotifier {
  final String id;
  final String name;
  final String imageUrl;
  final double rate;
  List<String> offers_id;
  final String adresse;
  final Map<String, double> position;
  final String city;

  Company(
      {this.id,
      this.name,
      this.imageUrl,
      this.rate,
      this.offers_id,
      this.position,
      this.adresse,
      this.city});
}
