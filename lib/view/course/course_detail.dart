import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pro_course_app/Utils/loading_indicator.dart';
import 'package:pro_course_app/Utils/navigation.dart';
import 'package:pro_course_app/admin/save_course_detail.dart';
import 'package:pro_course_app/view/course/pdfview.dart';
import 'package:provider/provider.dart';

import '../../Utils/Widget/coursedetail.dart';
import 'studentlist.dart';

class CourseDetail extends StatefulWidget {
  final String courseid;

  const CourseDetail({
    Key? key,
    required this.courseid,
  }) : super(key: key);

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('course');
    final Size size = MediaQuery.of(context).size;
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.courseid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return DetailWidget(
              pdfurl: data['pdfurl'],
              size: size,
              title: data['title'],
              desc: data['description'],
              imag: data['imageUrl'],
              id: widget.courseid,
              star: 4.5);
        }

        return const CustomLoading();
      },
    );
  }
}
