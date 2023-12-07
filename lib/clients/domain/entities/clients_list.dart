import 'package:equatable/equatable.dart';
import 'package:tots_flutter_test/clients/domain/entities/client.dart';

class ClientsList extends Equatable {
  final int currentPage;
  final List<Client> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<Link> links;
  final String nextPageUrl;
  final String path;
  final String perPage;
  final String prevPageUrl;
  final int to;
  final int total;

  const ClientsList({
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

  @override
  List<Object?> get props => [data];
}

class Link extends Equatable {
  final String? url;
  final String label;
  final bool active;

  const Link({
    this.url,
    required this.label,
    required this.active,
  });

  @override
  List<Object?> get props => [url];
}

/*

{
        "current_page": 10,
        "data": [
            {
                "id": 935,
                "firstname": "Luis",
                "lastname": "Perezz",
                "email": "luis@gmail.com",
                "address": "",
                "photo": "",
                "caption": "",
                "created_at": "2022-06-18T03:16:49.000000Z",
                "updated_at": "2022-06-19T02:44:19.000000Z",
                "deleted": 0
            },
            
        ],
        "first_page_url": "/?page=1",
        "from": 46,
        "last_page": 20,
        "last_page_url": "/?page=20",
        "links": [
            {
                "url": "/?page=9",
                "label": "Previous",
                "active": false
            },
            {
                "url": "/?page=1",
                "label": "1",
                "active": false
            },
            {
                "url": "/?page=2",
                "label": "2",
                "active": false
            },
            {
                "url": null,
                "label": "...",
                "active": false
            },
            {
                "url": "/?page=7",
                "label": "7",
                "active": false
            },
            {
                "url": "/?page=8",
                "label": "8",
                "active": false
            },
            {
                "url": "/?page=9",
                "label": "9",
                "active": false
            },
            {
                "url": "/?page=10",
                "label": "10",
                "active": true
            },
            {
                "url": "/?page=11",
                "label": "11",
                "active": false
            },
            {
                "url": "/?page=12",
                "label": "12",
                "active": false
            },
            {
                "url": "/?page=13",
                "label": "13",
                "active": false
            },
            {
                "url": null,
                "label": "...",
                "active": false
            },
            {
                "url": "/?page=19",
                "label": "19",
                "active": false
            },
            {
                "url": "/?page=20",
                "label": "20",
                "active": false
            },
            {
                "url": "/?page=11",
                "label": "Next",
                "active": false
            }
        ],
        "next_page_url": "/?page=11",
        "path": "/",
        "per_page": "5",
        "prev_page_url": "/?page=9",
        "to": 50,
        "total": 100
    }

    */