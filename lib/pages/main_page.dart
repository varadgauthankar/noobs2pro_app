import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:noobs2pro_app/pages/home_page.dart';
import 'package:noobs2pro_app/pages/pages.dart';
import 'package:noobs2pro_app/services/firebase_auth.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentNavBarIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  String getAppBarName() {
    return currentNavBarIndex == 0
        ? 'Home'
        : currentNavBarIndex == 1
            ? 'Search'
            : currentNavBarIndex == 2
                ? 'Saved Articles'
                : ' ';
  }

  List<Widget> pages = const [HomePage(), SearchPage(), SavedArticlePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getAppBarName()),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(EvaIcons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: 'Open drawer',
            );
          },
        ),
      ),
      drawer: const Drawer(),
      body: pages[currentNavBarIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentNavBarIndex,
        onTap: (index) {
          setState(() {
            currentNavBarIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(EvaIcons.homeOutline), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(EvaIcons.searchOutline), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(EvaIcons.bookmarkOutline), label: 'Saved'),
        ],
      ),
    );
  }
}
