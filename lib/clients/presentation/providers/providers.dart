import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tots_flutter_test/clients/data/data_source_impl/clients_datasource_impl.dart';
import 'package:tots_flutter_test/clients/data/repositories_impl/clients_repository_impl.dart';
import 'package:tots_flutter_test/clients/domain/data_source/clients_datasource.dart';
import 'package:tots_flutter_test/clients/domain/repositories/clients_repository.dart';

// acceso al datasource
final dataSourceProvider = Provider<ClientsDatasource>(
  (ref) => ClientsDatasourceImpl(),
);

// acceso al repositorio
final repositoryProvider = Provider<ClientsRepository>(
  (ref) => ClientsRepositoryImpl(ref.watch(dataSourceProvider)),
);
