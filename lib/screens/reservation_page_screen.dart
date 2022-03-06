import 'package:flutter/material.dart';
import 'package:location_app/providers/Cars.dart';
import 'package:location_app/providers/companys.dart';
import 'package:location_app/providers/reservation.dart';
import 'package:location_app/screens/feedback_screen.dart';
import 'package:provider/provider.dart';

class ReservationScreen extends StatefulWidget {
  static const title = 'Reservation';
  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  //var _isInit = true;
  var _isLoading = false;
  var reservation;
  var car;
  var company;

  /*@override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Future.wait([
        Provider.of<Reservation>(context).fetchReservation(),
      ]).then((_) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((error) => print(error));
    }
    _isInit = false;
    super.didChangeDependencies();
  }*/

  @override
  Widget build(BuildContext context) {
    reservation = Provider.of<Reservation>(context);
    if (/*!_isLoading &&*/ reservation.id_car != null) {
      car = Provider.of<Cars>(context, listen: false)
          .findbyId(reservation.id_car);
      company = Provider.of<Companys>(context, listen: false)
          .findbyId(car.id_company);
    }

    var size = MediaQuery.of(context).size;
    return
        /*_isLoading
        ? Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor),
            ),
          )
        :*/
        reservation.id_car == null
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "No reservation",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Container(
                      width: size.width * 0.6,
                      height: size.height * 0.4,
                      child: Image.asset("assets/images/reservation.png"),
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              )
            : Scaffold(
                body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10,
                            offset: Offset(3, 3))
                      ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            children: [
                              Container(
                                  height: size.height * 0.2,
                                  width: size.width * 0.7,
                                  child: Image.asset(
                                    car.imgUrl,
                                    fit: BoxFit.cover,
                                  )),
                              Text(
                                car.marque + " " + car.model,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                              Text(
                                company.name,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          )),
                      Container(
                        width: size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Start date : ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    reservation.startDate,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "End date : ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    reservation.endDate,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Number of days : ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    reservation.numberOfDays.toString(),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Price of day : ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    "MAD " + car.tarif.toString(),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Totaal Price : ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    "MAD " + reservation.totalPrice.toString(),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  reservation.etat,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                              ),
                            ),
                            Expanded(
                                child: _isLoading
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                            child: CircularProgressIndicator(
                                          valueColor:
                                              new AlwaysStoppedAnimation<Color>(
                                                  Theme.of(context)
                                                      .primaryColor),
                                        )),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          if (reservation.etat == "Reserved") {
                                            Navigator.of(context).pushNamed(
                                                FeedBackScreen.routeName,
                                                arguments: car);
                                          } else {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            Provider.of<Reservation>(context,
                                                    listen: false)
                                                .deleteReservation(
                                                    reservation.id);
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(30),
                                                  topLeft:
                                                      Radius.circular(30))),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Text(
                                              reservation.etat == 'Reserved'
                                                  ? "FeedBack"
                                                  : "Cancel",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ));
  }
}
