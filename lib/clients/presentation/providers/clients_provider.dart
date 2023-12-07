import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tots_flutter_test/clients/domain/entities/clients_list.dart';
import 'package:tots_flutter_test/clients/domain/repositories/clients_repository.dart';
import 'package:tots_flutter_test/clients/presentation/providers/providers.dart';

// this provider gets all the clients

final pageNumberProvider = StateProvider<int>((ref) {
  return 1;
});

final getClientsProvider = FutureProvider.autoDispose<ClientsList?>((ref) async {
  final page = ref.watch(pageNumberProvider);

  final ClientsRepository repository = ref.watch(repositoryProvider);
  final resp = await repository.getClientsList(page: page);

  return resp.fold(
    (fail) {
      fail.showError();
      return null;
    },
    (success) {
      return success;
    },
  );
});
