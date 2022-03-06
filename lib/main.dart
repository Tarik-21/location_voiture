import 'package:flutter/material.dart';
import 'package:location_app/providers/auth.dart';
import 'package:location_app/providers/companys.dart';
import 'package:location_app/providers/feedbacks.dart';
import 'package:location_app/providers/reservation.dart';
import 'package:location_app/screens/all_cars_screen.dart';
import 'package:location_app/screens/all_companys_screen.dart';
import 'package:location_app/screens/car_comment_screen.dart';
import 'package:location_app/screens/car_details.dart';
import 'package:location_app/screens/company_details_screen.dart';
import 'package:location_app/screens/favorite_screen.dart';
import 'package:location_app/screens/feedback_screen.dart';
import 'package:location_app/screens/profile_page_screen.dart';
import 'package:location_app/screens/reservation_details.dart';
import 'providers/Cars.dart';
import 'package:provider/provider.dart';
import 'screens/controllerPage.dart';
import './screens/signup_screen.dart';
import './screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProxyProvider<Auth, Cars>(
            update: (ctx, auth, previousCars) => Cars(auth.token, auth.userId,
                previousCars == null ? [] : previousCars.voitures),
            create: (ctx) => Cars(null, null, []),
          ),
          ChangeNotifierProxyProvider<Auth, Companys>(
            update: (ctx, auth, previousCompanys) => Companys(auth.token,
                previousCompanys == null ? [] : previousCompanys.companys),
            create: (ctx) => Companys(null, []),
          ),
          ChangeNotifierProxyProvider<Auth, Reservation>(
            update: (ctx, auth, previousReservation) =>
                Reservation(auth.token, auth.userId),
            create: (ctx) => Reservation(null, null),
          ),
          ChangeNotifierProxyProvider<Auth, FeedBacks>(
            update: (ctx, auth, previousFeedbacks) => FeedBacks(
                auth.token,
                previousFeedbacks == null ? [] : previousFeedbacks.feedbackscar,
                previousFeedbacks == null
                    ? []
                    : previousFeedbacks.feedbackscompany),
            create: (ctx) => FeedBacks(null, [], []),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primaryColor: Color.fromRGBO(35, 59, 111, 1),
              primarySwatch: Colors.indigo,
            ),
            home: auth.isAuth ? ControllerPage() : LoginScreen(),
            routes: {
              LoginScreen.routeName: (ctx) => LoginScreen(),
              SignupScreen.routeName: (ctx) => SignupScreen(),
              ControllerPage.routeName: (ctx) => ControllerPage(),
              AllCarsScreen.routeName: (ctx) => AllCarsScreen(),
              FavoriteScreen.routeName: (ctx) => FavoriteScreen(),
              CarDetailsScreen.routeName: (ctx) => CarDetailsScreen(),
              AllCompanysScreen.routeName: (ctx) => AllCompanysScreen(),
              CompanyDetailsScreen.routeName: (ctx) => CompanyDetailsScreen(),
              ReservationCar.routeName: (ctx) => ReservationCar(),
              ProfileScreen.routeName: (ctx) => ProfileScreen(),
              FeedBackScreen.routeName: (ctx) => FeedBackScreen(),
              CarComment.routeName: (ctx) => CarComment(),
            },
          ),
        ));
  }
}
