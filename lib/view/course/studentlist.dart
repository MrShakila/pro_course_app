import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Utils/loading_indicator.dart';

class StudentLIst extends StatelessWidget {
  final String courseid;
  const StudentLIst({Key? key, required this.courseid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = FirebaseFirestore.instance
        .collection('course')
        .doc(courseid)
        .collection('students')
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

        return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          if (data['user'] != '') {
            return getUsers(data['user']);
          } else {
            return const Text("No Students");
          }
        }).toList());
      },
    );
  }
}

Widget getUsers(String id) {
  print(id);
  var users = FirebaseFirestore.instance.collection('users').doc(id);
  print(users);
  return FutureBuilder<DocumentSnapshot>(
    future: users.get(),
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
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child:
                              SizedBox(child: Image.network(data['photoUrl'])),
                        )),
                    Expanded(flex: 5, child: Text(data['displayName'])),
                  ],
                ),
              ],
            ),
          ),
        );
      }

      return const CustomLoading();
    },
  );
}
