import 'package:flutter/material.dart';

class UtilFunctions {
  //navigation function
  static void navigateTo(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => widget,
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (BuildContext, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      ),
      // builder: (context) => widget
    );
  }

  //go back function
  static void goBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void pushRemoveNavigation(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => widget), ((route) => false));
  }
}


// FirebaseFirestore.instance
//         .collection('users')
//         .where('invitation_code', isEqualTo: inputCode)
//         .get()
//         .then((value) {
//       if (value.docs.isNotEmpty) {
//         // return true;
//       } else {
//         // return false;
//       }
//     });