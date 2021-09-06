import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/utils/colors.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';
import 'package:noobs2pro_app/widgets/images.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlePage extends StatelessWidget {
  final Article _article;
  ArticlePage(this._article, {Key? key}) : super(key: key);

  final HtmlUnescape unEscapedString = HtmlUnescape();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_article.category!),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(12.0),
        children: [
          Column(
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
              spacer(height: 6.0),
              Text(getFormattedDate(_article.date!))
            ],
          ),
          Html(
            data: _article.content,
            onLinkTap: (url, context, attributes, element) {
              launch(url!);
            },
            onImageTap: (url, context, attributes, element) {
              //might do someting with image over here
            },
            customImageRenders: {
              networkSourceMatcher(): myNetworkImageRender(),
            },
            style: {
              "body": Style(margin: EdgeInsets.zero, padding: EdgeInsets.zero),
              "figure": Style(margin: EdgeInsets.zero),
              'a': aTagStyle,
              'p, h1, h2, h3, h4, h5, h6': allTags,
            },
            shrinkWrap: true,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () => shareArticle(_article),
        child: const Icon(Icons.share),
      ),
    );
  }

  ImageRender myNetworkImageRender() => (context, attributes, element) {
        return CachedNetworkImage(
          // fit: BoxFit.cover,
          imageUrl: attributes['src'] ?? '',
          placeholder: (context, url) => buildPlaceholderImage(),
          imageBuilder: (context, image) =>
              buildArticleNetworkImage(context, image),
          errorWidget: (context, url, error) => buildPlaceholderImage(),
        );
      };

  Widget buildArticleNetworkImage(
    BuildContext context,
    ImageProvider<Object> image, {
    double? height,
    double? width,
  }) {
    return SizedBox(
      height: height ?? 200,
      width: width ?? double.maxFinite,
      child: PhotoView.customChild(
        initialScale: PhotoViewComputedScale.contained,
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.contained,
        backgroundDecoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Container(
          height: height ?? 200,
          width: width ?? double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: image,
              // borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
