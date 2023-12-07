import 'package:tots_flutter_test/clients/domain/entities/client.dart';
import 'package:tots_flutter_test/clients/domain/entities/clients_list.dart';

abstract class ClientsDatasource {
  Future<Client> getClient({required int clientId});
  Future<bool> deleteClient({required int clientId});
  Future<ClientsList> getClientsList({required int page});
  Future<Client> createClient({required Client client});
}
