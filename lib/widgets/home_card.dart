import 'package:flutter/material.dart';
import 'package:noobs2pro_app/models/article.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 400,
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FutureBuilder(
            //   future: BlocProvider.of<MediaBloc>(context).add(FetchMedia(_article.featuredMediaId)),
            //   builder: (context, data){
            //     return Text(data.data.toString());

            // }),
            Text(
              widget._article.title!,
              style: articleTitle,
              textAlign: TextAlign.left,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget._article.date!),
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
    );
  }
}
