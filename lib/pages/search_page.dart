import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noobs2pro_app/blocs/articles_fetch/bloc/articles_bloc.dart';
import 'package:noobs2pro_app/blocs/articles_fetch/repository/articles_repository_impl.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/pages/pages.dart';
import 'package:noobs2pro_app/services/firebase_auth.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';
import 'package:noobs2pro_app/widgets/circular_progress_bar.dart';
import 'package:noobs2pro_app/widgets/home_card.dart';
import 'package:noobs2pro_app/widgets/shimmers/home_article_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ArticlesBloc? _articlesBloc;
  final _textController = TextEditingController();

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
    final Size screenDimension = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              controller: _textController,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                hintText: 'Search',
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                // suffixIcon: Icon(EvaIcons.searchOutline),
                suffix: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    // radius: 16,

                    onTap: () {
                      goToPage(
                        context,
                        SearchedArticlePaged(
                          query: _textController.text,
                        ),
                      );
                    },
                    child: const Icon(
                      EvaIcons.searchOutline,
                      size: 22,
                    )),
              ),
              onFieldSubmitted: (_) {
                goToPage(
                  context,
                  SearchedArticlePaged(
                    query: _textController.text,
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
                return buildListOfArticles(screenDimension, state);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListOfArticles(Size _screenDimention, ArticlesState state) {
    if (state is ArticlesFetchLoading) {
      return Expanded(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(6),
          itemCount: 5,
          itemBuilder: (context, index) {
            return const ShimmerHomeArticleCard();
          },
        ),
      );
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
