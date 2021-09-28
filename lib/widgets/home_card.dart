import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:noobs2pro_app/blocs/article_saving/bloc/article_saving_bloc.dart';
import 'package:noobs2pro_app/blocs/connectivity/bloc/connectivity_bloc.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/pages/article_apge.dart';
import 'package:noobs2pro_app/services/firebase_auth.dart';
import 'package:noobs2pro_app/utils/colors.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';
import 'package:noobs2pro_app/widgets/images.dart';

class HomeCard extends StatefulWidget {
  final Article _article;
  final Size _screenDimension;
  const HomeCard(
    this._article,
    this._screenDimension, {
    Key? key,
  }) : super(key: key);

  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  final HtmlUnescape unEscapedString = HtmlUnescape();

  ArticleSavingBloc? _bloc;
  ConnectivityBloc? _connectivityBloc;
  bool _isInternet = false;

  @override
  void initState() {
    _bloc = ArticleSavingBloc(
        firebaseUserId: FirebaseAuthService().getCurrentUserUid() ?? '');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc!,
      child: MultiBlocListener(
        listeners: [
          BlocListener<ArticleSavingBloc, ArticleSavingState>(
            listener: (context, state) {
              if (state is ArticleSavingError) {
                showMySnackBar(context, message: state.error);
              }
            },
          ),
          BlocListener<ConnectivityBloc, ConnectivityState>(
            listener: (context, state) {
              if (state is ConnectivityOnline) {
                setState(() {
                  _isInternet = true;
                });
              }
              if (state is ConnectivityOffline) {
                setState(() {
                  _isInternet = false;
                });
                // showMySnackBar(context, message: 'No internet connection');
              }
            },
          ),
        ],
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticlePage(widget._article),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'image${widget._article.id}',
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: widget._article.featuredMedia?.medium ?? '',
                    placeholder: (context, _) => buildPlaceholderImage(
                      context,
                      height: widget._screenDimension.height * .25,
                    ),
                    imageBuilder: (context, image) => buildNetworkImage(
                      image,
                      height: widget._screenDimension.height * .25,
                    ),
                    errorWidget: (context, _, err) => buildPlaceholderImage(
                      context,
                      height: widget._screenDimension.height * .25,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${getFormattedDate(widget._article.date!)} - ${widget._article.category}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Wrap(
                      children: [
                        IconButton(
                          color: widget._article.isSaved == true
                              ? kAccentColor
                              : isThemeDark(context)
                                  ? kWhite
                                  : kBlack,
                          icon: Icon(
                            widget._article.isSaved == true
                                ? EvaIcons.bookmark
                                : EvaIcons.bookmarkOutline,
                          ),
                          onPressed: () {
                            _connectivityBloc = ConnectivityBloc()
                              ..add(ListenConnection());

                            if (FirebaseAuthService().isSignedIn()) {
                              if (_isInternet) {
                                widget._article.isSaved != true
                                    ? _bloc!
                                        .add(ArticleSaveEvent(widget._article))
                                    : _bloc!.add(
                                        ArticleUnSaveEvent(widget._article));
                              } else {
                                showMySnackBar(
                                  context,
                                  message: 'No internet connection!',
                                );
                              }
                            } else {
                              showMyMaterialBanner(
                                context,
                                title: 'Sign in',
                                subtitle: 'Sign in to save articles',
                                isSignInBanner: true,
                              );
                            }

                            //TODO: optimise this
                            setState(() {});
                          },
                          visualDensity: VisualDensity.compact,
                        ),
                        IconButton(
                          icon: const Icon(Icons.share_outlined),
                          onPressed: () => shareArticle(widget._article),
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
