import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/models/models.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';

class HomeCard extends StatelessWidget {
  final Article _article;
  final Size _screenDimention;
  const HomeCard(
    this._article,
    this._screenDimention, {
    Key? key,
  }) : super(key: key);

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
              CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: _article.featuredMedia!.medium!,
                placeholder: (context, url) => Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/placeholder.png'),
                    ),
                  ),
                ),
                imageBuilder: (context, image) => Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: image,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/placeholder.png'),
                    ),
                  ),
                ),
              ),
              Text(
                _article.title!,
                style: articleTitle,
                textAlign: TextAlign.left,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getFormattedDate(_article.date!)),
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
