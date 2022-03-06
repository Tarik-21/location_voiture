import 'package:flutter/material.dart';
import 'package:location_app/providers/Cars.dart';
import 'package:location_app/providers/companys.dart';
import 'package:location_app/providers/reservation.dart';
import 'package:location_app/screens/favorite_screen.dart';
import 'package:provider/provider.dart';

import '../screens/home_page_screen.dart';
import '../screens/profile_page_screen.dart';
import '../screens/reservation_page_screen.dart';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class ControllerPage extends StatefulWidget {
  static const routeName = '/home';

  @override
  _ControllerPageState createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Future.wait([
        Provider.of<Companys>(context).fetchCompanys(),
        Provider.of<Cars>(context).fetchAllCars(),
        Provider.of<Reservation>(context).fetchReservation(),
        //Provider.of<Auth>(context).getUserData(),
      ]).then((_) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((error) => print(error));
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  int currentIndex = 0;
  List listofPages = [
    HomeScreen(),
    ReservationScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];
  List titles = [
    HomeScreen.title,
    ReservationScreen.title,
    FavoriteScreen.title,
    ProfileScreen.title
  ];

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
            ),
          )
        : Scaffold(
            appBar: titles[currentIndex] != ""
                ? AppBar(
                    //elevation: 0,
                    //backgroundColor: Color.fromRGBO(250, 250, 250, 1),
                    title: Text(
                    titles[currentIndex],
                    style: TextStyle(
                        //color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ))
                : AppBar(
                    elevation: 0,
                    backgroundColor: Color.fromRGBO(250, 250, 250, 1),
                  ),
            body: listofPages[currentIndex],
            bottomNavigationBar: BottomNavyBar(
              selectedIndex: currentIndex,
              onItemSelected: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              items: <BottomNavyBarItem>[
                BottomNavyBarItem(
                  icon: Icon(Icons.home),
                  title: Text("Home"),
                  activeColor: Theme.of(context).primaryColor,
                  inactiveColor: Colors.black,
                ),
                BottomNavyBarItem(
                  icon: Icon(Icons.calendar_today),
                  title: Text("Reservation"),
                  activeColor: Theme.of(context).primaryColor,
                  inactiveColor: Colors.black,
                ),
                BottomNavyBarItem(
                  icon: Icon(Icons.favorite),
                  title: Text("Favorite"),
                  activeColor: Theme.of(context).primaryColor,
                  inactiveColor: Colors.black,
                ),
                BottomNavyBarItem(
                  icon: Icon(Icons.person),
                  title: Text("Profile"),
                  activeColor: Theme.of(context).primaryColor,
                  inactiveColor: Colors.black,
                ),
              ],
            ),
          );
  }
}
