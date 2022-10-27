import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../contollers/course_controller.dart';

class Course with ChangeNotifier {
  // ignore: prefer_final_fields

  // List<Book> get books {
  //   return [..._books];
  // }

  // void addBook(Book book) {
  //   _books.add(book);
  //   notifyListeners();
  // }

  // Book findById(String Id) {
  //   return _books.firstWhere((book) => book.id == Id);
  // }

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
// save book info loader

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  // save book info
  void setIsLOading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<void> startSaveBookInfo(
      BuildContext context, String title, String desc, String price) async {
    // try {
    //setloading
    setIsLOading(true);
    await _courseController.saveCourseInfo(title, desc, _image);
    setIsLOading(false);
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Sucess',
      desc: 'Book Info saved sucessfull',
      btnOkOnPress: () {},
    ).show();
    Logger().i("Book is Saved");
    // } catch (e) {
    //   Logger().e(e);
    //   setIsLOading(false);
    // }
  }

  Future<void> getcourses(
    BuildContext context,
  ) async {
    // try {
    //setloading
    setIsLOading(true);
    await _courseController.getCourse();
    setIsLOading(false);

    Logger().i("Course details is fetched");
    // } catch (e) {
    //   Logger().e(e);
    //   setIsLOading(false);
    // }
  }
}
