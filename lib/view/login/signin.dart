import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pro_course_app/Utils/util.dart';
import 'package:pro_course_app/view/login/signup.dart';
import 'package:provider/provider.dart';
import '../../Utils/component.dart';
import '../../course_list.dart';
import '../../provider/auth_provider.dart';
import '../home_page.dart';

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
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: Text("Welcome back",
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
                        return const HomePage();
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
                )),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () async {
                      bool isSuccess = await authProvider.handleGoogleSignIn();
                      if (isSuccess) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CourseList()));
                      }
                    },
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(25)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Sign In with google",
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      UtilFunctions.navigateTo(context, const SignUp());
                    },
                    child: Text("Dont Have account? Lets sign in",
                        style: GoogleFonts.roboto(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
