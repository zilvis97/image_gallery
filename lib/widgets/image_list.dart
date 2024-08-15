import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_gallery/exceptions/offline_exception.dart';
import 'package:image_gallery/models/image_data.dart';
import 'package:image_gallery/providers/authors_provider.dart';
import 'package:image_gallery/providers/limit_provider.dart';
import 'package:image_gallery/utils/image_service.dart';
import 'package:image_gallery/utils/show_snackbar.dart';
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
      final fetchedImages = await fetchImages(ref, page: _currentPage);

      setState(() {
        _images.addAll(fetchedImages!);
        if (fetchedImages.length < limit) {
          _hasMore = false;
        }
        _isLoading = false;
        _currentPage++;
      });
    } on IsOfflineException {
      showSnackbar(context, message: "You're offline. Please go online and try again");
    } catch (error) {
      if (context.mounted) {
        showSnackbar(context, message: 'An error has occurred while fetching the images');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final filteredAuthors = ref.watch(selectedAuthorsProvider);
    final filteredImages = filteredAuthors.isEmpty
        ? _images
        : _images.where((image) => filteredAuthors.contains(image.author)).toList();

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _images.clear();
        });
        return _loadImages();
      },
      child: ListView.builder(
        controller: _scrollController,
        itemCount: filteredImages.length + 1,
        itemBuilder: (context, index) {
          if (index < filteredImages.length) {
            return ImageItem(filteredImages[index]);
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: _hasMore
                  ? filteredAuthors.isNotEmpty
                      ? Text(
                          "You're all caught up with this author's work!",
                          style: theme.textTheme.bodyLarge!.copyWith(fontSize: 24),
                        )
                      : const CircularProgressIndicator()
                  : Text(
                      "You're all caught up. No more images to load.",
                      style: theme.textTheme.bodyLarge!.copyWith(fontSize: 24),
                    ),
            ),
          );
        },
      ),
    );
  }
}
