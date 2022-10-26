import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_course_app/Utils/util.dart';
import 'package:pro_course_app/view/course/course_detail.dart';

class CourseList extends StatefulWidget {
  const CourseList({Key? key}) : super(key: key);

  @override
  State<CourseList> createState() => _CourseListState();
}

final myProducts = List<String>.generate(1000, (i) => 'Product $i');

class _CourseListState extends State<CourseList> {
  //screen List

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        // the number of items in the list
        itemCount: myProducts.length,

        // display each item of the product list
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                UtilFunctions.navigateTo(context, const CourseDetail());
              },
              child: const CourseLisItem());
        });
  }
}

class CourseLisItem extends StatelessWidget {
  const CourseLisItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(25)),
        width: double.infinity,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Flutter Mobile App",
                    style: GoogleFonts.roboto(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Text("5"),
                    ],
                  )
                ],
              ),
              const Text("industry. Lorem Ipsum has been the industry's")
            ],
          ),
        ),
      ),
    );
  }
}
