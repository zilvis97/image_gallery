import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery/widgets/image_list.dart';

class GalleryHomeScreen extends StatefulWidget {
  const GalleryHomeScreen({super.key});

  @override
  State<GalleryHomeScreen> createState() => _GalleryHomeScreenState();
}

class _GalleryHomeScreenState extends State<GalleryHomeScreen> {
  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  void _loadImages() async {
    final url = Uri.parse('https://picsum.photos/v2/list');
    try {
      final res = await http.get(url, headers: {'Content-Type': 'application/json'});
      final body = jsonDecode(res.body);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Gallery')),
      body: const ImageGallery(),
    );
  }
}
