import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_gallery/models/image_data.dart';

class ImageItem extends StatelessWidget {
  ImageItem(this.image, {super.key});

  final ImageData image;

  final customCacheManager = CacheManager(
    Config(
      'cacheKey',
      stalePeriod: const Duration(days: 3),
      maxNrOfCacheObjects: 100,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(64),
      child: Column(
        children: [
          Text(image.id),
          CachedNetworkImage(
            cacheManager: customCacheManager,
            imageUrl: image.downloadUrl,
            placeholder: (_, __) => const Icon(Icons.photo_outlined),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ],
      ),
    );
  }
}
