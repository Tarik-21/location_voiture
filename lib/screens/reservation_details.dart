import 'package:flutter/material.dart';
import 'package:location_app/providers/auth.dart';
import 'package:location_app/providers/car.dart';
import 'package:location_app/providers/companys.dart';
import 'package:location_app/providers/reservation.dart';
import 'package:location_app/screens/profile_page_screen.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class ReservationCar extends StatefulWidget {
  static const routeName = '/Reservation-car';

  @override
  _ReservationCarState createState() => _ReservationCarState();
}

class _ReservationCarState extends State<ReservationCar> {
  DateTime _startDate;
  DateTime _endDate;
  int _numberOfDays;
  var _isLoading = false;

  Future<void> _submit(var authData, var car) async {
    if (_endDate != null &&
        _startDate != null &&
        _numberOfDays != null &&
        authData.fullname != null) {
      setState(() {
        _isLoading = true;
      });
      Map<String, dynamic> data = {
        'carId': car.id,
        'startDate': DateFormat.yMd().format(_startDate),
        'endDate': DateFormat.yMd().format(_endDate),
        'numberOfDate': _numberOfDays,
        'totalPrice': _numberOfDays * car.tarif,
      };
      await Provider.of<Reservation>(context, listen: false)
          .addReservation(data);
      Navigator.of(context).pop();
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Empty fields"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Ok"))
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final car = ModalRoute.of(context).settings.arguments as Car;
    final company = Provider.of<Companys>(context).findbyId(car.id_company);

    final authData = Provider.of<Auth>(context, listen: false);

    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Reservation"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    height: size.height * 0.17,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Image.asset(
                              car.imgUrl,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  car.marque + " " + car.model,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  company.name,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: size.width,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Informations about clients",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      ProfileScreen.routeName,
                                      arguments: "Edit Profile");
                                },
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 5),
                                    child: Icon(Icons.edit),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                "Full name : ",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                authData.fullname == null
                                    ? ''
                                    : authData.fullname,
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "National identification number ",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                authData.cni == null ? '' : authData.cni,
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Phone number : ",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                authData.phoneNumber == null
                                    ? ''
                                    : authData.phoneNumber,
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: size.width,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Informations about reservation",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                "Price per day : ",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text("MAD 250",
                                  style: TextStyle(
                                    fontSize: 15,
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Start day : ",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  _startDate == null
                                      ? ''
                                      : DateFormat.yMd().format(_startDate),
                                  style: TextStyle(
                                    fontSize: 15,
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "End day : ",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  _endDate == null
                                      ? ''
                                      : DateFormat.yMd().format(_endDate),
                                  style: TextStyle(
                                    fontSize: 15,
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Number of days : ",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  _numberOfDays == null
                                      ? ''
                                      : _numberOfDays.toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Total rental amount",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            _numberOfDays == null
                                ? ''
                                : 'MAD ' + (_numberOfDays * 250).toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.white,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Container(
                                  width: size.width * 0.7,
                                  height: size.height * 0.5,
                                  child: SfDateRangePicker(
                                    initialSelectedRange:
                                        PickerDateRange(_startDate, _endDate),
                                    showActionButtons: true,
                                    cancelText: 'CANCEL',
                                    confirmText: 'OK',
                                    onSubmit: (value) {
                                      PickerDateRange dates = value;
                                      setState(() {
                                        _startDate = dates.startDate;
                                        _endDate = dates.endDate;
                                        _numberOfDays = _endDate
                                            .difference(_startDate)
                                            .inDays;
                                      });
                                      Navigator.pop(context);
                                    },
                                    onCancel: () {
                                      Navigator.pop(context);
                                    },
                                    selectionTextStyle:
                                        const TextStyle(color: Colors.white),
                                    selectionColor:
                                        Theme.of(context).primaryColor,
                                    startRangeSelectionColor:
                                        Theme.of(context).primaryColor,
                                    endRangeSelectionColor:
                                        Theme.of(context).primaryColor,
                                    rangeSelectionColor:
                                        Color.fromRGBO(35, 59, 111, 0.5),
                                    view: DateRangePickerView.month,
                                    selectionMode:
                                        DateRangePickerSelectionMode.range,
                                  ),
                                ),
                              );
                            });
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Chose Date",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (_isLoading)
                      Center(
                          child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor),
                      ))
                    else
                      ElevatedButton(
                        onPressed: () {
                          _submit(authData, car);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: const Text(
                            "Reserver",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                        ),
                      )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
