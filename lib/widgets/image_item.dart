import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery/models/image_data.dart';

class ImageItem extends StatelessWidget {
  const ImageItem(this.image, {super.key});

  final ImageData image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(image.id),
        CachedNetworkImage(
          width: 200, height: 200,
          imageUrl: image.downloadUrl,
          // progressIndicatorBuilder: (context, url, downloadProgress) =>
          //     CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ],
    );
  }
}
