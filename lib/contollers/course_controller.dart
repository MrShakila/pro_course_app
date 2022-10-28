import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';

class CourseController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // collection
  CollectionReference course = FirebaseFirestore.instance.collection('course');
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> adduserstocourse(String courseid, BuildContext context) async {
    await FirebaseFirestore.instance
        .collection('course')
        .doc(courseid)
        .collection("students")
        .where('user', isEqualTo: user!.uid)
        .get()
        .then((value) {
      print(value.docs);
      if (value.docs.isNotEmpty) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: 'Error',
          desc: 'User Alreday In this Course',
          btnOkOnPress: () {},
        ).show();
      } else {
        try {
          FirebaseFirestore.instance
              .collection('course')
              .doc(courseid)
              .collection("students")
              .add({"user": user!.uid});
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.bottomSlide,
            title: 'Success',
            desc: 'Student Added Successfully',
            btnOkOnPress: () {},
          ).show();
        } on Exception catch (e) {
          Logger().e(e);
          // TODO
        }
      }
    });

    //hold
  }

  // Future<bool> checkuserenroled(String courseid) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('course')
  //         .doc(courseid)
  //         .collection("students")
  //         .where('user', isEqualTo: user!.uid)
  //         .get()
  //         .then((value) {
  //       print(value.docs);
  //       if (value.docs.isNotEmpty) {
  //         return true;
  //       } else {
  //         return false;
  //       }
  //     });
  //   } on Exception catch (e) {
  //     Logger().e(e);
  //   }

  //   //hold
  // }

  //upload picked iamge file to firebase storage
  UploadTask? uploadFile(File img) {
    try {
      //getting the file name
      final fileName = basename(img.path);
      //define the file destination
      final destination = 'courseImages/$fileName';
      //create firebsse storage instance
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(img);
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<void> saveCourseInfo(
    String title,
    String desc,
    String pdfurl,
    int star,
    File img,
  ) async {
    //uploading the image
    UploadTask? task = uploadFile(img);

    final snapshot = await task!.whenComplete(() {});

    final downloadUrl = await snapshot.ref.getDownloadURL();
    //get an online doc id
    String docId = course.doc().id;
    //saving course details to cloud store
    await course.doc(docId).set({
      'id': docId,
      'title': title,
      'description': desc,
      'star': star,
      'pdfurl': pdfurl,
      'imageUrl': downloadUrl
    });

    //hold
  }

  Future<Object> getCourse() async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('course');
      final snapshot = await users.doc().get();
      final data = snapshot.data() as Map<String, dynamic>;
      return data.entries;
    } catch (e) {
      return 'Error fetching user';
    }
  }
}
