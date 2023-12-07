import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tots_flutter_test/clients/domain/entities/client.dart';
import 'package:tots_flutter_test/clients/domain/repositories/clients_repository.dart';
import 'package:tots_flutter_test/clients/presentation/providers/clients_provider.dart';
import 'package:tots_flutter_test/clients/presentation/providers/providers.dart';
import 'package:tots_flutter_test/core/routes/routes.dart';

// this provider creates a new client or edits an existing one

final createEditProvider = AutoDisposeAsyncNotifierProvider<CreateNotifier, dynamic>(() {
  return CreateNotifier();
});

class CreateNotifier extends AutoDisposeAsyncNotifier {
  @override
  FutureOr build() {}

  Future<void> createNew(
    BuildContext context,
    Client client,
  ) async {
    final ClientsRepository repository = ref.watch(repositoryProvider);
    final resp = await repository.createClient(client: client);

    resp.fold(
      (fail) {
        fail.showError();
      },
      (success) {
        // 2-navigate
        ref.invalidate(getClientsProvider);
        ref.watch(appRouterProvider).goNamed(AppRoutes.homeScreen);
        // 3-show message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: client.id == null ? Colors.green : Colors.blue,
            content: SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  client.id == null
                      ? 'New client:\n${success.firstname} ${success.lastname}, id: ${success.id}\nCreated !'
                      : 'Client ${success.id} was updated !',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
