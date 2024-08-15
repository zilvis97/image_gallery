import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery/models/image_data.dart';

class ImageItem extends StatelessWidget {
  const ImageItem(this.image, {super.key});

  final ImageData image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 32),
      child: CachedNetworkImage(
        imageUrl: image.downloadUrl,
        placeholder: (_, __) => const Icon(Icons.photo_outlined),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
