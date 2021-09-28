import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noobs2pro_app/blocs/articles_fetch/bloc/articles_bloc.dart';
import 'package:noobs2pro_app/blocs/articles_fetch/repository/articles_repository_impl.dart';
import 'package:noobs2pro_app/blocs/connectivity/bloc/connectivity_bloc.dart';
import 'package:noobs2pro_app/pages/home_page.dart';
import 'package:noobs2pro_app/pages/pages.dart';
import 'package:noobs2pro_app/services/connectivity.dart';
import 'package:noobs2pro_app/services/firebase_auth.dart';
import 'package:noobs2pro_app/utils/colors.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';
import 'package:noobs2pro_app/widgets/drawer/drawer.dart';
import 'package:noobs2pro_app/widgets/my_material_banner.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentNavBarIndex = 0;
  ArticlesBloc? _articlesBloc;
  ConnectivityBloc? _connectivityBloc;
  // bool isInternet = false;

  @override
  void initState() {
    _connectivityBloc = ConnectivityBloc()..add(ListenConnection());

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
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: isThemeDark(context) ? kBlack : kWhite,
          statusBarIconBrightness:
              isThemeDark(context) ? Brightness.light : Brightness.dark,
          // statusBarBrightness: Brightness.light,
        ),
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
      drawer: const DrawerMenu(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _articlesBloc!),
          BlocProvider(create: (context) => _connectivityBloc!),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<ArticlesBloc, ArticlesState>(
              listener: (context, state) {
                if (state is ArticlesFetchError) {
                  showMySnackBar(context, message: state.error);
                }
              },
            ),
            BlocListener<ConnectivityBloc, ConnectivityState>(
              listener: (context, state) {
                if (state is ConnectivityOnline) {
                  ScaffoldMessenger.of(context).clearMaterialBanners();
                }
                if (state is ConnectivityOffline) {
                  ScaffoldMessenger.of(context).showMaterialBanner(
                    myMaterialBanner(
                      title: 'Offline Mode',
                      subTitle: 'Connect to internet to save articles',
                      onButtonPressed: () {
                        ScaffoldMessenger.of(context).clearMaterialBanners();
                      },
                    ),
                  );
                }
              },
            ),
          ],
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
