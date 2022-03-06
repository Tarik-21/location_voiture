import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_app/providers/Cars.dart';
import 'package:location_app/providers/car.dart';
import 'package:location_app/providers/company.dart';
import 'package:location_app/providers/feedbacks.dart';
import 'package:location_app/widgets/list_cars.dart';
import 'package:location_app/widgets/list_comment.dart';
import 'package:provider/provider.dart';

class CompanyDetailsScreen extends StatefulWidget {
  static const routeName = '/company-details';

  @override
  _CompanyDetailsScreenState createState() => _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends State<CompanyDetailsScreen> {
  Set<Marker> _markers = {};
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      final company = ModalRoute.of(context).settings.arguments as Company;

      Provider.of<FeedBacks>(context)
          .getAllCommentCompany(company.id)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((error) => print("Error"));
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final company = ModalRoute.of(context).settings.arguments as Company;

    final feedbackData = Provider.of<FeedBacks>(context);
    final feedBackscompany = feedbackData.feedbackscompany;

    List<Car> cars = Provider.of<Cars>(context).findbyIdCompany(company.id);

    void _onMapCreated(GoogleMapController controller) {
      setState(() {
        _markers.add(Marker(
            markerId: MarkerId('id1'),
            position: LatLng(
                company.position["latitude"], company.position["longitude"])));
      });
    }

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Informations about company"),
          bottom: const TabBar(tabs: [
            Tab(
              icon: Icon(
                Icons.description_sharp,
              ),
              text: "Details",
            ),
            Tab(
              icon: Icon(
                Icons.car_rental,
              ),
              text: "Offers",
            ),
            Tab(
              icon: Icon(
                Icons.map_outlined,
              ),
              text: "Card",
            ),
            Tab(
              icon: Icon(
                Icons.message,
              ),
              text: "Comment",
            ),
          ]),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Column(
              children: [
                Container(
                  width: size.width,
                  height: size.height * 0.1,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Container(
                          width: size.width * 0.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                company.imageUrl,
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: 4),
                            child: Text(
                              company.rate.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Excelent",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text("according to our clients")
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            ListCars(height: size.height, size: size, cars: cars),
            GoogleMap(
              onMapCreated: _onMapCreated,
              markers: _markers,
              initialCameraPosition: CameraPosition(
                target: LatLng(company.position["latitude"],
                    company.position["longitude"]),
                zoom: 15,
              ),
            ),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    ),
                  )
                : feedBackscompany.length == 0
                    ? Center(
                        child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              width: size.width * 0.4,
                              child: Image.asset("assets/images/comment.png"),
                            ),
                          ),
                          Text(
                            "No Comment",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ))
                    : ListComment(
                        size: size,
                        liste: feedBackscompany,
                      ),
          ],
        ),
      ),
    );
  }
}
