import 'package:flutter/cupertino.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:location_app/models/http_exception.dart';
import 'package:location_app/providers/reservation.dart';
import 'package:provider/provider.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  String fullname;
  String street;
  int postalCode;
  String city;
  String country;
  String nationality;
  String cni;
  String phoneNumber;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        ('https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlSegment?key=AIzaSyD0tQFmCY6FPptXPR4RdEcj9ylgm9_zRZI'));
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      getUserData();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signupNewUser');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'verifyPassword');
  }

  void logout() {
    _token = null;
    _userId = null;
    _expiryDate = null;
    notifyListeners();
  }

  Future<void> EditUserData(Map<String, String> data) async {
    var url =
        'https://location-e0f75-default-rtdb.firebaseio.com/users/$userId.json?auth=$token';
    try {
      final responce = await http.put(url,
          body: json.encode({
            'fullName': data['fullName'],
            'street': data['street'],
            'postalCode': data['postalCode'],
            'city': data['city'],
            'country': data['country'],
            'nationality': data['nationality'],
            'cni': data['cni'],
            'phoneNumber': data['phoneNumber'],
          }));
      fullname = data['fullName'];
      street = data['street'];
      postalCode = int.parse(data['postalCode']);
      city = data['city'];
      country = data['country'];
      nationality = data['nationality'];
      cni = data['cni'];
      phoneNumber = data['phoneNumber'];
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> getUserData() async {
    var url =
        'https://location-e0f75-default-rtdb.firebaseio.com/users/$userId.json?auth=$token';

    try {
      final responce = await http.get(url);
      final extractedData = json.decode(responce.body) as Map<String, dynamic>;

      if (responce == null) {
        return;
      }

      if (extractedData != null) {
        fullname = extractedData['fullName'];
        street = extractedData['street'];
        postalCode = int.parse(extractedData['postalCode']);
        city = extractedData['city'];
        country = extractedData['country'];
        nationality = extractedData['nationality'];
        cni = extractedData['cni'];
        phoneNumber = extractedData['phoneNumber'];
      } else {
        fullname = null;
        street = null;
        postalCode = null;
        city = null;
        country = null;
        nationality = null;
        cni = null;
        phoneNumber = null;
      }
    } catch (error) {}
  }
}
