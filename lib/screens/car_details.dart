import 'package:flutter/material.dart';
import 'package:location_app/providers/auth.dart';
import 'package:location_app/providers/car.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_app/providers/companys.dart';
import 'package:location_app/providers/reservation.dart';
import 'package:location_app/screens/car_comment_screen.dart';
import 'package:location_app/screens/company_details_screen.dart';
import 'package:location_app/screens/reservation_details.dart';
import 'package:provider/provider.dart';

class CarDetailsScreen extends StatefulWidget {
  static const routeName = '/car-details';

  @override
  _CarDetailsScreenState createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    final car = ModalRoute.of(context).settings.arguments as Car;
    final company = Provider.of<Companys>(context).findbyId(car.id_company);
    final authData = Provider.of<Auth>(context, listen: false);
    void _onMapCreated(GoogleMapController controller) {
      setState(() {
        _markers.add(Marker(
            markerId: MarkerId('id1'),
            position: LatLng(
                company.position["latitude"], company.position["longitude"])));
      });
    }

    var size = MediaQuery.of(context).size;
    var paddingtop = MediaQuery.of(context).padding.top;
    var appBar = AppBar(
      title: Text(car.marque + " " + car.model),
      actions: [
        IconButton(
            icon: Icon(
              Icons.message,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(CarComment.routeName, arguments: car.id);
            }),
        IconButton(
            icon: Icon(
              car.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                car.toggleFavoriteStatus(authData.token, authData.userId);
              });
            }),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          Container(
            width: size.width,
            height:
                (size.height - appBar.preferredSize.height - paddingtop) * 0.92,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    height: size.height * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(
                        car.imgUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: Colors.white,
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Price per Day",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            "MAD ${car.tarif}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: Colors.white,
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Car features :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        Container(
                          width: size.width,
                          height: 30 * car.caracteristique.length.toDouble(),
                          child: ListView.builder(
                            itemBuilder: (ctx, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, bottom: 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: Theme.of(context).primaryColor,
                                      size: 14,
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      car.caracteristique[index],
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: car.caracteristique.length,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: Colors.white,
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Company Information :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: size.width * 0.5,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.apartment_rounded,
                                      color: Theme.of(context).primaryColor,
                                      size: 24,
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      company.name,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: size.width * 0.35,
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2, vertical: 4),
                                        child: Text(
                                          company.rate.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      "Excellent",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: size.width,
                          height: size.height * 0.17,
                          child: GoogleMap(
                            onMapCreated: _onMapCreated,
                            markers: _markers,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(company.position["latitude"],
                                  company.position["longitude"]),
                              zoom: 15,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Container(
                            width: size.width,
                            height: size.height * 0.15,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ImageIcon(
                                      AssetImage("assets/images/marker.png"),
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Location of rental company:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ))
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child: Text(company.adresse),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          CompanyDetailsScreen.routeName,
                                          arguments: company);
                                    },
                                    child: Text(
                                      "More informations",
                                      style: TextStyle(
                                          color: Colors.blue[800],
                                          fontSize: 15),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: size.width,
            color: Colors.white,
            height:
                (size.height - appBar.preferredSize.height - paddingtop) * 0.08,
            child: Center(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: Theme.of(context).primaryColor)))),
                onPressed: () {
                  if (Provider.of<Reservation>(context, listen: false).id_car ==
                      null) {
                    Navigator.of(context)
                        .pushNamed(ReservationCar.routeName, arguments: car);
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Error"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Ok"))
                            ],
                            content: Text("you have already rented a car"),
                          );
                        });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 12, bottom: 12),
                  child: Text(
                    "Réserver",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
