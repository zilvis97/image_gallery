import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_gallery/models/image_data.dart';
import 'package:image_gallery/providers/limit_provider.dart';
import 'package:image_gallery/utils/image_service.dart';
import 'package:image_gallery/widgets/image_item.dart';

class ImageGallery extends ConsumerStatefulWidget {
  const ImageGallery({super.key});

  @override
  ConsumerState<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends ConsumerState<ImageGallery> {
  final List<ImageData> _images = [];
  var _currentPage = 1;
  var _isLoading = false;
  var _hasMore = true;

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadImages();

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent == _scrollController.offset) {
        _loadImages();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadImages() async {
    // To prevent accidental additional calls. This might happen when the user
    // is scrolling and the widget gets rebuilt multiple times.
    if (_isLoading || !_hasMore) return;

    try {
      setState(() => _isLoading = true);

      final limit = ref.read(requestLimitProvider);
      final fetchedImages = await fetchImages(page: _currentPage, limit: limit);
      print('Fetched ${fetchedImages?.length} images');

      setState(() {
        _images.addAll(fetchedImages!);
        if (fetchedImages.length < limit) {
          _hasMore = false;
        }
        _isLoading = false;
        _currentPage++;
      });
    } catch (error) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          const SnackBar(
            content: Center(child: Text('test')),
            padding: EdgeInsets.all(16),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _images.length + 1,
      itemBuilder: (context, index) {
        if (index < _images.length) {
          return ImageItem(_images[index]);
        }
        return Center(
          child: _hasMore
              ? const CircularProgressIndicator()
              : const Text("You're all caught up. No more images to load."),
        );
      },
    );
  }
}
