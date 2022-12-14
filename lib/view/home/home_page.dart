import 'package:animate_do/animate_do.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pro_course_app/Utils/custo_drawer.dart';
import 'package:pro_course_app/const/app_colors.dart';
import 'package:pro_course_app/view/course/mycourse_list.dart';
import 'package:pro_course_app/view/chat/chat_list.dart';
import 'package:pro_course_app/view/home/home.dart';
import 'package:pro_course_app/view/login/signin.dart';
import 'package:provider/provider.dart';

import '../../Utils/navigation.dart';
import '../../admin/save_course_detail.dart';
import '../course/course_list.dart';
import '../../provider/auth_provider.dart';
import '../../provider/home_provider.dart';
import '../course/add_new_course.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late AuthProvider authProvider;
  late String currentUserId;
  late HomeProvider homeProvider;

  Future<void> googleSignOut() async {
    authProvider.googleSignOut();
    UtilFunctions.pushRemoveNavigation(context, const SignIn());
  }

  Future<bool> initBackButton() async {
    Logger().d('back button pressed');
    return await showDialog(
          context: context,
          builder: (context) => ElasticIn(
            child: AlertDialog(
              title: const Text('Exit App'),
              content: const Text('Do you really want to exit ?'),
              actions: [
                ElevatedButton(
                  onPressed: () => UtilFunctions.goBack(context),
                  child: const Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Yes'),
                ),
              ],
            ),
          ),
        ) ??
        false;
  }

  @override
  void initState() {
    authProvider = context.read<AuthProvider>();
    homeProvider = context.read<HomeProvider>();
    if (authProvider.getFirebaseUserId()?.isNotEmpty == true) {
      currentUserId = authProvider.getFirebaseUserId()!;
    } else {
      UtilFunctions.pushRemoveNavigation(context, const SignIn());
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: 0);
    int pageIndex = 0;

    return Scaffold(
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
          actions: [
            Consumer<Course>(
              builder: (context, value, child) {
                return IconButton(
                  icon: const Icon(Icons.upload, color: AppColors.indyBlue),
                  onPressed: () {
                    UtilFunctions.navigateTo(context, const SaveCourseInfo());
                  },
                );
              },
            )
          ],
          centerTitle: true,
          title: const Text(
            'Pro Course App',
            style: TextStyle(color: AppColors.indyBlue),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: _buildThreeItems(),
          selectedItemColor: Colors.blueGrey,
          unselectedItemColor: Colors.grey,
          onTap: (int index) {
            setState(() {
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            });
          },
          currentIndex: pageIndex,
        ),
        body: WillPopScope(
            onWillPop: initBackButton,
            child: PageView(
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
            )));
  }

  List<Widget> _buildThreePageViewChildren() {
    return <Widget>[
      const HomeScreen(),
      const CourseList(),
      MyCourseList(userid: currentUserId),
      const ChatList()
    ];
  }

  List<BottomNavigationBarItem> _buildThreeItems() {
    return const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home Page',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.bolt),
        label: 'New Courses',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.laptop),
        label: 'My Courses',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.chat),
        label: 'Chat List',
      ),
    ];
  }
}
