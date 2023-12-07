import 'package:equatable/equatable.dart';

class Client extends Equatable {
  final int? id;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? photo;
  final String? address;
  final String? caption;

  const Client({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.photo,
    this.address,
    this.caption,
  });

  @override
  List<Object?> get props => [id];

  @override
  String toString() {
    return 'firstname: $firstname, lastname: $lastname, email: $email, id: $id, address: $address, caption: $caption.';
  }
}

/*
{
  "id": 1264,
  "firstname": "Mario",
  "lastname": "Pérez",
  "email": "maritoperez@agencycoda.com",
  "photo": "",
  "address": "",
  "caption": "",
}
*/