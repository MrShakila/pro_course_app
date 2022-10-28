import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_course_app/Utils/loading_indicator.dart';
import 'package:pro_course_app/Utils/util.dart';
import 'package:pro_course_app/view/course/course_detail.dart';

class CourseList extends StatefulWidget {
  const CourseList({Key? key}) : super(key: key);

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  //screen List
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('course').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CustomLoading();
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            print(data);
            return CustomListItem(data: data);
          }).toList(),
        );
      },
    );
  }
}

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        UtilFunctions.navigateTo(context, CourseDetail(courseid: data["id"]));
      },
      child: SizedBox(
        height: 100,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(flex: 1, child: Image.network(data['imageUrl'])),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data["title"],
                          style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data["description"],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
