import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:location_app/models/http_exception.dart';
import 'package:location_app/providers/companys.dart';
import 'package:provider/provider.dart';
import 'car.dart';

class Cars with ChangeNotifier {
  List<Car> _voiture = [];
  final String authToken;
  final String userId;
  Cars(this.authToken, this.userId, this._voiture);

  Future<void> fetchAllCars() async {
    var url =
        'https://location-e0f75-default-rtdb.firebaseio.com/cars.json?auth=$authToken';

    try {
      final responce = await http.get(url);
      final extractedData = json.decode(responce.body) as Map<String, dynamic>;

      if (responce == null) {
        return;
      }

      final favoriteResponce = await http.get(
          'https://location-e0f75-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken');
      final favoriteData = json.decode(favoriteResponce.body);

      final List<Car> loadedCars = [];
      extractedData.forEach((carId, carData) {
        // final List<String> loadedCaracteristique = [];
        // carData["caracteristique"].forEach((caraId, caraData) {
        //   loadedCaracteristique.add(caraData);
        // });
        List<String> loadedCaracteristique = [];
        carData["caracteristique"]
            .forEach((ele) => loadedCaracteristique.add(ele.toString()));

        loadedCars.add(Car(
            id: carId,
            marque: carData["marque"],
            model: carData["model"],
            imgUrl: carData["imgUrl"],
            rate: carData["rate"].toDouble(),
            tarif: carData["tarif"].toDouble(),
            id_company: carData["id_company"],
            city: carData["city"],
            isFavorite:
                favoriteData == null ? false : favoriteData[carId] ?? false,
            caracteristique: loadedCaracteristique));
      });
      _voiture = loadedCars;
    } catch (error) {
      throw HttpException(error);
    }
  }

  List<Car> get voitures {
    return [..._voiture];
  }

  List<Car> findbyIdCompany(String id) {
    List<Car> carOfComany = [];

    _voiture.forEach((element) {
      if (element.id_company == id) {
        carOfComany.add(element);
      }
    });
    return carOfComany;
  }

  List<Car> carsByCity(String city) {
    List<Car> carbycity = [];
    _voiture.forEach((element) {
      if (element.city == city) {
        carbycity.add(element);
      }
    });
    return carbycity;
  }

  Car findbyId(String id) {
    return _voiture.firstWhere((element) => element.id == id);
  }

  List<Car> FavoriteCars() {
    List<Car> favoriteCars = [];
    _voiture.forEach((element) {
      if (element.isFavorite) {
        favoriteCars.add(element);
      }
    });

    return favoriteCars;
  }

  void sortByRate() {
    _voiture.sort((a, b) => -a.rate.compareTo(b.rate));
    notifyListeners();
  }

  void sortByPrice() {
    _voiture.sort((a, b) => a.tarif.compareTo(b.tarif));
    notifyListeners();
  }
}
