import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'component.dart';
import 'course_list.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _email = TextEditingController();

  final _password = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

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
                  cotrollers: _email,
                  label: "Email",
                  hinttext: "Enter your email address",
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
                          .signInWithEmailAndPassword(
                              email: _email.text, password: _password.text);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const CourseList();
                      }));
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
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
                      "Sign In",
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
