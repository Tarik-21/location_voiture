import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Reservation with ChangeNotifier {
  String id;
  final String id_user;
  String id_car;
  String startDate;
  String endDate;
  int numberOfDays;
  double totalPrice;
  DateTime dateTime;
  final String authToken;
  String etat;

  Reservation(this.authToken, this.id_user);

  Future<void> fetchReservation() async {
    final url =
        'https://location-e0f75-default-rtdb.firebaseio.com/reservations/$id_user.json?auth=$authToken';
    try {
      final responce = await http.get(url);
      final extractedData = json.decode(responce.body);

      if (responce == null) {
        return;
      }
      if (extractedData != null) {
        extractedData.forEach((resrvationId, reservationData) {
          if (reservationData['etat'] == 'In progress ...' ||
              reservationData['etat'] == 'Reserved') {
            id = resrvationId;
            id_car = reservationData['carId'];
            startDate = reservationData['startDate'];
            endDate = reservationData['endDate'];
            numberOfDays = reservationData['numberOfDate'];
            //dateTime = reservationData['dateTime'];
            totalPrice = reservationData['totalPrice'];
            etat = reservationData['etat'];
          }
        });
      } else {
        id_car = null;
        startDate = null;
        endDate = null;
        numberOfDays = null;
        //dateTime = reservationData['dateTime'];
        totalPrice = null;
        etat = null;
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> addReservation(Map<String, dynamic> data) async {
    final url =
        'https://location-e0f75-default-rtdb.firebaseio.com/reservations/$id_user.json?auth=$authToken';
    try {
      final timestamp = DateTime.now();
      final responce = await http.post(url,
          body: json.encode({
            'carId': data['carId'],
            'startDate': data['startDate'],
            'endDate': data['endDate'],
            'numberOfDate': data['numberOfDate'],
            'dateTime': timestamp.toIso8601String(),
            'totalPrice': data['totalPrice'],
            'etat': 'In progress ...',
          }));

      id_car = data['carId'];
      startDate = data['startDate'];
      endDate = data['endDate'];
      numberOfDays = data['numberOfDate'];
      dateTime = timestamp;
      totalPrice = data['totalPrice'];
      etat = 'In progress ...';
      notifyListeners();
    } catch (error) {}
  }

  Future<void> deleteReservation(String id) async {
    final url =
        'https://location-e0f75-default-rtdb.firebaseio.com/reservations/$id_user/$id.json?auth=$authToken';
    try {
      final responce = await http.delete(url);
      notifyListeners();
      id_car = null;
      startDate = null;
      endDate = null;
      numberOfDays = null;
      //dateTime = reservationData['dateTime'];
      totalPrice = null;
      etat = null;
      notifyListeners();
    } catch (error) {}
  }
}
