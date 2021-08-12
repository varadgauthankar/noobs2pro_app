import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:noobs2pro_app/models/models.dart';
import 'package:noobs2pro_app/utils/colors.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';
import 'package:noobs2pro_app/widgets/images.dart';
import 'package:photo_view/photo_view.dart';

class ArticlePage extends StatelessWidget {
  final Size? screenDimention;
  final Article _article;
  ArticlePage(this._article, {Key? key, this.screenDimention})
      : super(key: key);

  HtmlUnescape unEscapedString = HtmlUnescape();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_article.category!),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          Container(
            // padding: const EdgeInsets.all(6.0),
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
                    errorWidget: (context, url, error) =>
                        buildPlaceholderImage(),
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
          ),
          const Divider(
            indent: 12,
            endIndent: 12,
            thickness: 1,
          ),
          // spacer(height: 6.0),
          Html(
            data: _article.content,
            onLinkTap: (url, context, attributes, element) {
              //TODO: launch url
            },
            onImageTap: (url, context, attributes, element) {
              //open image in webview, or launch image in browser, or any other logic here
            },
            customImageRenders: {
              networkSourceMatcher(): myNetworkImageRender(),
            },
            style: {
              "body": Style(margin: EdgeInsets.zero, padding: EdgeInsets.zero),
              "figure": Style(margin: EdgeInsets.zero),
              'a': aTagStyle,
              'p, h1, h2, h3, h4, h5, h6': pTag,
            },
            shrinkWrap: true,
          )
        ],
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
