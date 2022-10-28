import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Utils/Widget/courselistitem.dart';
import '../../Utils/loading_indicator.dart';

class MyCourseList extends StatelessWidget {
  final String userid;
  const MyCourseList({Key? key, required this.userid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .collection('course')
        .get();
    print(data);
    return FutureBuilder<QuerySnapshot>(
      future: data,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CustomLoading();
        }
        if (snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No Courses Found"));
        }

        return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          if (data['id'] != '') {
            return getCourses(data['id']);
          } else {
            return const Text("No Students");
          }
        }).toList());
      },
    );
  }
}

Widget getCourses(String id) {
  print(id);
  var course = FirebaseFirestore.instance.collection('course').doc(id);
  print(course);
  return FutureBuilder<DocumentSnapshot>(
    future: course.get(),
    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (snapshot.hasError) {
        return const Text("Something went wrong");
      }

      if (snapshot.hasData && !snapshot.data!.exists) {
        return Container();
      }

      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
        return CustomListItem(
          data: data,
        );
      }
      return const CustomLoading();
    },
  );
}
