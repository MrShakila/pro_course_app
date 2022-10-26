import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_course_app/Utils/util.dart';
import 'package:pro_course_app/model/main_screen.dart';
import 'package:pro_course_app/view/home_page.dart';
import 'package:pro_course_app/view/profile._page.dart';

import 'model/course_detail.dart';

class CourseList extends StatefulWidget {
  const CourseList({Key? key}) : super(key: key);

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  int _currentIndex = 0;

  //screen List
  final List<Widget> _screens = [
    const CourseDetail(),
    const ChatList(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: _screens.elementAt(_currentIndex),
      bottomNavigationBar: Container(
        height: 90,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavTile(
              icon: const Icon(
                Icons.chat,
                size: 25,
              ),
              isSelected: _currentIndex == 0,
              ontap: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            BottomNavTile(
              icon: const Icon(
                Icons.people,
                size: 25,
              ),
              isSelected: _currentIndex == 1,
              ontap: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            BottomNavTile(
              icon: const Icon(
                Icons.people,
                size: 25,
              ),
              isSelected: _currentIndex == 2,
              ontap: () {
                setState(() {
                  _currentIndex = 3;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavTile extends StatelessWidget {
  const BottomNavTile({
    Key? key,
    required this.icon,
    required this.isSelected,
    required this.ontap,
  }) : super(key: key);

  final Icon icon;
  final bool isSelected;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(child: icon),
      ),
    );
  }
}

class CourseListItem extends StatelessWidget {
  const CourseListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        UtilFunctions.navigateTo(context, const CouseMainScreen());
      },
      child: Padding(
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
      ),
    );
  }
}
