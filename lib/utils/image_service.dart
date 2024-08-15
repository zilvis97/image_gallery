import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_gallery/models/image_data.dart';

Future<List<ImageData>?> fetchImages({required int page, required int limit}) async {
  final url = Uri.parse('https://picsum.photos/v2/list?page=$page&limit=$limit');
  List<ImageData> images = [];

  final res = await http.get(url, headers: {'Content-Type': 'application/json'});

  if (res.statusCode == 200) {
    final body = jsonDecode(res.body);
    if (body.isNotEmpty) {
      for (final image in body) {
        images.add(
          ImageData(
            id: image['id'],
            author: image['author'],
            width: image['width'],
            height: image['height'],
            url: image['url'],
            downloadUrl: image['download_url'],
          ),
        );
      }
      return images;
    }
  } else {
    throw Exception('The API threw an exception: ${res.body}');
  }
  return null;
}
