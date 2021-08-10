import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:noobs2pro_app/models/models.dart';
import 'package:noobs2pro_app/utils/colors.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';

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
        // padding: const EdgeInsets.all(12.0),
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
          Html(
            data: _article.content,

            // onLinkTap: (String? url, RenderContext context,
            //     Map<String, String> attributes, dom.Element? element) {
            //   //open URL in webview, or launch URL in browser, or any other logic here
            // },
            // onImageTap: (String? url, RenderContext context,
            //     Map<String, String> attributes, dom.Element? element) {
            //   //open image in webview, or launch image in browser, or any other logic here
            // }

            customImageRenders: {
              networkSourceMatcher(): networkImageRender(
                width: 800,
                altWidget: (alt) => Text(alt ?? ""),
                loadingWidget: () => buildPlaceholderImage(),
              ),
            },
            // style: {
            //   'img': Style(
            //     width: 10,
            //   )
            // },
          )
        ],
      ),
    );
  }

  Widget buildNetworkImage(ImageProvider<Object> image) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: image,
        ),
      ),
    );
  }

  Widget buildPlaceholderImage() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/placeholder.png'),
        ),
      ),
    );
  }
}
