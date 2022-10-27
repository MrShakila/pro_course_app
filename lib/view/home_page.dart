import 'package:animate_do/animate_do.dart';
import 'package:flutter/Material.dart';
import 'package:logger/logger.dart';
import 'package:pro_course_app/Utils/custo_drawer.dart';
import 'package:pro_course_app/view/chat/chat_list.dart';
import 'package:provider/provider.dart';

import '../Utils/util.dart';
import '../admin/save_course_detail.dart';
import '../course_list.dart';
import '../provider/auth_provider.dart';
import '../provider/home_provider.dart';
import 'course/add_new_course.dart';
import 'login/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AuthProvider authProvider;
  late String currentUserId;
  late HomeProvider homeProvider;

  Future<void> googleSignOut() async {
    authProvider.googleSignOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
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
                  onPressed: () => Navigator.of(context).pop(),
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
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (Route<dynamic> route) => false);
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
          actions: [
            Consumer<Course>(
              builder: (context, value, child) {
                return IconButton(
                  icon: const Icon(Icons.upload),
                  onPressed: () {
                    UtilFunctions.navigateTo(context, const SaveCourseInfo());
                  },
                );
              },
            )
          ],
          centerTitle: true,
          title: const Text('Pro Course App'),
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
          ),
        ));
  }

  List<Widget> _buildThreePageViewChildren() {
    return <Widget>[const CourseList(), const ChatList()];
  }

  List<BottomNavigationBarItem> _buildThreeItems() {
    return const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home Page',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.chat),
        label: 'Chat List',
      ),
    ];
  }
}
