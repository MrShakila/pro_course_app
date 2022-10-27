import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../Utils/component.dart';
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
        _repeatpasswordord.text.isEmpty) {
      return false;
    } else if (_email.text.contains("@") && _email.text.contains(".com")) {
      return false;
    } else if (_password.text.length <= 10) {
      return false;
    } else if (_password.text == _repeatpasswordord.text) {
      return true;
    } else {
      return true;
    }
  }

  final _email = TextEditingController();
  final _firstname = TextEditingController();
  final _lastname = TextEditingController();
  final _birthday = TextEditingController();
  final _school = TextEditingController();
  final _address = TextEditingController();
  final _phonenumber = TextEditingController();
  final _password = TextEditingController();
  final _repeatpasswordord = TextEditingController();

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
            const Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 100,
                height: 100,
                child: Icon(
                  Icons.my_library_books_outlined,
                  size: 50,
                ),
              ),
            ),
            const HeightSizedBox(),
            Align(
              alignment: Alignment.center,
              child: Text("Lets Sign Up",
                  style: GoogleFonts.lobster(
                      color: Colors.deepPurpleAccent,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
            ),
            const HeightSizedBox(),
            Formtextfield(
              cotrollers: _firstname,
              label: "First Name",
              hinttext: "Enter your First Name",
            ),
            const HeightSizedBox(),
            Formtextfield(
              cotrollers: _lastname,
              label: "Last Name",
              hinttext: "Enter your Last Name",
            ),
            const HeightSizedBox(),
            Formtextfield(
              cotrollers: _email,
              label: "Email",
              hinttext: "Enter your email address",
            ),
            const HeightSizedBox(),
            Formtextfield(
              cotrollers: _birthday,
              label: "Birthday",
              hinttext: "Enter your Birthday ",
            ),
            const HeightSizedBox(),
            Formtextfield(
              cotrollers: _address,
              label: "enter Your School ",
              hinttext: "Enter your School",
            ),
            const HeightSizedBox(),
            Formtextfield(
              cotrollers: _address,
              label: "enter Your Address ",
              hinttext: "Enter your Address Number",
            ),
            const HeightSizedBox(),
            Formtextfield(
              cotrollers: _phonenumber,
              label: "Mobile Numeber",
              hinttext: "Enter your Mobile Number",
            ),
            const HeightSizedBox(),
            Formtextfield(
              cotrollers: _password,
              label: "Password",
              hinttext: "Enter your password",
            ),
            const HeightSizedBox(),
            Formtextfield(
              cotrollers: _repeatpasswordord,
              label: "Repeat Password",
              hinttext: "Enter your password again",
            ),
            const HeightSizedBox(),
            Center(
                child: GestureDetector(
              onTap: () async {
                try {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _email.text, password: _password.text);
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const HomePage();
                    },
                  ));
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(25)),
                width: 100,
                height: 40,
                child: Center(
                    child: Text(
                  "Sign Up",
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ))
          ],
        ),
      )),
    );
  }
}
