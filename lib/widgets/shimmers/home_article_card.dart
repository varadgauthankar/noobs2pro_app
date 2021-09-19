import 'package:flutter/material.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/widgets/shimmers/shimmer_widget.dart';

class ShimmerHomeArticleCard extends StatelessWidget {
  const ShimmerHomeArticleCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenDimension = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerWidget(
            height: screenDimension.height * .25,
          ),
          spacer(height: 12.0),
          const ShimmerWidget(height: 22),
        ],
      ),
    );
  }
}
