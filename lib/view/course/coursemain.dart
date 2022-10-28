import 'package:flutter/material.dart';
import 'package:pro_course_app/Utils/custo_drawer.dart';
import 'package:pro_course_app/view/course/course_detail.dart';

import '../../const/app_colors.dart';
import 'studentlist.dart';

class CourseDetailMain extends StatefulWidget {
  final String courseid;

  const CourseDetailMain({
    Key? key,
    required this.courseid,
  }) : super(key: key);

  @override
  State<CourseDetailMain> createState() => _CourseDetailMainState();
}

final PageController pageController = PageController(initialPage: 0);
int pageIndex = 0;

class _CourseDetailMainState extends State<CourseDetailMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black38,
          items: _buildThreeItems(),
          onTap: (int index) {
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            );

            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            );
          },
          currentIndex: pageIndex,
        ),
        drawer: const CustomDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: AppColors.indyBlue),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          centerTitle: true,
          title: const Text(
            'Pro Course App',
            style: TextStyle(color: AppColors.indyBlue),
          ),
        ),
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (int index) {
            setState(
              () {
                pageIndex = index;
              },
            );
          },
          children: _buildThreePageViewChildren(widget.courseid),
        ));
  }
}

List<Widget> _buildThreePageViewChildren(String courseid) {
  return <Widget>[
    CourseDetail(courseid: courseid),
    StudentLIst(
      courseid: courseid,
    )
  ];
}

List<BottomNavigationBarItem> _buildThreeItems() {
  return const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.description),
      label: 'Course Details',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.chat),
      label: 'Student List',
    ),
  ];
}
