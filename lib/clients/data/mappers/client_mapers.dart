import 'package:tots_flutter_test/clients/data/models/client_model.dart';
import 'package:tots_flutter_test/clients/data/models/clients_list_model.dart';
import 'package:tots_flutter_test/clients/domain/entities/client.dart';
import 'package:tots_flutter_test/clients/domain/entities/clients_list.dart';

class ClientMappers {
  ///
  Client clientMapper(ClientModel value) {
    return Client(
      id: value.id,
      firstname: value.firstname ?? "",
      lastname: value.lastname ?? "",
      email: value.email ?? "",
      address: value.address ?? "",
      caption: value.caption ?? "",
      photo: value.photo ?? "",
    );
  }

  Link linkMapper(LinkModel value) {
    return Link(
      url: value.url,
      label: value.label,
      active: value.active,
    );
  }

  ClientsList clientsListMapper(ClientsListModel value) {
    return ClientsList(
      currentPage: value.currentPage,
      data: value.data.map((e) => clientMapper(e)).toList(),
      firstPageUrl: value.firstPageUrl,
      lastPageUrl: value.lastPageUrl,
      from: value.from,
      to: value.to,
      lastPage: value.lastPage,
      links: value.links.map((e) => linkMapper(e)).toList(),
      prevPageUrl: value.prevPageUrl ?? "",
      nextPageUrl: value.nextPageUrl ?? "",
      path: value.path,
      perPage: value.perPage,
      total: value.total,
    );
  }
}
