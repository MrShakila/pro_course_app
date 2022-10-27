import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../../Utils/common_widget.dart';
import '../../Utils/component.dart';
import '../../Utils/util.dart';
import '../../const/app_colors.dart';
import '../../provider/auth_provider.dart';
import '../home_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool validateField() {
    if (_email.text.isEmpty ||
        _password.text.isEmpty ||
        _firstname.text.isEmpty ||
        _lastname.text.isEmpty ||
        _school.text.isEmpty ||
        _phonenumber.text.isEmpty ||
        _password.text.isEmpty ||
        _repeatpasswordord.text.isEmpty) {
      alertDialog(context, "Empty Field", "Please fill All the Fields");
      return false;
    } else if (!EmailValidator.validate(_email.text)) {
      Logger().e(_email.text);
      alertDialog(context, "Invalid Email", "Please enter Valid email");
      return false;
    } else if (_phonenumber.text.length != 10) {
      alertDialog(
          context, "Invalid mobile Number", "Please enter Valid mobile Number");
      return false;
    } else if (_password.text.length <= 10) {
      alertDialog(context, "Password isnt secured",
          "Please enter secured Password using numbers,strings,symbols with more than 10");
      return false;
    } else if (_password.text != _repeatpasswordord.text) {
      alertDialog(
          context, "Password didnt match", "Please enter valid passowrd");
      return true;
    } else {
      return true;
    }
  }

  final _email = TextEditingController();
  final _firstname = TextEditingController();
  final _lastname = TextEditingController();
  final _school = TextEditingController();
  final _phonenumber = TextEditingController();
  final _password = TextEditingController();
  final _repeatpasswordord = TextEditingController();
  String birthday = "";
  String latitude = "";
  String longitude = "";
  String age = "";
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    switch (authProvider.status) {
      case Status.authenticateError:
        Fluttertoast.showToast(msg: 'Sign in failed');
        break;
      case Status.authenticateCanceled:
        Fluttertoast.showToast(msg: 'Sign in cancelled');
        break;
      case Status.authenticated:
        Fluttertoast.showToast(msg: 'Sign in successful');
        break;
      default:
        break;
    }

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            const HeightSizedBox(),
            Align(
              alignment: Alignment.center,
              child: Text("Lets Sign Up",
                  style: GoogleFonts.lobster(
                      color: AppColors.indyBlue,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
            ),
            const HeightSizedBox(),
            Row(
              children: [
                Expanded(
                  child: Formtextfield(
                    cotrollers: _firstname,
                    label: "First Name",
                    hinttext: "Enter your First Name",
                  ),
                ),
                Expanded(
                  child: Formtextfield(
                    cotrollers: _lastname,
                    label: "Last Name",
                    hinttext: "Enter your Last Name",
                  ),
                ),
              ],
            ),
            const HeightSizedBox(),
            Formtextfield(
              cotrollers: _email,
              label: "Email",
              hinttext: "Enter your email address",
            ),
            const HeightSizedBox(),
            Formtextfield(
              cotrollers: _school,
              label: "School",
              hinttext: "Enter your School",
            ),
            const HeightSizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                  controller: _phonenumber,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Mobile Number",
                      hintText: "Please Enter your Mobile Number",
                      labelStyle: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)))),
            ),
            const HeightSizedBox(),
            Formtextfield(
              keyboardType: TextInputType.visiblePassword,
              isSecure: true,
              cotrollers: _password,
              label: "Password",
              hinttext: "Enter your password",
            ),
            const HeightSizedBox(),
            Formtextfield(
              isSecure: true,
              cotrollers: _repeatpasswordord,
              label: "Repeat Password",
              hinttext: "Enter your password again",
            ),
            const HeightSizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      var birth = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now());
                      Logger().wtf(birthday);
                      setState(() {
                        birthday = birth.toString();
                        Logger().wtf(birthday);
                      });
                    },
                    child: const Text("Select Your Birthday")),
                ElevatedButton(
                    onPressed: () async {
                      var position = await _determinePosition();
                      setState(() {
                        latitude = position.latitude.toString();
                        longitude = position.longitude.toString();
                      });
                    },
                    child: const Text("Select Your Address"))
              ],
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    if (validateField()) {
                      bool isSuccess = await authProvider.handleSignUp(
                          _email.text,
                          _password.text,
                          _firstname.text,
                          _lastname.text,
                          _phonenumber.text,
                          _school.text,
                          birthday,
                          age,
                          latitude,
                          longitude);

                      if (isSuccess) {
                        // ignore: use_build_context_synchronously
                        UtilFunctions.pushRemoveNavigation(
                            context, const HomePage());
                      } else {
                        // ignore: use_build_context_synchronously
                        alertDialog(
                            context, "Something Wrong", "Please Try Again");
                      }
                    }
                  },
                  child: const Text("Sign Up")),
            ),
          ],
        ),
      )),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
