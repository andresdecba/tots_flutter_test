import 'package:tots_flutter_test/clients/data/models/client_model.dart';

class ClientsListModel {
  final int currentPage;
  final List<ClientModel> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<LinkModel> links;
  final String path;
  final String perPage;
  final String? nextPageUrl;
  final String? prevPageUrl;
  final int to;
  final int total;

  ClientsListModel({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory ClientsListModel.fromJson(Map<String, dynamic> json) => ClientsListModel(
        currentPage: json["current_page"],
        data: List<ClientModel>.from(json["data"].map((x) => ClientModel.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<LinkModel>.from(json["links"]!.map((x) => LinkModel.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );
}

class LinkModel {
  final String? url;
  final String label;
  final bool active;

  LinkModel({
    this.url,
    required this.label,
    required this.active,
  });

  factory LinkModel.fromJson(Map<String, dynamic> json) => LinkModel(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );
}
