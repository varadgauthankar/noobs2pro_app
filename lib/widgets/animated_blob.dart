import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:noobs2pro_app/utils/colors.dart';

class AnimatedBlob extends StatelessWidget {
  const AnimatedBlob({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Blob.animatedRandom(
      // id: const ['10-7-46635', '10-7-35931', '10-7-322'],
      size: 500,
      loop: true,
      duration: const Duration(seconds: 6),
      styles: BlobStyles(
        gradient: LinearGradient(
          colors: [kAccentColor, kAccentColor.withOpacity(0.85)],
        ).createShader(
          const Rect.fromLTRB(0, 0, 300, 300),
        ),
      ),
    );
  }
}
