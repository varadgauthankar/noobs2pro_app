import 'package:flutter/material.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/widgets/shimmers/shimmer_widget.dart';

class ShimmerSmallArticleCard extends StatelessWidget {
  const ShimmerSmallArticleCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenDimension = MediaQuery.of(context).size;

    return Container(
      height: screenDimension.height * .12,
      margin: const EdgeInsets.all(4.0),
      width: double.maxFinite,
      child: Row(
        children: [
          ShimmerWidget(
            height: 200,
            width: screenDimension.height * .12,
          ),
          spacer(width: 6.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spacer(width: 3.0),
                const ShimmerWidget(height: 18),
                const ShimmerWidget(height: 14, width: 100),
                spacer(width: 3.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
