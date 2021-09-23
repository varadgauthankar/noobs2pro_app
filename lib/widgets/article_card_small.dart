import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:noobs2pro_app/blocs/article_saving/bloc/article_saving_bloc.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/pages/article_apge.dart';
import 'package:noobs2pro_app/services/firebase_auth.dart';
import 'package:noobs2pro_app/utils/colors.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';
import 'package:noobs2pro_app/widgets/images.dart';

class ArticleCardSmall extends StatefulWidget {
  final Article _article;
  final bool isFromCategory;
  const ArticleCardSmall(this._article, {Key? key, this.isFromCategory = false})
      : super(key: key);

  @override
  _ArticleCardSmallState createState() => _ArticleCardSmallState();
}

class _ArticleCardSmallState extends State<ArticleCardSmall> {
  final HtmlUnescape unEscapedString = HtmlUnescape();

  @override
  Widget build(BuildContext context) {
    final ArticleSavingBloc _bloc = ArticleSavingBloc(
        firebaseUserId: FirebaseAuthService().getCurrentUserUid() ?? '');
    final screenDimention = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticlePage(widget._article),
          ),
        );
      },
      child: Container(
        height: screenDimention.height * .12,
        margin: const EdgeInsets.all(4.0),
        width: double.maxFinite,
        child: Row(
          children: [
            Hero(
              tag: 'image${widget._article.id}',
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: widget._article.featuredMedia!.thumbnail!,
                placeholder: (context, _) => buildPlaceholderImage(
                  context,
                  width: screenDimention.height * .12,
                  height: screenDimention.height * .12,
                  borderRadius: 8.0,
                ),
                imageBuilder: (context, image) => buildNetworkImage(
                  image,
                  width: screenDimention.height * .12,
                  height: screenDimention.height * .12,
                  borderRadius: 8.0,
                ),
                errorWidget: (context, _, err) => buildPlaceholderImage(
                  context,
                  width: screenDimention.height * .12,
                  height: screenDimention.height * .12,
                  borderRadius: 8.0,
                ),
              ),
            ),
            spacer(width: 6.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    unEscapedString.convert(widget._article.title!),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: articleTitle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.isFromCategory)
                          Text(
                            getFormattedDate(widget._article.date!),
                            style: Theme.of(context).textTheme.caption,
                          )
                        else
                          Text(
                            '${getFormattedDate(widget._article.date!)} - ${widget._article.category}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        Wrap(
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () {
                                setState(() {});
                                widget._article.isSaved != true
                                    ? _bloc
                                        .add(ArticleSaveEvent(widget._article))
                                    : _bloc.add(
                                        ArticleUnSaveEvent(widget._article));
                              },
                              child: Icon(
                                widget._article.isSaved == true
                                    ? EvaIcons.bookmark
                                    : EvaIcons.bookmarkOutline,
                                color: widget._article.isSaved == true
                                    ? kAccentColor
                                    : isThemeDark(context)
                                        ? kWhite
                                        : kBlack,
                              ),
                            ),
                            spacer(width: 6.0),
                            InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () => shareArticle(widget._article),
                              child: const Icon(Icons.share),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
