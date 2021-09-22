import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/pages/pages.dart';
import 'package:noobs2pro_app/services/hive_service.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';
import 'package:noobs2pro_app/widgets/exception_graphic_widget.dart';
import 'package:noobs2pro_app/widgets/home_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _textController = TextEditingController();
  final _articlesFromBox = HiveService().getArticlesShuffled();

  @override
  void initState() {
    super.initState();
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
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
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
                      size: 20,
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
          _buildListOfArticles(screenDimension),
        ],
      ),
    );
  }

  Widget _buildListOfArticles(Size _screenDimension) {
    if (_articlesFromBox.isEmpty) {
      return const ExceptionGraphic(
        message: 'Something went wrong!',
        assetName: 'void.svg',
      );
    } else if (_articlesFromBox.isNotEmpty) {
      return Expanded(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(6),
          itemCount: _articlesFromBox.length,
          itemBuilder: (context, index) {
            final Article _article = _articlesFromBox.elementAt(index);
            return HomeCard(
              _article,
              _screenDimension,
            );
          },
        ),
      );
    } else {
      return const ExceptionGraphic(
        message: 'Something went wrong!',
        assetName: 'void.svg',
      );
    }
  }
}
