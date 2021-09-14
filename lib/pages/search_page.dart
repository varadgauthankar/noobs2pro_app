import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noobs2pro_app/blocs/articles_fetch/bloc/articles_bloc.dart';
import 'package:noobs2pro_app/blocs/articles_fetch/repository/articles_repository_impl.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/pages/pages.dart';
import 'package:noobs2pro_app/services/firebase_auth.dart';
import 'package:noobs2pro_app/services/hive_service.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';
import 'package:noobs2pro_app/widgets/circular_progress_bar.dart';
import 'package:noobs2pro_app/widgets/home_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ArticlesBloc? _articlesBloc;
  List<Article> shuffledArticleList = [];

  @override
  void initState() {
    super.initState();

    _articlesBloc = ArticlesBloc(
      ArticlesRepositoryImpl(),
      firebaseUserId: FirebaseAuthService().getCurrentUserUid() ?? '',
    );
    _articlesBloc?.add(FetchExploreArticlesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final Size screenDimention = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                hintText: 'Search',
                suffixIcon: Icon(EvaIcons.searchOutline),
              ),
              onFieldSubmitted: (text) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchedArticlePaged(
                      query: text,
                    ),
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 12, bottom: 6),
            child: Text(
              'Explore',
              style: searchPageTop,
            ),
          ),
          BlocProvider(
            create: (context) => _articlesBloc!,
            child: BlocConsumer<ArticlesBloc, ArticlesState>(
              listener: (context, state) {
                if (state is ArticlesFetchError) {
                  showMySnackBar(context, message: state.error);
                }
              },
              builder: (context, state) {
                return buildListOfArticles(screenDimention, state);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListOfArticles(Size _screenDimention, ArticlesState state) {
    if (state is ArticlesFetchLoading) {
      return const CenteredCircularProgressBar();
    } else if (state is ArticlesFetchComplete) {
      return Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.all(6),
          itemCount: state.articles.length,
          itemBuilder: (context, index) {
            final List<Article> articles = state.articles;

            final Article _article = articles.elementAt(index);
            return HomeCard(
              _article,
              _screenDimention,
            );
          },
        ),
      );
    } else if (state is ArticlesFetchError) {
      //Todo: add graphics
      return const Text('Something went wrong');
    } else {
      return const SizedBox.shrink();
    }
  }
}
