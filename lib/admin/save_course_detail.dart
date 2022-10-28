import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../contollers/course_controller.dart';

class Course with ChangeNotifier {
  //-------------for admin
  final CourseController _courseController = CourseController();
  final ImagePicker _picker = ImagePicker();
  File _image = File("");

  File get getImage => _image;

  Future<void> selectImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        notifyListeners();
      } else {
        Logger().e("No Image selected");
      }
    } catch (e) {
      Logger().e(e);
    }
  }
// save course info loader

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  // save course info
  void setIsLOading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<void> startSavecourseInfo(BuildContext context, String title,
      String desc, int star, String pdfurl) async {
    setIsLOading(true);
    await _courseController.saveCourseInfo(
      title,
      desc,
      pdfurl,
      star,
      _image,
    );
    setIsLOading(false);
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Sucess',
      desc: 'course Info saved sucessfull',
      btnOkOnPress: () {},
    ).show();
    Logger().i("course is Saved");
  }

  Future<void> addNewStudentToCourse(
      BuildContext context, String courseid) async {
    setIsLOading(true);
    bool isEnrolled = await _courseController.checkuserenroled(
      courseid,
    );
    if (isEnrolled) {
      await _courseController.adduserstocourse(
        courseid,
      );
      setIsLOading(false);
    } else {
      setIsLOading(false);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'Error',
        desc: 'You Already Enrolled This Course',
        btnOkOnPress: () {},
      ).show();
    }

    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Sucess',
      desc: 'Student Added Successfully',
      btnOkOnPress: () {},
    ).show();
    Logger().i("Student Added");
  }

  Future<void> getAllcourses(
    BuildContext context,
  ) async {
    setIsLOading(true);
    await _courseController.getCourse();
    setIsLOading(false);
    Logger().i("Course details is fetched");
  }
}
