import 'package:flutter/Material.dart';
import 'package:pro_course_app/view/home_page.dart';

import '../course_list.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: 0);
    int pageIndex = 0;

    return Scaffold(
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
        children: _buildThreePageViewChildren(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _buildThreeItems(),
        onTap: (int index) {
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        },
        currentIndex: pageIndex,
        fixedColor: Theme.of(context).primaryColor,
      ),
    );
  }

  List<Widget> _buildThreePageViewChildren() {
    return <Widget>[const CourseList(), const ChatList()];
  }

  List<BottomNavigationBarItem> _buildThreeItems() {
    return const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Course List',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search_rounded),
        label: 'Chat List',
      ),
    ];
  }
}
