import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/pages/article_apge.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';
import 'package:noobs2pro_app/widgets/images.dart';

class ArticleCardSmall extends StatelessWidget {
  final Article _article;
  ArticleCardSmall(this._article, {Key? key}) : super(key: key);

  final HtmlUnescape unEscapedString = HtmlUnescape();

  @override
  Widget build(BuildContext context) {
    final screenDimention = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticlePage(_article),
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
              tag: 'image${_article.id}',
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: _article.featuredMedia!.thumbnail!,
                placeholder: (context, _) => buildPlaceholderImage(
                  width: screenDimention.height * .12,
                  borderRadius: 8.0,
                ),
                imageBuilder: (context, image) => buildNetworkImage(
                  image,
                  width: screenDimention.height * .12,
                  borderRadius: 8.0,
                ),
                errorWidget: (context, _, err) => buildPlaceholderImage(
                  width: screenDimention.height * .12,
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
                    unEscapedString.convert(_article.title!),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: articleTitle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      '${getFormattedDate(_article.date!)} - ${_article.category}',
                      style: Theme.of(context).textTheme.caption,
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
