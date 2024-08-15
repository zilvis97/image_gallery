import 'package:flutter/material.dart';
import 'package:image_gallery/widgets/image_list.dart';
import 'package:image_gallery/widgets/settings_dialog.dart';

class GalleryHomeScreen extends StatelessWidget {
  const GalleryHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Gallery'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_alt_outlined)),
          IconButton(
            onPressed: () => showDialog(context: context, builder: (ctx) => const SettingsDialog()),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: const ImageGallery(),
    );
  }
}
