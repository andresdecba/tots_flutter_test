import 'package:flutter_riverpod/flutter_riverpod.dart';

final pageNumberProvider = StateNotifierProvider<PageNumberNotifier, int>(
  (ref) => PageNumberNotifier(),
);

class PageNumberNotifier extends StateNotifier<int> {
  PageNumberNotifier() : super(1);

  void incrementPage() {
    state = state + 1;
  }

  void decrementPage() {
    if (state > 1) {
      state = state - 1;
    }
  }
}
