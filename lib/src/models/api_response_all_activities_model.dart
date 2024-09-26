// import 'dart:convert';

// List<Actividad> actividadFromJson(String str) => List<Actividad>.from(json.decode(str).map((x) => Actividad.fromJson(x)));

// String actividadToJson(List<Actividad> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Actividad {
//     int id;
//     String tituloActividad;
//     String descripcionActividad;
//     String? pathDocumentoActividad;
//     dynamic autor;
//     int idTipoActividad;
//     int idMateria;
//     int idEstado;
//     int idCompany;
//     String? docUrl;
//     TipoActividad tipoActividad;
//     Materia materia;
//     Estado estado;
//     List<dynamic> preguntas;
//     final Persona persona;


//     Actividad({
//         required this.id,
//         required this.tituloActividad,
//         required this.descripcionActividad,
//          this.pathDocumentoActividad,
//         required this.autor,
//         required this.idTipoActividad,
//         required this.idMateria,
//         required this.idEstado,
//         required this.idCompany,
//          this.docUrl,
//         required this.tipoActividad,
//         required this.materia,
//         required this.estado,
//         required this.preguntas,
//         required this.persona,
//     });

//     factory Actividad.fromJson(Map<String, dynamic> json) => Actividad(
//         id: json["id"],
//         tituloActividad: json["tituloActividad"],
//         descripcionActividad: json["descripcionActividad"],
//         pathDocumentoActividad: json["pathDocumentoActividad"],
//         autor: json["autor"],
//         idTipoActividad: json["idTipoActividad"],
//         idMateria: json["idMateria"],
//         idEstado: json["idEstado"],
//         idCompany: json["idCompany"],
//         docUrl: json["DocUrl"],
//         tipoActividad: TipoActividad.fromJson(json["tipoActividad"]),
//         materia: Materia.fromJson(json["materia"]),
//         estado: Estado.fromJson(json["estado"]),
//         preguntas: List<dynamic>.from(json["preguntas"].map((x) => x)),
//          persona: Persona.fromJson(json["persona"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "tituloActividad": tituloActividad,
//         "descripcionActividad": descripcionActividad,
//         "pathDocumentoActividad": pathDocumentoActividad,
//         "autor": autor,
//         "idTipoActividad": idTipoActividad,
//         "idMateria": idMateria,
//         "idEstado": idEstado,
//         "idCompany": idCompany,
//         "DocUrl": docUrl,
//         "tipoActividad": tipoActividad.toJson(),
//         "materia": materia.toJson(),
//         "estado": estado.toJson(),
//         "preguntas": List<dynamic>.from(preguntas.map((x) => x)),
//         "persona": persona.toJson(),

//     };
// }

// class Estado {
//     int id;
//     String estado;
//     String descripcion;

//     Estado({
//         required this.id,
//         required this.estado,
//         required this.descripcion,
//     });

//     factory Estado.fromJson(Map<String, dynamic> json) => Estado(
//         id: json["id"],
//         estado: json["estado"],
//         descripcion: json["descripcion"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "estado": estado,
//         "descripcion": descripcion,
//     };
// }

// class Materia {
//   int? id;
//   String? nombreMateria;
//   String? descripcion;
//   int? idCompany;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? idAreaConocimiento;

//   Materia({
//     this.id,
//     this.nombreMateria,
//     this.descripcion,
//     this.idCompany,
//     this.createdAt,
//     this.updatedAt,
//     this.idAreaConocimiento,
//   });

//   factory Materia.fromJson(Map<String, dynamic> json) => Materia(
//         id: json["id"],
//         nombreMateria: json["nombreMateria"],
//         descripcion: json["descripcion"],
//         idCompany: json["idCompany"],
//         createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
//         updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
//         idAreaConocimiento: json["idAreaConocimiento"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "nombreMateria": nombreMateria,
//         "descripcion": descripcion,
//         "idCompany": idCompany,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "idAreaConocimiento": idAreaConocimiento,
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
//         fechaNac: json["fechaNac"] != null
//             ? DateTime.parse(json["fechaNac"])
//             : null,
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
//             ? "${fechaNac!.year.toString().padLeft(4, '0')}-${fechaNac!.month.toString().padLeft(2, '0')}-${fechaNac!.day.toString().padLeft(2, '0')}"
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

// class TipoActividad {
//     int id;
//     String tipoActividad;
//     String descripcion;
//     int idCompany;

//     TipoActividad({
//         required this.id,
//         required this.tipoActividad,
//         required this.descripcion,
//         required this.idCompany,
//     });

//     factory TipoActividad.fromJson(Map<String, dynamic> json) => TipoActividad(
//         id: json["id"],
//         tipoActividad: json["tipoActividad"],
//         descripcion: json["descripcion"],
//         idCompany: json["idCompany"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "tipoActividad": tipoActividad,
//         "descripcion": descripcion,
//         "idCompany": idCompany,
//     };
// }


import 'dart:convert';

List<Actividad> actividadFromJson(String str) => List<Actividad>.from(json.decode(str).map((x) => Actividad.fromJson(x)));

String actividadToJson(List<Actividad> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Actividad {
  dynamic id;
  String tituloActividad;
  String descripcionActividad;
  String? pathDocumentoActividad;
  dynamic autor;
  dynamic idTipoActividad;
  dynamic idMateria;
  dynamic idEstado;
  dynamic idCompany;
  String? docUrl;
  TipoActividad tipoActividad;
  Materia materia;
  Estado estado;
  List<dynamic> preguntas;
  final Persona persona;

  Actividad({
    required this.id,
    required this.tituloActividad,
    required this.descripcionActividad,
    this.pathDocumentoActividad,
    required this.autor,
    required this.idTipoActividad,
    required this.idMateria,
    required this.idEstado,
    required this.idCompany,
    this.docUrl,
    required this.tipoActividad,
    required this.materia,
    required this.estado,
    required this.preguntas,
    required this.persona,
  });

  factory Actividad.fromJson(Map<String, dynamic> json) => Actividad(
        id: json["id"],
        tituloActividad: json["tituloActividad"],
        descripcionActividad: json["descripcionActividad"],
        pathDocumentoActividad: json["pathDocumentoActividad"],
        autor: json["autor"],
        idTipoActividad: json["idTipoActividad"],
        idMateria: json["idMateria"],
        idEstado: json["idEstado"],
        idCompany: json["idCompany"],
        docUrl: json["DocUrl"],
        tipoActividad: TipoActividad.fromJson(json["tipoActividad"]),
        materia: Materia.fromJson(json["materia"]),
        estado: Estado.fromJson(json["estado"]),
        preguntas: List<dynamic>.from(json["preguntas"].map((x) => x)),
        persona: Persona.fromJson(json["persona"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tituloActividad": tituloActividad,
        "descripcionActividad": descripcionActividad,
        "pathDocumentoActividad": pathDocumentoActividad,
        "autor": autor,
        "idTipoActividad": idTipoActividad,
        "idMateria": idMateria,
        "idEstado": idEstado,
        "idCompany": idCompany,
        "DocUrl": docUrl,
        "tipoActividad": tipoActividad.toJson(),
        "materia": materia.toJson(),
        "estado": estado.toJson(),
        "preguntas": List<dynamic>.from(preguntas.map((x) => x)),
        "persona": persona.toJson(),
      };
}


class Estado {
  dynamic id;
  String estado;
  String descripcion;

  Estado({
    required this.id,
    required this.estado,
    required this.descripcion,
  });

  factory Estado.fromJson(Map<String, dynamic> json) => Estado(
        id: json["id"],
        estado: json["estado"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "estado": estado,
        "descripcion": descripcion,
      };
}


class Materia {
  dynamic id;
  String? nombreMateria;
  String? descripcion;
  dynamic idCompany;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic idAreaConocimiento;

  Materia({
    this.id,
    this.nombreMateria,
    this.descripcion,
    this.idCompany,
    this.createdAt,
    this.updatedAt,
    this.idAreaConocimiento,
  });

  factory Materia.fromJson(Map<String, dynamic> json) => Materia(
        id: json["id"],
        nombreMateria: json["nombreMateria"],
        descripcion: json["descripcion"],
        idCompany: json["idCompany"],
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
        idAreaConocimiento: json["idAreaConocimiento"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombreMateria": nombreMateria,
        "descripcion": descripcion,
        "idCompany": idCompany,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "idAreaConocimiento": idAreaConocimiento,
      };
}

class Persona {
  final dynamic id;
  final String? identificacion;
  final String? nombre1;
  final String? nombre2;
  final String? apellido1;
  final String? apellido2;
  final DateTime? fechaNac;
  final String? direccion;
  final String? email;
  final String? telefonoFijo;
  final String? celular;
  final dynamic perfil;
  final String? sexo;
  final String? rh;
  final String? rutaFoto;
  final dynamic idTipoIdentificacion;
  final dynamic idCiudadNac;
  final dynamic idCiudadUbicacion;
  final String? tipoPersona;
  final dynamic createdAt;
  final DateTime? updatedAt;

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
        fechaNac: json["fechaNac"] != null ? DateTime.parse(json["fechaNac"]) : null,
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
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "identificacion": identificacion,
        "nombre1": nombre1,
        "nombre2": nombre2,
        "apellido1": apellido1,
        "apellido2": apellido2,
        "fechaNac": fechaNac != null
            ? "${fechaNac!.year.toString().padLeft(4, '0')}-${fechaNac!.month.toString().padLeft(2, '0')}-${fechaNac!.day.toString().padLeft(2, '0')}"
            : null,
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


class TipoActividad {
  dynamic id;
  String tipoActividad;
  String descripcion;
  dynamic idCompany;

  TipoActividad({
    required this.id,
    required this.tipoActividad,
    required this.descripcion,
    required this.idCompany,
  });

  factory TipoActividad.fromJson(Map<String, dynamic> json) => TipoActividad(
        id: json["id"],
        tipoActividad: json["tipoActividad"],
        descripcion: json["descripcion"],
        idCompany: json["idCompany"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipoActividad": tipoActividad,
        "descripcion": descripcion,
        "idCompany": idCompany,
      };
}


