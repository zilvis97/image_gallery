import 'package:flutter/material.dart';
import 'package:image_gallery/widgets/filter_drawer.dart';
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
          Builder(
            builder: (context) => TextButton.icon(
              label: const Text('Filter'),
              icon: const Icon(Icons.filter_alt_outlined),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
          TextButton.icon(
            label: const Text('Settings'),
            icon: const Icon(Icons.settings),
            onPressed: () => showDialog(context: context, builder: (ctx) => const SettingsDialog()),
          ),
        ],
      ),
      endDrawer: const FiltersDrawer(),
      body: const ImageGallery(),
    );
  }
}
