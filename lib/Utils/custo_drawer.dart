// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_course_app/Utils/util.dart';
import 'package:pro_course_app/provider/auth_provider.dart';
import 'package:pro_course_app/view/home_page.dart';
import 'package:pro_course_app/view/profile._page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    getdocdetails();
    // TODO: implement initState
    super.initState();
  }

  String accessToken = "";
  String docemail = "";
  String docname = "";
  String doctelephone = "";
  String docspecialization = "";
  String docslmc = "";

  getdocdetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = (prefs.getString('acessToken') ?? "");
      docname = (prefs.getString("DocName") ?? "");
      docemail = (prefs.getString("DocEmail") ?? "");
      doctelephone = (prefs.getString("DocTelephone") ?? "");
      docspecialization = (prefs.getString("Docspecialization") ?? "");
      docslmc = (prefs.getString("DocSLMC") ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.lightBlue,
            ),
            // currentAccountPicture: ClipRRect(
            //     borderRadius: BorderRadius.circular(25),
            //     child: Image.asset("asset/image/User.png")),
            accountName: Roboto(
              color: Colors.white,
              size: 20,
              text: docname,
            ),
            accountEmail: Roboto(
              color: Colors.white,
              size: 15,
              text: docemail,
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
          // ListTile(
          //   leading: const Icon(
          //     Icons.document_scanner,
          //   ),
          //   title: const Roboto(
          //     color: Colors.black,
          //     size: 15,
          //     text: "Shared Documents",

          //   ),
          //   onTap: () {
          //     Navigator.pop(context);
          //     UtilFunctions.navigateTo(context, const SharedDocuments());
          //   },
          // ),
          Consumer<AuthProvider>(
            builder: ((context, auth, child) {
              return ListTile(
                leading: const Icon(
                  Icons.logout_sharp,
                ),
                title: const Roboto(
                  color: Colors.black,
                  size: 15,
                  text: "LogOut",
                ),
                onTap: () async {
                  auth.googleSignOut();
                  Navigator.pop(context);
                },
              );
            }),
          )
        ],
      ),
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
