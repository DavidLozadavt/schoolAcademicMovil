// // To parse this JSON data, do
// //
// //     final publicacion = publicacionFromJson(jsonString);

// import 'dart:convert';

// List<Publicacion> publicacionFromJson(String str) => List<Publicacion>.from(
//     json.decode(str).map((x) => Publicacion.fromJson(x)));

// String publicacionToJson(List<Publicacion> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Publicacion {
//   final int id;
//   final String description;
//   final String urlImage;
//   final DateTime fechaPublicacion;
//   final int idUser;
//   final dynamic idEvento;
//   final int idCompany;
//   final dynamic idGrupoGeneral;
//   final String tipoPublicacion;
//   final dynamic idPropiedadPublicacion;
//   final dynamic deletedAt;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final dynamic evento;
//   final User user;
//   final List<Imagene>? imagenes;

//   Publicacion({
//     required this.id,
//     required this.description,
//     required this.urlImage,
//     required this.fechaPublicacion,
//     required this.idUser,
//     required this.idEvento,
//     required this.idCompany,
//     required this.idGrupoGeneral,
//     required this.tipoPublicacion,
//     required this.idPropiedadPublicacion,
//     required this.deletedAt,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.evento,
//     required this.user,
//     this.imagenes,
//   });

//   factory Publicacion.fromJson(Map<String, dynamic> json) => Publicacion(
//         id: json["id"],
//         description: json["description"],
//         urlImage: json["urlImage"],
//         fechaPublicacion: DateTime.parse(json["fechaPublicacion"]),
//         idUser: json["idUser"],
//         idEvento: json["idEvento"],
//         idCompany: json["idCompany"],
//         idGrupoGeneral: json["idGrupoGeneral"],
//         tipoPublicacion: json["tipoPublicacion"],
//         idPropiedadPublicacion: json["idPropiedadPublicacion"],
//         deletedAt: json["deleted_at"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         evento: json["evento"],
//         user: User.fromJson(json["user"]),
//         imagenes: json["imagenes"] != null // Verificar si 'imagenes' no es nulo
//             ? List<Imagene>.from(
//                 json["imagenes"].map((x) => Imagene.fromJson(x)))
//             : null, // Asignar nulo si 'imagenes' es nulo
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "description": description,
//         "urlImage": urlImage,
//         "fechaPublicacion": fechaPublicacion.toIso8601String(),
//         "idUser": idUser,
//         "idEvento": idEvento,
//         "idCompany": idCompany,
//         "idGrupoGeneral": idGrupoGeneral,
//         "tipoPublicacion": tipoPublicacion,
//         "idPropiedadPublicacion": idPropiedadPublicacion,
//         "deleted_at": deletedAt,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "evento": evento,
//         "user": user.toJson(),
//         "imagenes": imagenes != null
//             ? List<dynamic>.from(imagenes!.map((x) => x.toJson()))
//             : null,
//       };
// }

// class Imagene {
//   final int id;
//   final int idPublicacion;
//   final String urlImage;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   Imagene({
//     required this.id,
//     required this.idPublicacion,
//     required this.urlImage,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Imagene.fromJson(Map<String, dynamic> json) => Imagene(
//         id: json["id"],
//         idPublicacion: json["idPublicacion"],
//         urlImage: json["urlImage"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "idPublicacion": idPublicacion,
//         "urlImage": urlImage,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }

// class User {
//   final int id;
//   final String email;
//   final int idPersona;
//   final dynamic deviceToken;
//   final dynamic emailVerifiedAt;
//   final String estadoMensajeria;
//   final Persona persona;

//   User({
//     required this.id,
//     required this.email,
//     required this.idPersona,
//     required this.deviceToken,
//     required this.emailVerifiedAt,
//     required this.estadoMensajeria,
//     required this.persona,
//   });

//   factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["id"],
//         email: json["email"],
//         idPersona: json["idPersona"],
//         deviceToken: json["device_token"],
//         emailVerifiedAt: json["email_verified_at"],
//         estadoMensajeria: json["estadoMensajeria"],
//         persona: Persona.fromJson(json["persona"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "email": email,
//         "idPersona": idPersona,
//         "device_token": deviceToken,
//         "email_verified_at": emailVerifiedAt,
//         "estadoMensajeria": estadoMensajeria,
//         "persona": persona.toJson(),
//       };
// }

// class Persona {
//   final int? id;
//   final String? identificacion;
//   final String? nombre1;
//   final String? nombre2;
//   final String? apellido1;
//   final String? apellido2;
//   final DateTime? fechaNac;
//   final String? direccion;
//   final String? email;
//   final String? telefonoFijo;
//   final String? celular;
//   final dynamic perfil;
//   final String? sexo;
//   final String? rh;
//   final String? rutaFoto;
//   final int? idTipoIdentificacion;
//   final int? idCiudadNac;
//   final int? idCiudadUbicacion;
//   final String? tipoPersona;
//   final dynamic createdAt;
//   final DateTime? updatedAt;

//   Persona({
//     this.id,
//     this.identificacion,
//     this.nombre1,
//     this.nombre2,
//     this.apellido1,
//     this.apellido2,
//     this.fechaNac,
//     this.direccion,
//     this.email,
//     this.telefonoFijo,
//     this.celular,
//     this.perfil,
//     this.sexo,
//     this.rh,
//     this.rutaFoto,
//     this.idTipoIdentificacion,
//     this.idCiudadNac,
//     this.idCiudadUbicacion,
//     this.tipoPersona,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory Persona.fromJson(Map<String, dynamic> json) => Persona(
//         id: json["id"],
//         identificacion: json["identificacion"],
//         nombre1: json["nombre1"],
//         nombre2: json["nombre2"],
//         apellido1: json["apellido1"],
//         apellido2: json["apellido2"],
//         fechaNac:
//             json["fechaNac"] != null ? DateTime.parse(json["fechaNac"]) : null,
//         direccion: json["direccion"],
//         email: json["email"],
//         telefonoFijo: json["telefonoFijo"],
//         celular: json["celular"],
//         perfil: json["perfil"],
//         sexo: json["sexo"],
//         rh: json["rh"],
//         rutaFoto: json["rutaFoto"],
//         idTipoIdentificacion: json["idTipoIdentificacion"],
//         idCiudadNac: json["idCiudadNac"],
//         idCiudadUbicacion: json["idCiudadUbicacion"],
//         tipoPersona: json["tipoPersona"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"] != null
//             ? DateTime.parse(json["updated_at"])
//             : null,
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "identificacion": identificacion,
//         "nombre1": nombre1,
//         "nombre2": nombre2,
//         "apellido1": apellido1,
//         "apellido2": apellido2,
//         "fechaNac": fechaNac != null
//             ? "${fechaNac?.year.toString().padLeft(4, '0')}-${fechaNac?.month.toString().padLeft(2, '0')}-${fechaNac?.day.toString().padLeft(2, '0')}"
//             : null,
//         "direccion": direccion,
//         "email": email,
//         "telefonoFijo": telefonoFijo,
//         "celular": celular,
//         "perfil": perfil,
//         "sexo": sexo,
//         "rh": rh,
//         "rutaFoto": rutaFoto,
//         "idTipoIdentificacion": idTipoIdentificacion,
//         "idCiudadNac": idCiudadNac,
//         "idCiudadUbicacion": idCiudadUbicacion,
//         "tipoPersona": tipoPersona,
//         "created_at": createdAt,
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }


import 'dart:convert';

List<Publicacion> publicacionFromJson(String str) => List<Publicacion>.from(
    json.decode(str).map((x) => Publicacion.fromJson(x)));

String publicacionToJson(List<Publicacion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Publicacion {
  final dynamic id;
  final dynamic description;
  final dynamic urlImage;
  final dynamic fechaPublicacion;
  final dynamic idUser;
  final dynamic idEvento;
  final dynamic idCompany;
  final dynamic idGrupoGeneral;
  final dynamic tipoPublicacion;
  final dynamic idPropiedadPublicacion;
  final dynamic deletedAt;
  final dynamic createdAt;
  final dynamic updatedAt;
  final dynamic evento;
  final dynamic user;
  final dynamic imagenes;

  Publicacion({
    this.id,
    this.description,
    this.urlImage,
    this.fechaPublicacion,
    this.idUser,
    this.idEvento,
    this.idCompany,
    this.idGrupoGeneral,
    this.tipoPublicacion,
    this.idPropiedadPublicacion,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.evento,
    this.user,
    this.imagenes,
  });

  factory Publicacion.fromJson(Map<String, dynamic> json) => Publicacion(
        id: json["id"],
        description: json["description"],
        urlImage: json["urlImage"],
        fechaPublicacion: json["fechaPublicacion"] != null
            ? DateTime.parse(json["fechaPublicacion"])
            : null,
        idUser: json["idUser"],
        idEvento: json["idEvento"],
        idCompany: json["idCompany"],
        idGrupoGeneral: json["idGrupoGeneral"],
        tipoPublicacion: json["tipoPublicacion"],
        idPropiedadPublicacion: json["idPropiedadPublicacion"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        evento: json["evento"],
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
        imagenes: json["imagenes"] != null
            ? List<Imagene>.from(
                json["imagenes"].map((x) => Imagene.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "urlImage": urlImage,
        "fechaPublicacion": fechaPublicacion?.toIso8601String(),
        "idUser": idUser,
        "idEvento": idEvento,
        "idCompany": idCompany,
        "idGrupoGeneral": idGrupoGeneral,
        "tipoPublicacion": tipoPublicacion,
        "idPropiedadPublicacion": idPropiedadPublicacion,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "evento": evento,
        "user": user?.toJson(),
        "imagenes": imagenes != null
            ? List<dynamic>.from(imagenes!.map((x) => x.toJson()))
            : null,
      };
}

class Imagene {
  final dynamic id;
  final dynamic idPublicacion;
  final dynamic urlImage;
  final dynamic createdAt;
  final dynamic updatedAt;

  Imagene({
    this.id,
    this.idPublicacion,
    this.urlImage,
    this.createdAt,
    this.updatedAt,
  });

  factory Imagene.fromJson(Map<String, dynamic> json) => Imagene(
        id: json["id"],
        idPublicacion: json["idPublicacion"],
        urlImage: json["urlImage"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idPublicacion": idPublicacion,
        "urlImage": urlImage,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class User {
  final dynamic id;
  final dynamic email;
  final dynamic idPersona;
  final dynamic deviceToken;
  final dynamic emailVerifiedAt;
  final dynamic estadoMensajeria;
  final dynamic persona;

  User({
    this.id,
    this.email,
    this.idPersona,
    this.deviceToken,
    this.emailVerifiedAt,
    this.estadoMensajeria,
    this.persona,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        idPersona: json["idPersona"],
        deviceToken: json["device_token"],
        emailVerifiedAt: json["email_verified_at"],
        estadoMensajeria: json["estadoMensajeria"],
        persona:
            json["persona"] != null ? Persona.fromJson(json["persona"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "idPersona": idPersona,
        "device_token": deviceToken,
        "email_verified_at": emailVerifiedAt,
        "estadoMensajeria": estadoMensajeria,
        "persona": persona?.toJson(),
      };
}

class Persona {
  final dynamic id;
  final dynamic identificacion;
  final dynamic nombre1;
  final dynamic nombre2;
  final dynamic apellido1;
  final dynamic apellido2;
  final dynamic fechaNac;
  final dynamic direccion;
  final dynamic email;
  final dynamic telefonoFijo;
  final dynamic celular;
  final dynamic perfil;
  final dynamic sexo;
  final dynamic rh;
  final dynamic rutaFoto;
  final dynamic idTipoIdentificacion;
  final dynamic idCiudadNac;
  final dynamic idCiudadUbicacion;
  final dynamic tipoPersona;
  final dynamic createdAt;
  final dynamic updatedAt;

  Persona({
    this.id,
    this.identificacion,
    this.nombre1,
    this.nombre2,
    this.apellido1,
    this.apellido2,
    this.fechaNac,
    this.direccion,
    this.email,
    this.telefonoFijo,
    this.celular,
    this.perfil,
    this.sexo,
    this.rh,
    this.rutaFoto,
    this.idTipoIdentificacion,
    this.idCiudadNac,
    this.idCiudadUbicacion,
    this.tipoPersona,
    this.createdAt,
    this.updatedAt,
  });

  factory Persona.fromJson(Map<String, dynamic> json) => Persona(
        id: json["id"],
        identificacion: json["identificacion"],
        nombre1: json["nombre1"],
        nombre2: json["nombre2"],
        apellido1: json["apellido1"],
        apellido2: json["apellido2"],
        fechaNac: json["fechaNac"] != null
            ? DateTime.parse(json["fechaNac"])
            : null,
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
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "identificacion": identificacion,
        "nombre1": nombre1,
        "nombre2": nombre2,
        "apellido1": apellido1,
        "apellido2": apellido2,
        "fechaNac": fechaNac?.toIso8601String(),
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
        "updated_at": updatedAt?.toIso8601String(),
      };
}
