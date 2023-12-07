class ClientModel {
  final int id;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? photo;
  final String? address;
  final String? caption;

  ClientModel({
    required this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.photo,
    this.address,
    this.caption,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        photo: json["photo"],
        address: json["address"],
        caption: json["caption"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "photo": photo,
        "address": address,
        "caption": caption,
      };
}
