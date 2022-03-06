import 'package:flutter/material.dart';

import 'package:location_app/providers/Cars.dart';
import 'package:location_app/providers/car.dart';

import 'package:location_app/widgets/list_cars.dart';
import 'package:provider/provider.dart';

class AllCarsScreen extends StatefulWidget {
  static const routeName = '/all-cars';

  @override
  _AllCarsScreenState createState() => _AllCarsScreenState();
}

class _AllCarsScreenState extends State<AllCarsScreen> {
  int _sortChecked = 0;
  @override
  Widget build(BuildContext context) {
    final city = ModalRoute.of(context).settings.arguments as String;
    var carbyCity;
    if (city != null) {
      carbyCity = Provider.of<Cars>(context).carsByCity(city);
    }

    print(carbyCity);

    var size = MediaQuery.of(context).size;
    final carsData = Provider.of<Cars>(context);
    final cars = carsData.voitures;
    var paddingtop = MediaQuery.of(context).padding.top;
    final appBar = AppBar(
      title: Text(city == null ? "All Cars" : city.toUpperCase()),
      actions: [
        IconButton(
            icon: Icon(Icons.sort_sharp),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (contex) {
                    return StatefulBuilder(builder: (context, setState) {
                      return AlertDialog(
                        actions: [
                          TextButton(
                              onPressed: () {
                                if (_sortChecked == 1) {
                                  Provider.of<Cars>(context, listen: false)
                                      .sortByRate();
                                } else if (_sortChecked == 2) {
                                  Provider.of<Cars>(context, listen: false)
                                      .sortByPrice();
                                }

                                Navigator.of(context).pop();
                              },
                              child: Text("Ok"))
                        ],
                        title: Text("Sort"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Radio(
                                  value: 1,
                                  groupValue: _sortChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      _sortChecked = value;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text("By rate")
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 2,
                                  groupValue: _sortChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      _sortChecked = value;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text("By price")
                              ],
                            )
                          ],
                        ),
                      );
                    });
                  });
            })
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: carbyCity != null && carbyCity.length == 0
          ? Center(
              child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    width: size.width * 0.4,
                    child: Image.asset("assets/images/cars.png"),
                  ),
                ),
                Text(
                  "No Cars",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ))
          : Container(
              width: size.width,
              height: size.height,
              child: Column(
                children: [
                  SingleChildScrollView(
                      child: ListCars(
                    height: (size.height -
                            appBar.preferredSize.height -
                            paddingtop) *
                        0.93,
                    size: size,
                    cars: city == null ? cars : carbyCity,
                  )),
                ],
              ),
            ),
    );
  }
}
