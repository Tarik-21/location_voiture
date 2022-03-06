import 'package:flutter/material.dart';
import 'package:location_app/providers/auth.dart';
import 'package:location_app/widgets/border_color.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/Profile-Screen';
  static const title = 'Profile';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  var _isLoading = false;
  Map<String, String> _userData = {
    'fullName': '',
    'street': '',
    'postalCode': '',
    'city': '',
    'country': '',
    'nationality': '',
    'cni': '',
    'phoneNumber': '',
  };

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      //Invalid
      return;
    }

    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).EditUserData(_userData);
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    var title = ModalRoute.of(context).settings.arguments as String;
    var appBar = AppBar(title: Text(title == null ? '' : title));
    print(title);
    var authdata = Provider.of<Auth>(context, listen: false);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: title == null ? null : appBar,
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: _formKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 2,
                ),
                TextFormField(
                  initialValue:
                      authdata.fullname == null ? '' : authdata.fullname,
                  decoration: InputDecoration(
                    labelText: "Full name",
                    focusedBorder: borderColor(Theme.of(context).primaryColor),
                    enabledBorder: borderColor(Theme.of(context).primaryColor),
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
                    _userData['fullName'] = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: authdata.street == null ? '' : authdata.street,
                  decoration: InputDecoration(
                    labelText: "Street number and name",
                    focusedBorder: borderColor(Theme.of(context).primaryColor),
                    enabledBorder: borderColor(Theme.of(context).primaryColor),
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
                    _userData['street'] = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        initialValue: authdata.postalCode == null
                            ? ''
                            : authdata.postalCode.toString(),
                        decoration: InputDecoration(
                          labelText: "Postal Code",
                          focusedBorder:
                              borderColor(Theme.of(context).primaryColor),
                          enabledBorder:
                              borderColor(Theme.of(context).primaryColor),
                          errorBorder: borderColor(Colors.red),
                          focusedErrorBorder: borderColor(Colors.red),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Empty fields";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userData['postalCode'] = value;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        initialValue:
                            authdata.city == null ? '' : authdata.city,
                        decoration: InputDecoration(
                          labelText: "City",
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
                          _userData['city'] = value;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue:
                      authdata.country == null ? '' : authdata.country,
                  decoration: InputDecoration(
                    labelText: "Country",
                    focusedBorder: borderColor(Theme.of(context).primaryColor),
                    enabledBorder: borderColor(Theme.of(context).primaryColor),
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
                    _userData['country'] = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue:
                      authdata.nationality == null ? '' : authdata.nationality,
                  decoration: InputDecoration(
                    labelText: "Nationality",
                    focusedBorder: borderColor(Theme.of(context).primaryColor),
                    enabledBorder: borderColor(Theme.of(context).primaryColor),
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
                    _userData['nationality'] = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: authdata.cni == null ? '' : authdata.cni,
                  decoration: InputDecoration(
                    labelText: "National identification number",
                    focusedBorder: borderColor(Theme.of(context).primaryColor),
                    enabledBorder: borderColor(Theme.of(context).primaryColor),
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
                    _userData['cni'] = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue:
                      authdata.phoneNumber == null ? '' : authdata.phoneNumber,
                  decoration: InputDecoration(
                    labelText: "Phone number",
                    focusedBorder: borderColor(Theme.of(context).primaryColor),
                    enabledBorder: borderColor(Theme.of(context).primaryColor),
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
                    _userData['phoneNumber'] = value;
                  },
                  keyboardType: TextInputType.phone,
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
                        onPressed: () async {
                          await _submit();
                          if (title != null) Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
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
                SizedBox(
                  height: 10,
                ),
                if (title == null)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(height: 40),
                      child: ElevatedButton(
                        onPressed: () {
                          Provider.of<Auth>(context, listen: false).logout();
                        },
                        child: const Text(
                          "Log out",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
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
    );
  }
}
