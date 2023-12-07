import 'package:dartz/dartz.dart';
import 'package:tots_flutter_test/clients/domain/entities/client.dart';
import 'package:tots_flutter_test/clients/domain/entities/clients_list.dart';
import 'package:tots_flutter_test/core/network/try_api.dart';

abstract class ClientsRepository {
  Future<Either<Failure, ClientsList>> getClientsList({required int page});
  Future<Either<Failure, Client>> getClient({required int clientId});
  Future<Either<Failure, Client>> createClient({required Client client});
  Future<Either<Failure, bool>> deleteClient({required int clientId});
}
