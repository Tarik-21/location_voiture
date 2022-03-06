import 'package:flutter/material.dart';
import 'package:location_app/providers/companys.dart';
import 'package:location_app/screens/all_cars_screen.dart';
import 'package:location_app/screens/all_companys_screen.dart';
import 'package:location_app/widgets/hot_deals_cars_list.dart';
import 'package:location_app/widgets/top_dealers_list.dart';
import '../providers/Cars.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const title = '';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final carsData = Provider.of<Cars>(context);
    final cars = carsData.voitures;

    final companysData = Provider.of<Companys>(context);
    final companys = companysData.companys;

    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Container(
            child: Column(
              children: [
                Container(
                  width: size.width,
                  height: size.height * 0.08,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      onSubmitted: (value) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        Navigator.of(context).pushNamed(AllCarsScreen.routeName,
                            arguments: value);
                      },
                      decoration: InputDecoration(
                        fillColor: Color.fromRGBO(35, 59, 111, 0.08),
                        filled: true,
                        hintText: 'Search City',
                        prefixIcon: Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Hot",
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("deals",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 24)),
                        ],
                      ),
                      GestureDetector(
                        child: Text("view all"),
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Navigator.of(context)
                              .pushNamed(AllCarsScreen.routeName);
                        },
                      )
                    ],
                  ),
                ),
                HotDealsCarsList(size: size, cars: cars),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, top: 30, bottom: 10, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Top",
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("dealers",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 24)),
                        ],
                      ),
                      GestureDetector(
                        child: Text("view all"),
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Navigator.of(context)
                              .pushNamed(AllCompanysScreen.routeName);
                        },
                      )
                    ],
                  ),
                ),
                TopDealersList(size: size, companys: companys),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
