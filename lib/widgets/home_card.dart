import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/models/models.dart';
import 'package:noobs2pro_app/pages/article_apge.dart';
import 'package:noobs2pro_app/utils/colors.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:noobs2pro_app/widgets/images.dart';

class HomeCard extends StatelessWidget {
  final Article _article;
  final Size _screenDimention;
  HomeCard(
    this._article,
    this._screenDimention, {
    Key? key,
  }) : super(key: key);

  HtmlUnescape unEscapedString = HtmlUnescape();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticlePage(
              _article,
              screenDimention: _screenDimention,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'image${_article.id}',
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: _article.featuredMedia!.medium!,
                placeholder: (context, url) => buildPlaceholderImage(),
                imageBuilder: (context, image) => buildNetworkImage(image),
                errorWidget: (context, url, error) => buildPlaceholderImage(),
              ),
            ),
            spacer(height: 6.0),
            Hero(
              tag: 'title${_article.id}',
              child: Material(
                color: ktransparent,
                child: Text(
                  unEscapedString.convert(_article.title!),
                  style: articleTitle,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${getFormattedDate(_article.date!)} - ${_article.category}',
                  style: Theme.of(context).textTheme.caption,
                ),
                Wrap(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.bookmark_border_rounded),
                      onPressed: () {},
                      visualDensity: VisualDensity.compact,
                    ),
                    IconButton(
                      icon: const Icon(Icons.share_outlined),
                      onPressed: () {},
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
