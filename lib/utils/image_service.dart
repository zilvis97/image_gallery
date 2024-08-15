import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery/models/image_data.dart';
import 'package:image_gallery/providers/authors_provider.dart';
import 'package:image_gallery/providers/limit_provider.dart';

Future<List<ImageData>?> fetchImages(WidgetRef ref, {required int page}) async {
  final limit = ref.read(requestLimitProvider);

  final url = Uri.parse('https://picsum.photos/v2/list?page=$page&limit=$limit');
  List<ImageData> images = [];

  final res = await http.get(url, headers: {'Content-Type': 'application/json'});

  if (res.statusCode == 200) {
    final body = jsonDecode(res.body);
    if (body.isNotEmpty) {
      for (final image in body) {
        final imageData = ImageData(
          id: image['id'],
          author: image['author'],
          width: image['width'],
          height: image['height'],
          url: image['url'],
          downloadUrl: image['download_url'],
        );
        images.add(imageData);
        ref.read(authorsProvider.notifier).addAuthor(imageData.author);
      }
      return images;
    }
  } else {
    throw Exception('The API threw an exception: ${res.body}');
  }
  return null;
}
