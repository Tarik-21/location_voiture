import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location_app/models/http_exception.dart';
import 'package:location_app/providers/auth.dart';
import 'package:location_app/widgets/border_color.dart';
import 'package:provider/provider.dart';
import 'controllerPage.dart';
import '../screens/signup_screen.dart';

import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/Login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool isErrorEmailInput = false;
  bool isErrorPasswordInput = false;

  bool isPasswordVisible = false;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  var _isLoading = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              setState(() {
                _isLoading = false;
              });
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

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
      await Provider.of<Auth>(context, listen: false).login(
        _authData['email'],
        _authData['password'],
      );
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        //   elevation: 0,
        //   actions: [
        //     GestureDetector(
        //         onTap: () {
        //           Navigator.of(context)
        //               .pushReplacementNamed(ControllerPage.routeName);
        //         },
        //         child: Padding(
        //           padding: EdgeInsets.all(15),
        //           child: Text(
        //             "Skip",
        //             style: TextStyle(
        //                 color: Theme.of(context).primaryColor,
        //                 fontSize: 20,
        //                 fontWeight: FontWeight.bold),
        //           ),
        //         ))
        //   ],
        // ),
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: size.width,
                height: size.height * 0.35,
                child: Image.asset(
                  "assets/images/intro.png",
                ),
              ),
              Container(
                width: double.infinity,
                height: size.height * 0.58,
                child: Form(
                  key: _formKey,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Icon(
                                Icons.email,
                                color: isErrorEmailInput
                                    ? Colors.red
                                    : Theme.of(context).primaryColor,
                              ),
                            ),
                            hintText: "Email",
                            focusedBorder:
                                borderColor(Theme.of(context).primaryColor),
                            enabledBorder:
                                borderColor(Theme.of(context).primaryColor),
                            errorBorder: borderColor(Colors.red),
                            focusedErrorBorder: borderColor(Colors.red),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty) {
                              setState(() {
                                isErrorEmailInput = true;
                              });
                              return "Empty fields";
                            } else if (!EmailValidator.validate(value)) {
                              setState(() {
                                isErrorEmailInput = true;
                              });
                              return "Invalid email";
                            }
                            setState(() {
                              isErrorEmailInput = false;
                            });
                            return null;
                          },
                          onSaved: (value) {
                            _authData['email'] = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Icon(
                                Icons.lock,
                                color: isErrorPasswordInput
                                    ? Colors.red
                                    : Theme.of(context).primaryColor,
                              ),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(2),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                                child: Icon(
                                  isPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: isErrorPasswordInput
                                      ? Colors.red
                                      : Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            hintText: "Password",
                            focusedBorder:
                                borderColor(Theme.of(context).primaryColor),
                            enabledBorder:
                                borderColor(Theme.of(context).primaryColor),
                            errorBorder: borderColor(Colors.red),
                            focusedErrorBorder: borderColor(Colors.red),
                          ),
                          obscureText: !isPasswordVisible,
                          validator: (value) {
                            if (value.isEmpty) {
                              setState(() {
                                isErrorPasswordInput = true;
                              });
                              return 'Empty fields';
                            } else if (value.length < 5) {
                              setState(() {
                                isErrorPasswordInput = true;
                              });
                              return 'Password is too short!';
                            }
                            setState(() {
                              isErrorPasswordInput = false;
                            });
                            return null;
                          },
                          onSaved: (value) {
                            _authData['password'] = value;
                          },
                        ),
                      ),
                      if (_isLoading)
                        Center(
                            child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor),
                        ))
                      else
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: ConstrainedBox(
                            constraints:
                                const BoxConstraints.tightFor(height: 50),
                            child: ElevatedButton(
                              onPressed: () {
                                _submit();
                              },
                              child: const Text(
                                "Log in",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20))),
                              ),
                            ),
                          ),
                        ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 15, vertical: 5),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //     children: [
                      //       Container(
                      //         height: 2,
                      //         width: size.width * 0.4,
                      //         color: Colors.grey[200],
                      //       ),
                      //       const Text(
                      //         "Or",
                      //         style: TextStyle(
                      //             color: Colors.black54,
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 16),
                      //       ),
                      //       Container(
                      //         height: 2,
                      //         width: size.width * 0.4,
                      //         color: Colors.grey[200],
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 15),
                      //   child: Material(
                      //     borderRadius: BorderRadius.circular(20),
                      //     color: const Color.fromRGBO(220, 220, 220, 1),
                      //     child: InkWell(
                      //       borderRadius: BorderRadius.circular(20),
                      //       onTap: () {},
                      //       child: ClipRRect(
                      //         borderRadius: BorderRadius.circular(20),
                      //         child: Container(
                      //           width: size.width,
                      //           height: 50,
                      //           color: Colors.transparent,
                      //           child: Row(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.center,
                      //             children: [
                      //               Image.asset(
                      //                 "assets/images/google_icon.png",
                      //                 width: 30,
                      //               ),
                      //               const SizedBox(
                      //                 width: 15,
                      //               ),
                      //               const Text(
                      //                 "Log in with Google",
                      //                 style: TextStyle(fontSize: 16),
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                        color: Color.fromRGBO(82, 82, 82, 1), fontSize: 16),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(SignupScreen.routeName);
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
