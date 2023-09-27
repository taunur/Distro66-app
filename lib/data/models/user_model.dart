class UserModel {
  int? idUser;
  String? email;
  String? username;
  String? password;
  Name? name;
  Address? address;
  String? phone;
  String? token;

  UserModel({
    this.idUser,
    this.email,
    this.username,
    this.password,
    this.name,
    this.address,
    this.phone,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        idUser: json["id"],
        email: json["email"],
        username: json["username"],
        password: json["password"],
        name: Name.fromJson(json["name"]),
        address: Address.fromJson(json["address"]),
        phone: json["phone"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": idUser,
        "email": email,
        "username": username,
        "password": password,
        "name": name?.toJson(),
        "address": address?.toJson(),
        "phone": phone,
        "token": token,
      };
}

class Address {
  String? city;
  String? street;
  int? number;
  String? zipcode;
  Geolocation? geolocation;

  Address({
    this.city,
    this.street,
    this.number,
    this.zipcode,
    this.geolocation,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        city: json["city"],
        street: json["street"],
        number: json["number"],
        zipcode: json["zipcode"],
        geolocation: Geolocation.fromJson(json["geolocation"]),
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "street": street,
        "number": number,
        "zipcode": zipcode,
        "geolocation": geolocation?.toJson(),
      };
}

class Geolocation {
  String? lat;
  String? long;

  Geolocation({
    this.lat,
    this.long,
  });

  factory Geolocation.fromJson(Map<String, dynamic> json) => Geolocation(
        lat: json["lat"],
        long: json["long"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "long": long,
      };
}

class Name {
  String? firstname;
  String? lastname;

  Name({
    this.firstname,
    this.lastname,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        firstname: json["firstname"],
        lastname: json["lastname"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
      };
}
