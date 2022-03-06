import 'package:flutter/material.dart';
import 'package:location_app/providers/car.dart';
import 'package:location_app/providers/reservation.dart';
import 'package:location_app/screens/car_details.dart';
import 'package:location_app/screens/reservation_details.dart';
import 'package:provider/provider.dart';

class HotDealsCarsList extends StatelessWidget {
  const HotDealsCarsList({
    Key key,
    @required this.size,
    @required this.cars,
  }) : super(key: key);

  final Size size;
  final List<Car> cars;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.95,
      height: size.height * 0.32,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              width: size.width * 0.5,
              height: size.height * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(cars[index].marque,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        Text("${cars[index].tarif.toInt()} Dh",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(cars[index].model,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            )),
                        Text("/ day",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: 100,
                    child: Image.asset(
                      cars[index].imgUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: LayoutBuilder(builder: (ctx, constaints) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          width: size.width,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  Navigator.of(context).pushNamed(
                                      CarDetailsScreen.routeName,
                                      arguments: cars[index]);
                                },
                                child: Container(
                                  width: constaints.maxWidth * 0.4,
                                  height: constaints.maxHeight,
                                  child: Center(
                                    child: Text(
                                      "Details",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (Provider.of<Reservation>(context,
                                              listen: false)
                                          .id_car ==
                                      null) {
                                    Navigator.of(context).pushNamed(
                                        ReservationCar.routeName,
                                        arguments: cars[index]);
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
                                            content: Text(
                                                "you have already rented a car"),
                                          );
                                        });
                                  }
                                },
                                child: Container(
                                  width: constaints.maxWidth * 0.6,
                                  height: constaints.maxHeight,
                                  padding: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                      )),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Reserve now",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(
                                        Icons.arrow_right,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: cars.length,
      ),
    );
  }
}
