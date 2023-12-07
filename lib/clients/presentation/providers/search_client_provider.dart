import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchProvider = AutoDisposeAsyncNotifierProvider<SearchNotifier, dynamic>(() {
  return SearchNotifier();
});

class SearchNotifier extends AutoDisposeAsyncNotifier {
  @override
  FutureOr build() {}
}
