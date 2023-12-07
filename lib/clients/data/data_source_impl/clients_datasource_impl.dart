import 'package:tots_flutter_test/clients/data/mappers/client_mapers.dart';
import 'package:tots_flutter_test/clients/data/models/client_model.dart';
import 'package:tots_flutter_test/clients/data/models/clients_list_model.dart';
import 'package:tots_flutter_test/clients/domain/data_source/clients_datasource.dart';
import 'package:tots_flutter_test/clients/domain/entities/client.dart';
import 'package:tots_flutter_test/clients/domain/entities/clients_list.dart';
import 'package:tots_flutter_test/core/network/connection_checker.dart';
import 'package:tots_flutter_test/core/network/dio_http_client.dart';
import 'package:tots_flutter_test/core/network/error_model.dart';
import 'package:tots_flutter_test/core/network/try_api.dart';

class ClientsDatasourceImpl extends ClientsDatasource {
  final ConnectionChecker connection = ConnectionChecker();
  final ClientMappers mapper = ClientMappers();

  // get a client
  @override
  Future<Client> getClient({required int clientId}) async {
    final DioHttpClient dioClient = DioHttpClientImpl(connection: connection);

    // make call
    final response = await dioClient.get('/client/fetch/$clientId');
    // if error
    if (response.data['success'] == false) {
      final data = ErrorModel.fromJson(response.data);
      throw DefaultCustomError(data.error.message, data.error.code);
    }
    // return client
    return mapper.clientMapper(
      ClientModel.fromJson(response.data['response']),
    );
  }

  // get all clients
  @override
  Future<ClientsList> getClientsList({required int page}) async {
    final DioHttpClient dioClient = DioHttpClientImpl(connection: connection);
    // make call
    final response = await dioClient.post(
      '/client/list',
      queryParameters: {
        'page': page,
        'limit': 5,
      },
    );
    // if error
    if (response.data['success'] == false) {
      final data = ErrorModel.fromJson(response.data);
      throw DefaultCustomError(data.error.message, data.error.code);
    }
    // return client
    return mapper.clientsListMapper(
      ClientsListModel.fromJson(response.data['response']),
    );
  }

  // create / update client
  @override
  Future<Client> createClient({required Client client}) async {
    final DioHttpClient dioClient = DioHttpClientImpl(connection: connection);
    // make call
    final response = await dioClient.post(
      '/client/save',
      queryParameters: {
        'id': client.id,
        'firstname': client.firstname,
        'lastname': client.lastname,
        'email': client.email,
        'address': client.address,
        'caption': client.caption,
        'photo': client.photo,
      },
    );
    // if error
    if (response.data['success'] == false) {
      final data = ErrorModel.fromJson(response.data);
      throw DefaultCustomError(data.error.message, data.error.code);
    }
    // return client
    return mapper.clientMapper(
      ClientModel.fromJson(response.data['response']),
    );
  }

  // delete client
  @override
  Future<bool> deleteClient({required int clientId}) async {
    final DioHttpClient dioClient = DioHttpClientImpl(connection: connection);
    // make call
    final response = await dioClient.delete(
      '/client/remove/$clientId',
    );
    // if error
    if (response.data['success'] == false) {
      final data = ErrorModel.fromJson(response.data);
      throw DefaultCustomError(data.error.message, data.error.code);
    }
    // return
    return true;
  }
}
