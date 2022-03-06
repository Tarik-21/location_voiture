import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:location_app/models/http_exception.dart';

import 'company.dart';

class Companys with ChangeNotifier {
  List<Company> _companys = [];
  final String authToken;
  Companys(this.authToken, this._companys);

  Future<void> fetchCompanys() async {
    var url =
        'https://location-e0f75-default-rtdb.firebaseio.com/companys.json?auth=$authToken';

    try {
      final responce = await http.get(url);
      final extractedData = json.decode(responce.body) as Map<String, dynamic>;

      if (extractedData == null) {
        return;
      }
      final List<Company> loadedCompanys = [];
      extractedData.forEach((companyId, companyData) {
        List<String> loadedCara = [];
        companyData["id_cars"].forEach((ele) => loadedCara.add(ele.toString()));

        loadedCompanys.add(Company(
          id: companyId,
          name: companyData["name"],
          imageUrl: companyData["imageUrl"],
          rate: companyData["rate"].toDouble(),
          city: companyData["city"],
          adresse: companyData["adresse"],
          position: {
            "latitude": companyData["position"]["latitude"],
            "longitude": companyData["position"]["longitude"],
          },
          offers_id: loadedCara,
        ));
      });

      _companys = loadedCompanys;
    } catch (error) {
      throw HttpException(error);
    }
  }

  Company findbyId(String id) {
    return _companys.firstWhere((ele) => ele.id == id);
  }

  List<Company> get companys {
    return [..._companys];
  }
}
