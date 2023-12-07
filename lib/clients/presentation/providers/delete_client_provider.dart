import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tots_flutter_test/clients/domain/repositories/clients_repository.dart';
import 'package:tots_flutter_test/clients/presentation/providers/clients_provider.dart';
import 'package:tots_flutter_test/clients/presentation/providers/providers.dart';
import 'package:tots_flutter_test/core/routes/routes.dart';

// this provider deletes an existing client

final deleteClientProvider = FutureProvider.autoDispose.family<bool, int>((ref, clientId) async {
  final ClientsRepository repository = ref.watch(repositoryProvider);
  final resp = await repository.deleteClient(clientId: clientId);
  final BuildContext context = rootNavigatorKey.currentContext!;

  return resp.fold(
    (fail) {
      fail.showError();
      return false;
    },
    (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: SizedBox(
            height: 100,
            child: Center(
              child: Text(
                'Client deleted',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
      ref.invalidate(getClientsProvider);
      return success;
    },
  );
});
