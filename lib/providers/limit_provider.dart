import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_gallery/utils/limits.dart';

class RequestLimitNotifier extends StateNotifier<int> {
  RequestLimitNotifier() : super(kDefaultRequestLimit);

  void setLimit(int limit) {
    state = limit;
  }
}

/// Request limit provider that defines how many images should be fetched per
/// request.
final requestLimitProvider = StateNotifierProvider<RequestLimitNotifier, int>((ref) {
  return RequestLimitNotifier();
});
