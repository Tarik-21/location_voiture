import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:location_app/providers/auth.dart';
import 'package:location_app/providers/car.dart';
import 'package:location_app/providers/feedbacks.dart';
import 'package:location_app/widgets/border_color.dart';
import 'package:provider/provider.dart';

class FeedBackScreen extends StatefulWidget {
  static const routeName = '/feedback-Screen';

  @override
  _FeedBackScreenState createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;

  Map<String, dynamic> _userData = {
    'carComment': '',
    'carRate': 2,
    'companyComment': '',
    'companyRate': 2
  };

  Future<void> _submit(
      String id_car, String id_company, String fullname) async {
    if (!_formKey.currentState.validate()) {
      //Invalid
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    FocusManager.instance.primaryFocus?.unfocus();

    await Provider.of<FeedBacks>(context, listen: false).addFeedBack(
        id_car,
        id_company,
        fullname,
        _userData['carComment'],
        _userData['carRate'].toInt(),
        _userData['companyComment'],
        _userData['companyRate'].toInt());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final car = ModalRoute.of(context).settings.arguments as Car;
    final username = Provider.of<Auth>(context, listen: false).fullname;

    return Scaffold(
      appBar: AppBar(
        title: Text("Give your feedback"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        "About car :",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: RatingBar.builder(
                          initialRating: 1,
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: 24,
                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (ctx, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            _userData['carRate'] = rating * 2;
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    minLines: 2,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: "Car feedback",
                      focusedBorder:
                          borderColor(Theme.of(context).primaryColor),
                      enabledBorder:
                          borderColor(Theme.of(context).primaryColor),
                      errorBorder: borderColor(Colors.red),
                      focusedErrorBorder: borderColor(Colors.red),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Empty fields";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userData['carComment'] = value;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text(
                        "About Company :",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: RatingBar.builder(
                          initialRating: 1,
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: 24,
                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (ctx, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            _userData['companyRate'] = rating.toInt() * 2;
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    minLines: 2,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: "Company feedback",
                      focusedBorder:
                          borderColor(Theme.of(context).primaryColor),
                      enabledBorder:
                          borderColor(Theme.of(context).primaryColor),
                      errorBorder: borderColor(Colors.red),
                      focusedErrorBorder: borderColor(Colors.red),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Empty fields";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userData['companyComment'] = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (_isLoading)
                    Center(
                        child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    ))
                  else
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(height: 40),
                        child: ElevatedButton(
                          onPressed: () {
                            _submit(car.id, car.id_company, username);
                            //Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: const Text(
                              "Send",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
