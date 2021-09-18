import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noobs2pro_app/blocs/articles_fetch/bloc/articles_bloc.dart';
import 'package:noobs2pro_app/blocs/articles_fetch/repository/articles_repository_impl.dart';
import 'package:noobs2pro_app/blocs/theme_bloc/bloc/bloc/theme_bloc.dart';
import 'package:noobs2pro_app/constants/strings.dart';
import 'package:noobs2pro_app/models/category.dart';
import 'package:noobs2pro_app/pages/category_articles_page.dart';
import 'package:noobs2pro_app/pages/home_page.dart';
import 'package:noobs2pro_app/pages/pages.dart';
import 'package:noobs2pro_app/services/firebase_auth.dart';
import 'package:noobs2pro_app/services/hive_service.dart';
import 'package:noobs2pro_app/utils/colors.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentNavBarIndex = 0;
  ArticlesBloc? _articlesBloc;

  //TODO: refactor this page code
  // TODO: fetch categories from api
  // as of now categories are hard coded
  List<Category> categories = [
    Category(
      name: 'Best Of',
      id: 333, // wordpress category id
    ),
    Category(
      name: 'Best Settings Guide',
      id: 332,
    ),
    Category(
      name: 'E-sport',
      id: 4930,
    ),
    Category(
      name: 'Featured',
      id: 334,
    ),
    Category(
      name: 'Game Reviews',
      id: 13,
    ),
    Category(
      name: 'Game play Guides',
      id: 83,
    ),
    Category(
      name: 'How To Guides',
      id: 336,
    ),
    Category(
      name: 'Mobile E-sports',
      id: 5939,
    ),
    Category(
      name: 'Mobile Games',
      id: 5941,
    ),
    Category(
      name: 'Android And IOS',
      id: 2652,
    ),
  ];

  @override
  void initState() {
    _articlesBloc = ArticlesBloc(
      ArticlesRepositoryImpl(),
      firebaseUserId: FirebaseAuthService().getCurrentUserUid() ?? '',
    );
    _articlesBloc?.add(FetchArticlesEvent());

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
        title: Text(
          getAppBarName(),
          style: appBarTitleStyle.copyWith(
              color: isThemeDark(context) ? kWhite : kBlack),
        ),
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
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
                color: kPrimaryColor,
                child: Image.asset('assets/images/logo_full.png'),
              ),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0, top: 10.0),
                      child: Text(
                        'CATEGORIES',
                        style: categoryTitle,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: categories
                          .map(
                            (e) => ListTile(
                              visualDensity: const VisualDensity(vertical: -4),
                              title: Text(
                                e.name!,
                                style: categoryItems,
                              ),
                              onTap: () => goToPage(
                                context,
                                CategoryArticlesPage(
                                  categoryTitle: e.name!,
                                  categoryId: e.id!,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () {
                  BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(
                    isThemeDark(context) ? ThemeMode.light : ThemeMode.dark,
                  ));
                },
                child: ListTile(
                  visualDensity: const VisualDensity(vertical: -4),
                  title: const Text(
                    'Dark Mode',
                    style: categoryItems,
                  ),
                  trailing: Switch(
                    value: isThemeDark(context),
                    onChanged: (_) {
                      BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(
                        isThemeDark(context) ? ThemeMode.light : ThemeMode.dark,
                      ));
                    },
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                trailing: const Icon(EvaIcons.logOut),
                title: const Text(
                  'LOG OUT',
                  style: categoryItems,
                ),
                selected: true,
                onTap: () {
                  // TODO: improve this

                  Navigator.pop(context);

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Log out?'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('NO'),
                          ),
                          TextButton(
                            onPressed: () {
                              FirebaseAuthService().signOut().then(
                                (_) {
                                  HiveService().allArticleBox.clear();
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AuthMainPage(),
                                      ),
                                      (route) => false);
                                },
                              );
                            },
                            child: const Text('YES'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => _articlesBloc!,
        child: BlocListener<ArticlesBloc, ArticlesState>(
          listener: (context, state) {
            if (state is ArticlesFetchError) {
              showMySnackBar(context, message: state.error);
            }
          },
          child: pages[currentNavBarIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentNavBarIndex,
        onTap: (index) {
          setState(() {
            currentNavBarIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.homeOutline),
            activeIcon: Icon(EvaIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.searchOutline),
            activeIcon: Icon(EvaIcons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.bookmarkOutline),
            activeIcon: Icon(EvaIcons.bookmark),
            label: 'Saved',
          ),
        ],
      ),
    );
  }
}
