import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery/models/image_data.dart';
import 'package:image_gallery/utils/show_snackbar.dart';

enum PhotoActions {
  share,
  download,
}

class ImageItem extends StatelessWidget {
  const ImageItem(this.image, {super.key});

  final ImageData image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 32),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: image.downloadUrl,
            placeholder: (_, __) => const Icon(Icons.photo_outlined),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageBuilder: (context, imageProvider) {
              return Stack(
                children: [
                  Image(image: imageProvider),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: _PhotoMoreButton(image.url),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

class _PhotoMoreButton extends StatelessWidget {
  const _PhotoMoreButton(this.url);

  /// Url of the photo.
  final String url;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (selection) {
        if (selection == PhotoActions.download) {
        } else if (selection == PhotoActions.share) {
          showDialog(context: context, builder: (ctx) => _ShareImageDialog(url));
        }
      },
      position: PopupMenuPosition.under,
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: PhotoActions.download,
            child: Text('Download'),
          ),
          const PopupMenuItem(
            value: PhotoActions.share,
            child: Text('Share'),
          ),
        ];
      },
      child: const Icon(Icons.more_vert_outlined, size: 48),
    );
  }
}

class _ShareImageDialog extends StatelessWidget {
  const _ShareImageDialog(this.url);

  /// Link to the image.
  final String url;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text('Copy the image link to share'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Copy the image link'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: url),
                  readOnly: true,
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: url));
                  showSnackbar(context, message: 'Copied to clipboard!');
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.copy),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Close'),
        ),
      ],
    );
  }
}
