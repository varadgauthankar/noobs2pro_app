import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noobs2pro_app/blocs/articles_fetch/bloc/articles_bloc.dart';
import 'package:noobs2pro_app/blocs/articles_fetch/repository/articles_repository_impl.dart';
import 'package:noobs2pro_app/blocs/category/categories_fetch/bloc/category_bloc.dart';
import 'package:noobs2pro_app/blocs/category/categories_fetch/repository/category_repository_impl.dart';
import 'package:noobs2pro_app/models/category.dart';
import 'package:noobs2pro_app/pages/home_page.dart';
import 'package:noobs2pro_app/pages/pages.dart';
import 'package:noobs2pro_app/services/api_service.dart';
import 'package:noobs2pro_app/services/firebase_auth.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentNavBarIndex = 0;
  ArticlesBloc? _articlesBloc;
  CategoryBloc? _categoryBloc;

  List<Category>? categories;

  @override
  void initState() {
    _articlesBloc = ArticlesBloc(
      ArticlesRepositoryImpl(),
      firebaseUserId: FirebaseAuthService().getCurrentUserUid() ?? '',
    );
    _articlesBloc?.add(FetchArticlesEvent());

    _categoryBloc = CategoryBloc(CategoryRepositoryImpl());

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
                _categoryBloc?.add(GetCategoriesEvent());

                Scaffold.of(context).openDrawer();
              },
              tooltip: 'Open drawer',
            );
          },
        ),
      ),
      drawer: BlocProvider(
        create: (context) => _categoryBloc!,
        child: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: const CircleAvatar(),
                accountName: const Text('Pro Gamer'),
                accountEmail:
                    Text(FirebaseAuthService().getCurrentUser()!.email!),
              ),
              Text('CATEGORIES'),
              BlocConsumer<CategoryBloc, CategoryState>(
                listener: (context, state) {
                  if (state is CategoryStateComplete) {
                    setState(() {
                      categories = state.categories;
                      print(categories);
                    });
                  } else if (state is CategoryStateError) {
                    print('errrrrrrrrrrrrrrrr');
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: categories!
                        .map((e) => ListTile(
                              title: Text(e.name!),
                            ))
                        .toList(),
                  );
                },
              ),
              ListTile(
                title: Text('Android and IOS'),
                onTap: () {},
              )
            ],
          ),
        ),
      ),
      body: pages[currentNavBarIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentNavBarIndex,
        onTap: (index) {
          setState(() {
            currentNavBarIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              currentNavBarIndex == 0 ? EvaIcons.home : EvaIcons.homeOutline,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              currentNavBarIndex == 1
                  ? EvaIcons.search
                  : EvaIcons.searchOutline,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              currentNavBarIndex == 2
                  ? EvaIcons.bookmark
                  : EvaIcons.bookmarkOutline,
            ),
            label: 'Saved',
          ),
        ],
      ),
    );
  }
}
