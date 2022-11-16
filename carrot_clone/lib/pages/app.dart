import 'package:carrot_clone/pages/mypage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _curPage = 0;

  @override
  void initState() {
    super.initState();
    _curPage = 0;
  }

  BottomNavigationBarItem _bottomNavItem(
      String label, String iconName, double width) {
    return BottomNavigationBarItem(
      label: label,
      icon: Padding(
        padding: const EdgeInsets.all(8),
        child:
            SvgPicture.asset("assets/svgs/${iconName}_off.svg", width: width),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.all(8),
        child: SvgPicture.asset("assets/svgs/${iconName}_on.svg", width: width),
      ),
    );
  }

  Widget _bottomNavBar() {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _curPage = index;
          });
        },
        currentIndex: _curPage,
        selectedFontSize: 12,
        selectedItemColor: Colors.black,
        items: [
          _bottomNavItem("홈", "home", 22),
          _bottomNavItem("동네생활", "notes", 22),
          _bottomNavItem("내 근처", "location", 22),
          _bottomNavItem("채팅", "chat", 22),
          _bottomNavItem("나의 당근", "user", 22),
        ]);
  }

  Widget _bodyWidget() {
    switch (_curPage) {
      case 0:
        return const Home();
      case 4:
        return const MyPage();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _bodyWidget(), bottomNavigationBar: _bottomNavBar());
  }
}
