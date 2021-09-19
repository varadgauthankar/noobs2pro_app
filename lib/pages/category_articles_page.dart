import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noobs2pro_app/blocs/articles_fetch/bloc/articles_bloc.dart';
import 'package:noobs2pro_app/blocs/articles_fetch/repository/articles_repository_impl.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/services/firebase_auth.dart';
import 'package:noobs2pro_app/services/hive_service.dart';
import 'package:noobs2pro_app/utils/colors.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';
import 'package:noobs2pro_app/widgets/article_card_small.dart';
import 'package:noobs2pro_app/widgets/circular_progress_bar.dart';

class CategoryArticlesPage extends StatefulWidget {
  final int categoryId;
  final String categoryTitle;
  const CategoryArticlesPage({
    Key? key,
    required this.categoryId,
    required this.categoryTitle,
  }) : super(key: key);

  @override
  _CategoryArticlesPageState createState() => _CategoryArticlesPageState();
}

class _CategoryArticlesPageState extends State<CategoryArticlesPage> {
  ArticlesBloc? _articlesBloc;

  @override
  void initState() {
    super.initState();

    _articlesBloc = ArticlesBloc(
      ArticlesRepositoryImpl(),
      firebaseUserId: FirebaseAuthService().getCurrentUserUid() ?? '',
    );

    _articlesBloc?.add(FetchCategoryArticlesEvent(widget.categoryId));
  }

  @override
  Widget build(BuildContext context) {
    final Size screenDimention = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryTitle,
          style: appBarTitleStyle.copyWith(
            color: isThemeDark(context) ? kWhite : kBlack,
          ),
        ),
      ),
      body: BlocProvider(
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
    );
  }

  Widget buildListOfArticles(Size _screenDimention, ArticlesState state) {
    final HiveService _hiveService = HiveService();
    return ValueListenableBuilder(
      valueListenable: _hiveService.categoryArticlesBox.listenable(),
      builder: (context, Box<Article> box, _) {
        if (state is ArticlesFetchLoading) {
          return const CenteredCircularProgressBar();
        } else if (state is ArticlesFetchComplete) {
          // print(box.values.length);
          return ListView.builder(
            padding: const EdgeInsets.all(6),
            itemCount: state.articles.length,
            itemBuilder: (context, index) {
              final Article _article = state.articles.elementAt(index);
              return ArticleCardSmall(
                _article,
                // _screenDimention,
              );
            },
          );
        } else if (state is ArticlesFetchError) {
          //Todo: add graphics
          return Text(state.error);
        } else {
          return Text('');
        }
      },
    );
  }
}
