import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'component.dart';
import 'course_list.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool validateField() {
    if (_email.text.isEmpty ||
        _password.text.isEmpty ||
        _username.text.isEmpty ||
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
  final _username = TextEditingController();
  final _phonenumber = TextEditingController();
  final _password = TextEditingController();
  final _repeatpasswordord = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Opacity(
              opacity: 0.2,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  "asset/pexels-guillaume-hankenne-2792025.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      "asset/125.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const HeightSizedBox(),
                Align(
                  alignment: Alignment.center,
                  child: Text("Inspiration",
                      style: GoogleFonts.lobster(
                          color: Colors.deepPurpleAccent,
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                ),
                const HeightSizedBox(),
                Formtextfield(
                  cotrollers: _username,
                  label: "User Name",
                  hinttext: "Enter your User Name",
                ),
                const HeightSizedBox(),
                Formtextfield(
                  cotrollers: _email,
                  label: "Email",
                  hinttext: "Enter your email address",
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
                  hinttext: "Enter your password ",
                ),
                const HeightSizedBox(),
                Center(
                    child: GestureDetector(
                  onTap: () async {
                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .createUserWithEmailAndPassword(
                              email: _email.text, password: _password.text);
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const CourseList();
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
            )
          ],
        ),
      ),
    );
  }
}
