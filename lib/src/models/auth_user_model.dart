//LocalHost
import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  String accessToken;
  Payload payload;
  User user;
  int expiresIn;

  UserData({
    required this.accessToken,
    required this.payload,
    required this.user,
    required this.expiresIn,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        accessToken: json["access_token"],
        payload: Payload.fromJson(json["payload"]),
        user: User.fromJson(json["user"]),
        expiresIn: json["expires_in"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "payload": payload.toJson(),
        "user": user.toJson(),
        "expires_in": expiresIn,
      };
}

class Payload {
  List<String> roles;

  Payload({
    required this.roles,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        roles: List<String>.from(json["roles"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "roles": List<dynamic>.from(roles.map((x) => x)),
      };
}

class User {
  int id;
  String deviceToken;
  String estadoMensajeria;
  Persona persona;

  User({
    required this.id,
    required this.deviceToken,
    required this.estadoMensajeria,
    required this.persona,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        deviceToken: json["device_token"],
        estadoMensajeria: json["estadoMensajeria"],
        persona: Persona.fromJson(json["persona"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "device_token": deviceToken,
        "estadoMensajeria": estadoMensajeria,
        "persona": persona.toJson(),
      };
}

class Persona {
  int id;
  Contrato? contrato;

  Persona({
    required this.id,
    this.contrato,
  });

  factory Persona.fromJson(Map<String, dynamic> json) => Persona(
        id: json["id"],
        contrato: json["contrato"] != null
            ? Contrato.fromJson(json["contrato"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contrato": contrato?.toJson(),
      };
}

class Contrato {
  int id;

  Contrato({
    required this.id,
  });

  factory Contrato.fromJson(Map<String, dynamic> json) => Contrato(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}