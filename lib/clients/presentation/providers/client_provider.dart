import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tots_flutter_test/clients/domain/entities/client.dart';
import 'package:tots_flutter_test/clients/domain/repositories/clients_repository.dart';
import 'package:tots_flutter_test/clients/presentation/providers/providers.dart';

// this provider gets only one client by its id

final getClientProvider = FutureProvider.autoDispose.family<Client?, int>((ref, clientId) async {
  final ClientsRepository repository = ref.watch(repositoryProvider);
  final resp = await repository.getClient(clientId: clientId);

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
