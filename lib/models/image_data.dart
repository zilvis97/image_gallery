class ImageData {
  const ImageData({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.downloadUrl,
  });

  final String id;

  final String author;

  final double width;

  final double height;

  final String url;

  final String downloadUrl;
}
