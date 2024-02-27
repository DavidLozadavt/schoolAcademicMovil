// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
    UserDataClass userData;

    UserData({
        required this.userData,
    });

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        userData: UserDataClass.fromJson(json["userData"]),
    );

    Map<String, dynamic> toJson() => {
        "userData": userData.toJson(),
    };
}

class UserDataClass {
    int id;
    String email;
    int idPersona;
    DateTime emailVerifiedAt;
    Persona persona;

    UserDataClass({
        required this.id,
        required this.email,
        required this.idPersona,
        required this.emailVerifiedAt,
        required this.persona,
    });

    factory UserDataClass.fromJson(Map<String, dynamic> json) => UserDataClass(
        id: json["id"],
        email: json["email"],
        idPersona: json["idPersona"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        persona: Persona.fromJson(json["persona"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "idPersona": idPersona,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "persona": persona.toJson(),
    };
}

class Persona {
    int id;
    String identificacion;
    String nombre1;
    String nombre2;
    String apellido1;
    String apellido2;
    DateTime fechaNac;
    String direccion;
    String email;
    String telefonoFijo;
    String celular;
    String perfil;
    String sexo;
    String rh;
    String rutaFoto;
    int idTipoIdentificacion;
    int idCiudadNac;
    int idCiudadUbicacion;
    DateTime createdAt;
    DateTime updatedAt;
    String rutaFotoUrl;
    Ciudad ciudadUbicacion;
    Ciudad ciudadNac;

    Persona({
        required this.id,
        required this.identificacion,
        required this.nombre1,
        required this.nombre2,
        required this.apellido1,
        required this.apellido2,
        required this.fechaNac,
        required this.direccion,
        required this.email,
        required this.telefonoFijo,
        required this.celular,
        required this.perfil,
        required this.sexo,
        required this.rh,
        required this.rutaFoto,
        required this.idTipoIdentificacion,
        required this.idCiudadNac,
        required this.idCiudadUbicacion,
        required this.createdAt,
        required this.updatedAt,
        required this.rutaFotoUrl,
        required this.ciudadUbicacion,
        required this.ciudadNac,
    });

    factory Persona.fromJson(Map<String, dynamic> json) => Persona(
        id: json["id"],
        identificacion: json["identificacion"],
        nombre1: json["nombre1"],
        nombre2: json["nombre2"],
        apellido1: json["apellido1"],
        apellido2: json["apellido2"],
        fechaNac: DateTime.parse(json["fechaNac"]),
        direccion: json["direccion"],
        email: json["email"],
        telefonoFijo: json["telefonoFijo"],
        celular: json["celular"],
        perfil: json["perfil"],
        sexo: json["sexo"],
        rh: json["rh"],
        rutaFoto: json["rutaFoto"],
        idTipoIdentificacion: json["idTipoIdentificacion"],
        idCiudadNac: json["idCiudadNac"],
        idCiudadUbicacion: json["idCiudadUbicacion"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        rutaFotoUrl: json["rutaFotoUrl"],
        ciudadUbicacion: Ciudad.fromJson(json["ciudad_ubicacion"]),
        ciudadNac: Ciudad.fromJson(json["ciudad_nac"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "identificacion": identificacion,
        "nombre1": nombre1,
        "nombre2": nombre2,
        "apellido1": apellido1,
        "apellido2": apellido2,
        "fechaNac": "${fechaNac.year.toString().padLeft(4, '0')}-${fechaNac.month.toString().padLeft(2, '0')}-${fechaNac.day.toString().padLeft(2, '0')}",
        "direccion": direccion,
        "email": email,
        "telefonoFijo": telefonoFijo,
        "celular": celular,
        "perfil": perfil,
        "sexo": sexo,
        "rh": rh,
        "rutaFoto": rutaFoto,
        "idTipoIdentificacion": idTipoIdentificacion,
        "idCiudadNac": idCiudadNac,
        "idCiudadUbicacion": idCiudadUbicacion,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "rutaFotoUrl": rutaFotoUrl,
        "ciudad_ubicacion": ciudadUbicacion.toJson(),
        "ciudad_nac": ciudadNac.toJson(),
    };
}

class Ciudad {
    int id;
    String codigo;
    String descripcion;
    int idDepartamento;
    dynamic createdAt;
    dynamic updatedAt;

    Ciudad({
        required this.id,
        required this.codigo,
        required this.descripcion,
        required this.idDepartamento,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Ciudad.fromJson(Map<String, dynamic> json) => Ciudad(
        id: json["id"],
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        idDepartamento: json["idDepartamento"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "descripcion": descripcion,
        "idDepartamento": idDepartamento,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
