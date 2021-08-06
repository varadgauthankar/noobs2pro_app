import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noobs2pro_app/blocs/media_fetch/bloc/media_bloc.dart';
import 'package:noobs2pro_app/blocs/media_fetch/repository/media_repository_impl.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';

class HomeCard extends StatefulWidget {
  final Article _article;
  final Size _screenDimention;
  const HomeCard(
    this._article,
    this._screenDimention, {
    Key? key,
  }) : super(key: key);

  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  final MediaBloc _mediaBloc = MediaBloc(MediaRepositoryImpl());

  @override
  void initState() {
    super.initState();
    _mediaBloc.add(FetchMediaEvent(widget._article.featuredMedia!));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocProvider(
                create: (context) => _mediaBloc,
                child: BlocBuilder<MediaBloc, MediaState>(
                  builder: (context, state) {
                    if (state is MediaStateError) {
                      return buildPlaceholderImage();
                    } else if (state is MediaStateLoading) {
                      return buildPlaceholderImage();
                    } else if (state is MediaStateComplete) {
                      return buildNetworkImage(state.media.medium!);
                    }
                    return buildPlaceholderImage();
                  },
                ),
              ),
              Text(
                widget._article.title!,
                style: articleTitle,
                textAlign: TextAlign.left,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getFormattedDate(widget._article.date!)),
                  Wrap(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.bookmark_border_rounded),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.share_outlined),
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPlaceholderImage() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: const DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/placeholder.png'),
        ),
      ),
    );
  }

  Widget buildNetworkImage(String imageUrl) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: CachedNetworkImageProvider(imageUrl),
        ),
      ),
    );
  }
}
