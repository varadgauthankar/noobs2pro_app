import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noobs2pro_app/blocs/theme_bloc/bloc/bloc/theme_bloc.dart';
import 'package:noobs2pro_app/pages/category_articles_page.dart';
import 'package:noobs2pro_app/pages/pages.dart';
import 'package:noobs2pro_app/services/firebase_auth.dart';
import 'package:noobs2pro_app/utils/colors.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';
import 'package:noobs2pro_app/widgets/drawer/drawer_model.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(12),
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 12.0, top: 12.0),
                    child: Text(
                      'CATEGORIES',
                      style: categoryTitle,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: Category.categories
                        .map(
                          (e) => ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            visualDensity: const VisualDensity(vertical: -3),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(
                    isThemeDark(context) ? ThemeMode.light : ThemeMode.dark,
                  ));
                },
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  visualDensity: const VisualDensity(vertical: -3),
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
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                visualDensity: const VisualDensity(vertical: -4),
                trailing: const Icon(EvaIcons.logOut),
                title: const Text(
                  'LOG OUT',
                  style: categoryItems,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
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
                                  // HiveService().allArticleBox.clear();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AuthMainPage(),
                                    ),
                                    (route) => false,
                                  );
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
            ),
          ],
        ),
      ),
    );
  }
}
