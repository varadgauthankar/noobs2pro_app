import 'package:flutter/material.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/services/hive_service.dart';
import 'package:noobs2pro_app/widgets/circular_progress_bar.dart';
import 'package:noobs2pro_app/widgets/home_card.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenDimention = MediaQuery.of(context).size;

    return Scaffold(
      body: buildListOfArticles(screenDimention),
    );
  }

  Widget buildListOfArticles(Size _screenDimention) {
    final HiveService _hiveService = HiveService();
    return ValueListenableBuilder(
      valueListenable: _hiveService.allArticleBox.listenable(),
      builder: (context, Box<Article> box, _) {
        if (box.isEmpty) {
          return const CenteredCircularProgressBar();
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(6),
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              final Article _article = box.values.toList().elementAt(index);
              return HomeCard(
                _article,
                _screenDimention,
              );
            },
          );
        }
      },
    );
  }
}
