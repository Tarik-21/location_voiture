import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class FeedBackCar {
  final String id_car;
  final String id_feedback;
  final String fullname;
  final String comment;
  final int rate;

  FeedBackCar(
      {this.id_car, this.id_feedback, this.fullname, this.comment, this.rate});
}

class FeedBackCompany {
  final String id_company;
  final String id_feedback;
  final String fullname;
  final String comment;
  final int rate;

  FeedBackCompany(
      {this.id_company,
      this.id_feedback,
      this.fullname,
      this.comment,
      this.rate});
}

class FeedBacks with ChangeNotifier {
  List<FeedBackCar> _feedbacksCar = [];
  List<FeedBackCompany> _feedbacksCompany = [];

  final String authToken;
  FeedBacks(this.authToken, this._feedbacksCar, this._feedbacksCompany);

  List<FeedBackCar> get feedbackscar {
    return [..._feedbacksCar];
  }

  List<FeedBackCompany> get feedbackscompany {
    return [..._feedbacksCompany];
  }

  Future<void> addFeedBack(
      String id_car,
      String id_company,
      String fullname,
      String commentCar,
      int rateCar,
      String commentCompany,
      int rateCompany) async {
    var url =
        'https://location-e0f75-default-rtdb.firebaseio.com/carsFeedBack/$id_car.json?auth=$authToken';
    try {
      var responce = await http.post(url,
          body: json.encode({
            'fullname': fullname,
            'comment': commentCar,
            'rate': rateCar,
          }));
      _feedbacksCar.insert(
          0,
          FeedBackCar(
              id_car: id_car,
              fullname: fullname,
              comment: commentCar,
              id_feedback: json.decode(responce.body)['name'],
              rate: rateCar));
      url =
          'https://location-e0f75-default-rtdb.firebaseio.com/companyFeedBack/$id_company.json?auth=$authToken';
      responce = await http.post(url,
          body: json.encode({
            'fullname': fullname,
            'comment': commentCompany,
            'rate': rateCompany,
          }));
      _feedbacksCompany.insert(
          0,
          FeedBackCompany(
              id_company: id_company,
              fullname: fullname,
              comment: commentCompany,
              id_feedback: json.decode(responce.body)['name'],
              rate: rateCompany));
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> getAllCommentCar(String id_car) async {
    final url =
        'https://location-e0f75-default-rtdb.firebaseio.com/carsFeedBack/$id_car.json?auth=$authToken';

    try {
      final responce = await http.get(url);
      final extractedData = json.decode(responce.body) as Map<String, dynamic>;
      if (responce == null) {
        return;
      }
      final List<FeedBackCar> loadedFeedbackCars = [];
      if (extractedData != null) {
        extractedData.forEach((feedbacktId, feedbackdata) {
          loadedFeedbackCars.add(FeedBackCar(
            id_car: id_car,
            id_feedback: feedbacktId,
            comment: feedbackdata['comment'],
            fullname: feedbackdata['fullname'],
            rate: feedbackdata['rate'],
          ));
        });
      }

      _feedbacksCar = loadedFeedbackCars;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> getAllCommentCompany(String id_company) async {
    final url =
        'https://location-e0f75-default-rtdb.firebaseio.com/companyFeedBack/$id_company.json?auth=$authToken';

    try {
      final responce = await http.get(url);
      final extractedData = json.decode(responce.body) as Map<String, dynamic>;
      if (responce == null) {
        return;
      }
      final List<FeedBackCompany> loadedFeedbackCompany = [];
      if (extractedData != null) {
        extractedData.forEach((feedbacktId, feedbackdata) {
          loadedFeedbackCompany.add(FeedBackCompany(
            id_company: id_company,
            id_feedback: feedbacktId,
            comment: feedbackdata['comment'],
            fullname: feedbackdata['fullname'],
            rate: feedbackdata['rate'],
          ));
        });
      }

      _feedbacksCompany = loadedFeedbackCompany;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
