import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pro_course_app/model/chat_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/fire_base_const.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  authenticateError,
  authenticateCanceled,
}

class AuthProvider extends ChangeNotifier {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final SharedPreferences prefs;

  Status _status = Status.uninitialized;

  Status get status => _status;

  bool _isLoading = false;

  void setIsLOading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  AuthProvider(
      {required this.googleSignIn,
      required this.firebaseAuth,
      required this.firebaseFirestore,
      required this.prefs});

  String? getFirebaseUserId() {
    return prefs.getString(FirestoreConstants.id);
  }

  Future<bool> isLoggedIn() async {
    bool isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn &&
        prefs.getString(FirestoreConstants.id)?.isNotEmpty == true) {
      return true;
    } else {
      return false;
    }
  }

  agecalculate(String age) {
    int patientage = int.parse(age);
    int today = int.parse(DateTime.now().year.toString());
    int hisage = today - patientage;
    return hisage;
  }

  Future<bool> handleGoogleSignIn() async {
    setIsLOading(true);
    _status = Status.authenticating;
    notifyListeners();

    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      User? firebaseUser =
          (await firebaseAuth.signInWithCredential(credential)).user;

      if (firebaseUser != null) {
        final QuerySnapshot result = await firebaseFirestore
            .collection(FirestoreConstants.pathUserCollection)
            .where(FirestoreConstants.id, isEqualTo: firebaseUser.uid)
            .get();
        final List<DocumentSnapshot> document = result.docs;
        if (document.isEmpty) {
          firebaseFirestore
              .collection(FirestoreConstants.pathUserCollection)
              .doc(firebaseUser.uid)
              .set({
            FirestoreConstants.displayName: firebaseUser.displayName,
            FirestoreConstants.photoUrl: firebaseUser.photoURL,
            FirestoreConstants.id: firebaseUser.uid,
            "createdAt: ": DateTime.now().millisecondsSinceEpoch.toString(),
            FirestoreConstants.chattingWith: null
          });

          User? currentUser = firebaseUser;
          await prefs.setString(FirestoreConstants.id, currentUser.uid);
          await prefs.setString(
              FirestoreConstants.displayName, currentUser.displayName ?? "");
          await prefs.setString(
              FirestoreConstants.photoUrl, currentUser.photoURL ?? "");
          await prefs.setString(
              FirestoreConstants.email, currentUser.email ?? "");
          await prefs.setString(
              FirestoreConstants.phoneNumber, currentUser.phoneNumber ?? "");
        } else {
          DocumentSnapshot documentSnapshot = document[0];
          ChatUser userChat = ChatUser.fromDocument(documentSnapshot);
          await prefs.setString(FirestoreConstants.id, userChat.id);
          await prefs.setString(
              FirestoreConstants.displayName, userChat.displayName);
          await prefs.setString(FirestoreConstants.aboutMe, userChat.aboutMe);
          await prefs.setString(
              FirestoreConstants.phoneNumber, userChat.phoneNumber);
        }
        _status = Status.authenticated;
        notifyListeners();
        setIsLOading(false);
        return true;
      } else {
        _status = Status.authenticateError;
        notifyListeners();
        setIsLOading(false);
        return false;
      }
    } else {
      _status = Status.authenticateCanceled;
      notifyListeners();
      setIsLOading(false);
      return false;
    }
  }

  Future<bool> handleSignInEmail(String email, String password) async {
    _status = Status.authenticating;
    notifyListeners();
    setIsLOading(true);
    try {
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final User user = result.user!;
      if (user != null) {
        final QuerySnapshot result = await firebaseFirestore
            .collection(FirestoreConstants.pathUserCollection)
            .where(FirestoreConstants.id, isEqualTo: user.uid)
            .get();
        final List<DocumentSnapshot> document = result.docs;
        if (document.isEmpty) {
          firebaseFirestore
              .collection(FirestoreConstants.pathUserCollection)
              .doc(user.uid)
              .set({
            FirestoreConstants.displayName: user.displayName,
            FirestoreConstants.photoUrl: user.photoURL,
            FirestoreConstants.id: user.uid,
            "createdAt: ": DateTime.now().millisecondsSinceEpoch.toString(),
            FirestoreConstants.chattingWith: null
          });

          User? currentUser = user;
          await prefs.setString(FirestoreConstants.id, currentUser.uid);
          await prefs.setString(
              FirestoreConstants.displayName, currentUser.displayName ?? "");
          await prefs.setString(
              FirestoreConstants.photoUrl, currentUser.photoURL ?? "");
          await prefs.setString(
              FirestoreConstants.phoneNumber, currentUser.phoneNumber ?? "");
        } else {
          DocumentSnapshot documentSnapshot = document[0];
          ChatUser userChat = ChatUser.fromDocument(documentSnapshot);
          await prefs.setString(FirestoreConstants.id, userChat.id);
          await prefs.setString(
              FirestoreConstants.displayName, userChat.displayName);
          await prefs.setString(FirestoreConstants.aboutMe, userChat.aboutMe);
          await prefs.setString(
              FirestoreConstants.phoneNumber, userChat.phoneNumber);
        }
        _status = Status.authenticated;
        notifyListeners();
        setIsLOading(false);
        return true;
      } else {
        _status = Status.authenticateError;
        notifyListeners();
        setIsLOading(false);
        return false;
      }
    } on Exception {
      setIsLOading(false);
      return false;
    }
  }

  Future<bool> handleSignUp(
    String email,
    String password,
    String firstName,
    String lastName,
    String mobileNumber,
    String school,
    String birthday,
    String age,
    String logitude,
    String latitude,
  ) async {
    _status = Status.authenticating;
    setIsLOading(true);
    notifyListeners();
    try {
      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User user = result.user!;
      if (user != null) {
        final QuerySnapshot result = await firebaseFirestore
            .collection(FirestoreConstants.pathUserCollection)
            .where(FirestoreConstants.id, isEqualTo: user.uid)
            .get();
        final List<DocumentSnapshot> document = result.docs;
        if (document.isEmpty) {
          firebaseFirestore
              .collection(FirestoreConstants.pathUserCollection)
              .doc(user.uid)
              .set({
            FirestoreConstants.displayName: "$firstName $lastName",
            FirestoreConstants.photoUrl: user.photoURL,
            FirestoreConstants.id: user.uid,
            FirestoreConstants.address: "$latitude $logitude",
            FirestoreConstants.birthDay: birthday,
            FirestoreConstants.age: agecalculate(age),
            FirestoreConstants.school: school,
            FirestoreConstants.createdAt:
                DateTime.now().millisecondsSinceEpoch.toString(),
            FirestoreConstants.chattingWith: null
          });

          User currentUser = user;
          await prefs.setString(FirestoreConstants.id, currentUser.uid);
          await prefs.setString(
              FirestoreConstants.displayName, currentUser.displayName ?? "");
          await prefs.setString(
              FirestoreConstants.photoUrl, currentUser.photoURL ?? "");
          await prefs.setString(
              FirestoreConstants.phoneNumber, currentUser.phoneNumber ?? "");
        } else {
          DocumentSnapshot documentSnapshot = document[0];
          ChatUser userChat = ChatUser.fromDocument(documentSnapshot);
          await prefs.setString(FirestoreConstants.id, userChat.id);
          await prefs.setString(
              FirestoreConstants.displayName, userChat.displayName);
          await prefs.setString(FirestoreConstants.aboutMe, userChat.aboutMe);
          await prefs.setString(
              FirestoreConstants.phoneNumber, userChat.phoneNumber);
        }
        _status = Status.authenticated;
        notifyListeners();
        setIsLOading(false);
        return true;
      } else {
        _status = Status.authenticateError;
        notifyListeners();
        setIsLOading(false);
        return false;
      }
    } on Exception {
      setIsLOading(false);
      return false;
    }
  }

  Future<bool> sendresetemail(String email) async {
    var result = firebaseAuth.sendPasswordResetEmail(email: email);
    setIsLOading(true);
    if (result != null) {
      setIsLOading(false);
      return true;
    } else {
      setIsLOading(false);
      return false;
    }
  }

  Future<void> googleSignOut() async {
    setIsLOading(true);
    _status = Status.uninitialized;
    await firebaseAuth.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
    setIsLOading(false);
  }
}
