import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:location_app/providers/car.dart';
import 'package:location_app/providers/companys.dart';
import 'package:location_app/screens/car_details.dart';
import 'package:provider/provider.dart';

class ListCars extends StatelessWidget {
  const ListCars(
      {Key key,
      @required this.height,
      @required this.size,
      @required this.cars})
      : super(key: key);

  final double height;
  final Size size;
  final List<Car> cars;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (ctx, index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: size.width,
                height: size.height * 0.2,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[200],
                        blurRadius: 10,
                        spreadRadius: 10,
                        offset: Offset(5, 5),
                      )
                    ]),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Image.asset(
                            cars[index].imgUrl,
                            fit: BoxFit.fill,
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 5),
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cars[index].model +
                                            " " +
                                            cars[index].marque,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${cars[index].tarif.toInt()} Dh / Day",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.apartment_rounded),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text(Provider.of<Companys>(context)
                                              .findbyId(cars[index].id_company)
                                              .name),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          LayoutBuilder(
                                              builder: (ctx, constraints) {
                                            return Container(
                                              child: RatingBar.builder(
                                                initialRating:
                                                    cars[index].rate / 2,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                itemCount: 5,
                                                itemSize: 20,
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 2.0),
                                                itemBuilder: (ctx, _) => Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),
                                            );
                                          }),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            cars[index].rate.toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Material(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              CarDetailsScreen.routeName,
                                              arguments: cars[index]);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Center(
                                              child: Text(
                                                "See Details",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            );
          },
          itemCount: cars.length,
        ));
  }
}
