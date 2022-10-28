// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_course_app/Utils/util.dart';
import 'package:pro_course_app/const/app_colors.dart';
import 'package:pro_course_app/provider/auth_provider.dart';
import 'package:pro_course_app/view/home_page.dart';
import 'package:pro_course_app/view/profile._page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/fire_base_const.dart';
import '../view/login/login_page.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  void initState() {
    authProvider = context.read<AuthProvider>();
    geuserdetails();
    // TODO: implement initState
    super.initState();
  }

  String displayName = "";
  String email = "";
  String photourl = "";

  geuserdetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      displayName = (prefs.getString(FirestoreConstants.displayName) ?? "");
      photourl = (prefs.getString(FirestoreConstants.photoUrl) ?? "");
      email = (prefs.getString(FirestoreConstants.email) ?? "");
    });
  }

  late AuthProvider authProvider;

  Future<void> googleSignOut() async {
    await authProvider.googleSignOut();
    await authProvider.firebaseAuth.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        UserAccountsDrawerHeader(
          decoration: const BoxDecoration(
            color: AppColors.indyBlue,
          ),
          currentAccountPicture: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: photourl == ""
                  ? Image.asset("assets/images/user.png")
                  : Image.network(photourl)),
          accountName: Roboto(
            color: Colors.white,
            size: 20,
            text: displayName,
          ),
          accountEmail: Roboto(
            color: Colors.white,
            size: 15,
            text: email,
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.home,
          ),
          title: const Roboto(
            color: Colors.black,
            size: 15,
            text: "Home Page",
          ),
          onTap: () {
            Navigator.pop(context);
            UtilFunctions.navigateTo(context, const HomePage());
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.people,
          ),
          title: const Roboto(
            color: Colors.black,
            size: 15,
            text: "Profile",
          ),
          onTap: () {
            Navigator.pop(context);
            UtilFunctions.navigateTo(context, const ProfilePage());
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.logout_sharp,
          ),
          title: const Roboto(
            color: Colors.black,
            size: 15,
            text: "LogOut",
          ),
          onTap: () async {
            googleSignOut();
            Navigator.pop(context);
          },
        )
      ]),
    );
  }
}

class Roboto extends StatelessWidget {
  final String text;
  final double size;
  final Color color;

  const Roboto({
    Key? key,
    required this.text,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.roboto(
            color: color, fontSize: size, fontWeight: FontWeight.normal));
  }
}
