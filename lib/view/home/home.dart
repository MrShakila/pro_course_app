import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_course_app/view/course/course_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Hi",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.normal, fontSize: 15),
                ),
                Row(
                  children: [
                    Text(
                      "Recomended Courses",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.flash_on_rounded,
                      color: Colors.orange,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: const [
                      CategoryItem(
                        icons: Icon(Icons.laptop),
                        text: "Html",
                      ),
                      CategoryItem(
                        icons: Icon(Icons.javascript),
                        text: "Java",
                      ),
                      CategoryItem(
                        icons: Icon(Icons.mobile_friendly),
                        text: "Flutter",
                      ),
                      CategoryItem(
                        icons: Icon(
                          Icons.laptop_mac,
                        ),
                        text: "CSS",
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "New Arrivals",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.local_fire_department_outlined,
                      color: Colors.orange,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(right: 5),
                child: CourseList(),
              ))
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String text;
  final Icon icons;
  const CategoryItem({
    Key? key,
    required this.text,
    required this.icons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            icons,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.normal, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
