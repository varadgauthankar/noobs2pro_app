import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:noobs2pro_app/blocs/article_saving/bloc/article_saving_bloc.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/services/firebase_auth.dart';
import 'package:noobs2pro_app/utils/colors.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';
import 'package:noobs2pro_app/widgets/images.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlePage extends StatefulWidget {
  final Article _article;
  ArticlePage(this._article, {Key? key}) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final HtmlUnescape unEscapedString = HtmlUnescape();

  Size _screenDimension = Size.zero;

  @override
  Widget build(BuildContext context) {
    final ArticleSavingBloc _bloc = ArticleSavingBloc(
        firebaseUserId: FirebaseAuthService().getCurrentUserUid() ?? '');
    _screenDimension = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget._article.category!,
          style: appBarTitleStyle.copyWith(
            color: isThemeDark(context) ? kWhite : kBlack,
          ),
        ),
        actions: [
          BlocProvider(
            create: (context) => _bloc,
            child: BlocConsumer<ArticleSavingBloc, ArticleSavingState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    widget._article.isSaved!
                        ? _bloc.add(ArticleUnSaveEvent(widget._article))
                        : _bloc.add(ArticleSaveEvent(widget._article));
                    setState(() {});
                  },
                  icon: Icon(
                    widget._article.isSaved == true
                        ? EvaIcons.bookmark
                        : EvaIcons.bookmarkOutline,
                    color: widget._article.isSaved == true
                        ? kAccentColor
                        : isThemeDark(context)
                            ? kWhite
                            : kBlack,
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(12.0),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'image${widget._article.id}',
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: widget._article.featuredMedia!.medium!,
                  placeholder: (context, url) => buildPlaceholderImage(
                    context,
                    height: _screenDimension.height * .25,
                  ),
                  imageBuilder: (context, image) => buildNetworkImage(
                    image,
                    height: _screenDimension.height * .25,
                  ),
                  errorWidget: (context, url, error) => buildPlaceholderImage(
                    context,
                    height: _screenDimension.height * .25,
                  ),
                ),
              ),
              spacer(height: 6.0),
              Hero(
                tag: 'title${widget._article.id}',
                child: Material(
                  color: transparent,
                  child: Text(
                    unEscapedString.convert(widget._article.title!),
                    style: articleTitle,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              spacer(height: 6.0),
              Text(getFormattedDate(widget._article.date!))
            ],
          ),
          Html(
            data: widget._article.content,
            onLinkTap: (url, context, attributes, element) {
              launch(url!);
            },
            onImageTap: (url, context, attributes, element) {
              //might do something with image over here
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
        onPressed: () => shareArticle(widget._article),
        child: const Icon(Icons.share),
      ),
    );
  }

  ImageRender myNetworkImageRender() => (context, attributes, element) {
        return CachedNetworkImage(
          // fit: BoxFit.cover,
          imageUrl: attributes['src'] ?? '',
          placeholder: (context, url) => buildPlaceholderImage(
            context,
            height: _screenDimension.height * .25,
          ),
          imageBuilder: (context, image) => buildArticleNetworkImage(
            context,
            image,
            height: _screenDimension.height * .25,
          ),
          errorWidget: (context, url, error) => buildPlaceholderImage(
            context,
            height: _screenDimension.height * .25,
          ),
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
