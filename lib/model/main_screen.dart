import 'package:flutter/material.dart';
import 'package:pro_course_app/course_list.dart';
import 'package:pro_course_app/model/user_list.dart';

class CouseMainScreen extends StatefulWidget {
  const CouseMainScreen({Key? key}) : super(key: key);

  @override
  State<CouseMainScreen> createState() => _CouseMainScreenState();
}

class _CouseMainScreenState extends State<CouseMainScreen> {
  int _currentIndex = 0;
  //screen List
  final List<Widget> _screens = [
    const CourseList(),
    const UserList(),
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

class CircleImg extends StatelessWidget {
  const CircleImg({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration:
              const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        ),
        Positioned(
          bottom: 3,
          right: 3,
          child: Container(
            width: 35,
            height: 35,
            decoration:
                const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          ),
        ),
      ],
    );
  }
}
