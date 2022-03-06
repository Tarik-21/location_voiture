import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:location_app/providers/company.dart';

import 'package:http/http.dart' as http;

class Car with ChangeNotifier {
  final String id;
  final String marque;
  final String model;
  final String imgUrl;
  List<String> caracteristique;
  final double tarif;
  final double rate;
  final String id_company;
  bool isFavorite;
  final String city;

  Car({
    @required this.id,
    @required this.marque,
    @required this.model,
    @required this.imgUrl,
    @required this.caracteristique,
    @required this.tarif,
    @required this.rate,
    @required this.id_company,
    @required this.city,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    var url =
        'https://location-e0f75-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    try {
      final responce = await http.put(
        url,
        body: json.encode(isFavorite),
      );

      if (responce.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
