import 'package:flutter/material.dart';

import '../view/home_page.dart';
import '../view/profile._page.dart';
import 'course_detail.dart';

class CouseMainScreen extends StatefulWidget {
  const CouseMainScreen({Key? key}) : super(key: key);

  @override
  State<CouseMainScreen> createState() => _CouseMainScreenState();
}

class _CouseMainScreenState extends State<CouseMainScreen> {
  //   Future<bool> initBackButton() async {
  //   Logger().d('back button pressed');
  //   return await showDialog(
  //         context: context,
  //         builder: (context) => ElasticIn(
  //           child: AlertDialog(
  //             title: const CustomText(text: 'Exit App'),
  //             content:
  //                 const CustomText(text: 'Do you really want to exit an App ?'),
  //             actions: [
  //               ElevatedButton(
  //                 onPressed: () => Navigator.of(context).pop(),
  //                 child: const CustomText(text: 'No'),
  //               ),
  //               ElevatedButton(
  //                 onPressed: () => Navigator.of(context).pop(true),
  //                 child: const CustomText(text: 'Yes'),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ) ??
  //       false;
  // }
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
