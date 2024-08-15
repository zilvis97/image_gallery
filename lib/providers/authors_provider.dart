import 'dart:core';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthorsNotifier extends StateNotifier<Set<String>> {
  AuthorsNotifier() : super({});

  void addAuthor(String author) {
    state.add(author);
  }
}

/// All available authors provider.
final authorsProvider = StateNotifierProvider<AuthorsNotifier, Set<String>>((ref) {
  return AuthorsNotifier();
});

class SelectedAuthorsNotifier extends StateNotifier<Set<String>> {
  SelectedAuthorsNotifier() : super({});

  void select(Set<String> selectedAuthors) {
    state = selectedAuthors;
  }
}

/// All selected authors in the filter.
final selectedAuthorsProvider = StateNotifierProvider<SelectedAuthorsNotifier, Set<String>>((ref) {
  return SelectedAuthorsNotifier();
});
