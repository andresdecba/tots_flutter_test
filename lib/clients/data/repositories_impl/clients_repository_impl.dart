import 'package:dartz/dartz.dart';
import 'package:tots_flutter_test/clients/domain/data_source/clients_datasource.dart';
import 'package:tots_flutter_test/clients/domain/entities/client.dart';
import 'package:tots_flutter_test/clients/domain/entities/clients_list.dart';
import 'package:tots_flutter_test/clients/domain/repositories/clients_repository.dart';
import 'package:tots_flutter_test/core/network/try_api.dart';

class ClientsRepositoryImpl extends ClientsRepository {
  ClientsRepositoryImpl(
    this.datasource,
  );

  final ClientsDatasource datasource;

  @override
  Future<Either<Failure, Client>> getClient({required int clientId}) async {
    return TryApiNetwork.call<Client>(
      function: () async => await datasource.getClient(clientId: clientId),
    );
  }

  @override
  Future<Either<Failure, ClientsList>> getClientsList({required int page}) async {
    return TryApiNetwork.call<ClientsList>(
      function: () async => await datasource.getClientsList(page: page),
    );
  }

  @override
  Future<Either<Failure, Client>> createClient({required Client client}) async {
    return TryApiNetwork.call(
      function: () => datasource.createClient(client: client),
    );
  }

  @override
  Future<Either<Failure, bool>> deleteClient({required int clientId}) async {
    return TryApiNetwork.call(
      function: () => datasource.deleteClient(clientId: clientId),
    );
  }
}
