// To parse this JSON data, do
//
//     final publicacion = publicacionFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Publicacion> publicacionFromJson(String str) => List<Publicacion>.from(json.decode(str).map((x) => Publicacion.fromJson(x)));

String publicacionToJson(List<Publicacion> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Publicacion {
    final int id;
    final String description;
    final String urlImage;
    final DateTime fechaPublicacion;
    final int idUser;
    final dynamic idEvento;
    final int idCompany;
    final dynamic idGrupoGeneral;
    final String tipoPublicacion;
    final dynamic idPropiedadPublicacion;
    final dynamic deletedAt;
    final DateTime createdAt;
    final DateTime updatedAt;
    final dynamic evento;
    final User user;

    Publicacion({
        required this.id,
        required this.description,
        required this.urlImage,
        required this.fechaPublicacion,
        required this.idUser,
        required this.idEvento,
        required this.idCompany,
        required this.idGrupoGeneral,
        required this.tipoPublicacion,
        required this.idPropiedadPublicacion,
        required this.deletedAt,
        required this.createdAt,
        required this.updatedAt,
        required this.evento,
        required this.user,
    });

    factory Publicacion.fromJson(Map<String, dynamic> json) => Publicacion(
        id: json["id"],
        description: json["description"],
        urlImage: json["urlImage"],
        fechaPublicacion: DateTime.parse(json["fechaPublicacion"]),
        idUser: json["idUser"],
        idEvento: json["idEvento"],
        idCompany: json["idCompany"],
        idGrupoGeneral: json["idGrupoGeneral"],
        tipoPublicacion: json["tipoPublicacion"],
        idPropiedadPublicacion: json["idPropiedadPublicacion"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        evento: json["evento"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "urlImage": urlImage,
        "fechaPublicacion": fechaPublicacion.toIso8601String(),
        "idUser": idUser,
        "idEvento": idEvento,
        "idCompany": idCompany,
        "idGrupoGeneral": idGrupoGeneral,
        "tipoPublicacion": tipoPublicacion,
        "idPropiedadPublicacion": idPropiedadPublicacion,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "evento": evento,
        "user": user.toJson(),
    };
}

class User {
    final int id;
    final String email;
    final int idPersona;
    final dynamic deviceToken;
    final dynamic emailVerifiedAt;
    final String estadoMensajeria;
    final Persona persona;

    User({
        required this.id,
        required this.email,
        required this.idPersona,
        required this.deviceToken,
        required this.emailVerifiedAt,
        required this.estadoMensajeria,
        required this.persona,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        idPersona: json["idPersona"],
        deviceToken: json["device_token"],
        emailVerifiedAt: json["email_verified_at"],
        estadoMensajeria: json["estadoMensajeria"],
        persona: Persona.fromJson(json["persona"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "idPersona": idPersona,
        "device_token": deviceToken,
        "email_verified_at": emailVerifiedAt,
        "estadoMensajeria": estadoMensajeria,
        "persona": persona.toJson(),
    };
}

class Persona {
    final int id;
    final String identificacion;
    final String nombre1;
    final String nombre2;
    final String apellido1;
    final String apellido2;
    final DateTime fechaNac;
    final String direccion;
    final String email;
    final String telefonoFijo;
    final String celular;
    final dynamic perfil;
    final String sexo;
    final String rh;
    final String rutaFoto;
    final int idTipoIdentificacion;
    final int idCiudadNac;
    final int idCiudadUbicacion;
    final String tipoPersona;
    final dynamic createdAt;
    final DateTime updatedAt;

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
        required this.tipoPersona,
        required this.createdAt,
        required this.updatedAt,
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
        tipoPersona: json["tipoPersona"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
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
        "tipoPersona": tipoPersona,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
    };
}
