// // To parse this JSON data, do
// //
// //     final assignedActivities = assignedActivitiesFromJson(jsonString);

// import 'dart:convert';

// List<AssignedActivities> assignedActivitiesFromJson(String str) =>
//     List<AssignedActivities>.from(
//         json.decode(str).map((x) => AssignedActivities.fromJson(x)));

// String assignedActivitiesToJson(List<AssignedActivities> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class AssignedActivities {
//   int? id;
//   dynamic archivo;
//   DateTime? fechaCreacion;
//   DateTime? fechaInicial;
//   DateTime? fechaFinal;
//   dynamic calificacionNumerica;
//   dynamic calificacionEstandart;
//   dynamic comentarioDocente;
//   dynamic comentarioEstudiante;
//   int idActividad;
//   int? idAMartriculaAcademica;
//   int? idEstado;
//   dynamic idGrupo;
//   int? idPersona;
//   int? idCorte;
//   dynamic fechaCalificacion;
//   dynamic createdAt;
//   dynamic updatedAt;
//   int? notificacionEnviada;
//   bool esGrupal;
//   final Grupo? grupo;
//   String? docRespuesta;
//   Actividades? actividad;

//   AssignedActivities({
//     this.id,
//     this.archivo,
//     this.fechaCreacion,
//     this.fechaInicial,
//     this.fechaFinal,
//     this.calificacionNumerica,
//     this.calificacionEstandart,
//     this.comentarioDocente,
//     this.comentarioEstudiante,
//     required this.idActividad,
//     this.idAMartriculaAcademica,
//     this.idEstado,
//     this.idGrupo,
//     this.idPersona,
//     this.idCorte,
//     this.fechaCalificacion,
//     this.createdAt,
//     this.updatedAt,
//     this.notificacionEnviada,
//     required this.esGrupal,
//     this.grupo,
//     this.docRespuesta,
//     this.actividad,
//   });

//   factory AssignedActivities.fromJson(Map<String, dynamic> json) =>
//       AssignedActivities(
//         id: json["id"],
//         archivo: json["archivo"],
//         fechaCreacion: json["fechaCreacion"] != null
//             ? DateTime.parse(json["fechaCreacion"])
//             : null,
//         fechaInicial: json["fechaInicial"] != null
//             ? DateTime.parse(json["fechaInicial"])
//             : null,
//         fechaFinal: json["fechaFinal"] != null
//             ? DateTime.parse(json["fechaFinal"])
//             : null,
//         calificacionNumerica: json["calificacionNumerica"],
//         calificacionEstandart: json["calificacionEstandart"],
//         comentarioDocente: json["ComentarioDocente"],
//         comentarioEstudiante: json["ComentarioEstudiante"],
//         idActividad: json["idActividad"],
//         idAMartriculaAcademica: json["idAMartriculaAcademica"],
//         idEstado: json["idEstado"],
//         idGrupo: json["idGrupo"],
//         idPersona: json["idPersona"],
//         idCorte: json["idCorte"],
//         fechaCalificacion: json["fechaCalificacion"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//         notificacionEnviada: json["notificacionEnviada"],
//         esGrupal: json["esGrupal"],
//         grupo: json["grupo"] != null ? Grupo.fromJson(json["grupo"]) : null,
//         docRespuesta: json["DocRespuesta"],
//         actividad: json["actividad"] != null
//             ? Actividades.fromJson(json["actividad"])
//             : null,
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "archivo": archivo,
//         "fechaCreacion": fechaCreacion?.toIso8601String(),
//         "fechaInicial": fechaInicial?.toIso8601String(),
//         "fechaFinal": fechaFinal?.toIso8601String(),
//         "calificacionNumerica": calificacionNumerica,
//         "calificacionEstandart": calificacionEstandart,
//         "ComentarioDocente": comentarioDocente,
//         "ComentarioEstudiante": comentarioEstudiante,
//         "idActividad": idActividad,
//         "idAMartriculaAcademica": idAMartriculaAcademica,
//         "idEstado": idEstado,
//         "idGrupo": idGrupo,
//         "idPersona": idPersona,
//         "idCorte": idCorte,
//         "fechaCalificacion": fechaCalificacion,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//         "notificacionEnviada": notificacionEnviada,
//         "esGrupal": esGrupal,
//         "grupo": grupo?.toJson(),
//         "DocRespuesta": docRespuesta,
//         "actividad": actividad?.toJson(),
//       };
// }

// class Actividades {
//   int? id;
//   String? tituloActividad;
//   String? descripcionActividad;
//   String? pathDocumentoActividad;
//   String? autor;
//   int? idTipoActividad;
//   int? idMateria;
//   int? idEstado;
//   int? idCompany;
//   int? idPersona;
//   String? docUrl;
//   Materia? materia;
//   TipoActividad? tipoActividad;
//   Estado? estado;

//   Actividades({
//     this.id,
//     this.tituloActividad,
//     this.descripcionActividad,
//     this.pathDocumentoActividad,
//     this.autor,
//     this.idTipoActividad,
//     this.idMateria,
//     this.idEstado,
//     this.idCompany,
//     this.idPersona,
//     this.docUrl,
//     this.materia,
//     this.tipoActividad,
//     this.estado,
//   });

//   factory Actividades.fromJson(Map<String, dynamic> json) => Actividades(
//         id: json["id"],
//         tituloActividad: json["tituloActividad"],
//         descripcionActividad: json["descripcionActividad"],
//         pathDocumentoActividad: json["pathDocumentoActividad"],
//         autor: json["autor"],
//         idTipoActividad: json["idTipoActividad"],
//         idMateria: json["idMateria"],
//         idEstado: json["idEstado"],
//         idCompany: json["idCompany"],
//         idPersona: json["idPersona"],
//         docUrl: json["DocUrl"],
//         materia:
//             json["materia"] != null ? Materia.fromJson(json["materia"]) : null,
//         tipoActividad: json["tipoActividad"] != null
//             ? TipoActividad.fromJson(json["tipoActividad"])
//             : null,
//         estado: json["estado"] != null ? Estado.fromJson(json["estado"]) : null,
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "tituloActividad": tituloActividad,
//         "descripcionActividad": descripcionActividad,
//         "pathDocumentoActividad": pathDocumentoActividad,
//         "autor": autor,
//         "idTipoActividad": idTipoActividad,
//         "idMateria": idMateria,
//         "idEstado": idEstado,
//         "idCompany": idCompany,
//         "idPersona": idPersona,
//         "DocUrl": docUrl,
//         "materia": materia?.toJson(),
//         "tipoActividad": tipoActividad?.toJson(),
//         "estado": estado?.toJson(),
//       };
// }

// class Estado {
//   int? id;
//   String? estado;
//   String? descripcion;

//   Estado({
//     this.id,
//     this.estado,
//     this.descripcion,
//   });

//   factory Estado.fromJson(Map<String, dynamic> json) => Estado(
//         id: json["id"],
//         estado: json["estado"],
//         descripcion: json["descripcion"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "estado": estado,
//         "descripcion": descripcion,
//       };
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
//         createdAt: json["created_at"] != null
//             ? DateTime.parse(json["created_at"])
//             : null,
//         updatedAt: json["updated_at"] != null
//             ? DateTime.parse(json["updated_at"])
//             : null,
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

// class TipoActividad {
//   int? id;
//   String? tipoActividad;
//   String? descripcion;
//   int? idCompany;

//   TipoActividad({
//     this.id,
//     this.tipoActividad,
//     this.descripcion,
//     this.idCompany,
//   });

//   factory TipoActividad.fromJson(Map<String, dynamic> json) => TipoActividad(
//         id: json["id"],
//         tipoActividad: json["tipoActividad"],
//         descripcion: json["descripcion"],
//         idCompany: json["idCompany"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "tipoActividad": tipoActividad,
//         "descripcion": descripcion,
//         "idCompany": idCompany,
//       };
// }

// class Grupo {
//   int? id;
//   String? nombre;
//   String? descripcion;
//   int? idCompany;
//   int? idPersona;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   dynamic esGrupoDirector;

//   Grupo({
//     this.id,
//     this.nombre,
//     this.descripcion,
//     this.idCompany,
//     this.idPersona,
//     this.createdAt,
//     this.updatedAt,
//     this.esGrupoDirector,
//   });

//   factory Grupo.fromJson(Map<String, dynamic> json) => Grupo(
//         id: json["id"],
//         nombre: json["nombre"],
//         descripcion: json["descripcion"],
//         idCompany: json["idCompany"],
//         idPersona: json["idPersona"],
//         createdAt: json["created_at"] != null
//             ? DateTime.parse(json["created_at"])
//             : null,
//         updatedAt: json["updated_at"] != null
//             ? DateTime.parse(json["updated_at"])
//             : null,
//         esGrupoDirector: json["esGrupoDirector"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "nombre": nombre,
//         "descripcion": descripcion,
//         "idCompany": idCompany,
//         "idPersona": idPersona,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "esGrupoDirector": esGrupoDirector,
//       };
// }





// To parse this JSON data, do
//
//     final assignedActivities = assignedActivitiesFromJson(jsonString);

import 'dart:convert';

List<AssignedActivities> assignedActivitiesFromJson(String str) => List<AssignedActivities>.from(json.decode(str).map((x) => AssignedActivities.fromJson(x)));

String assignedActivitiesToJson(List<AssignedActivities> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AssignedActivities {
    final int id;
    final String? archivo;
    final DateTime fechaCreacion;
    final DateTime fechaInicial;
    final DateTime fechaFinal;
    final String? calificacionNumerica;
    final String? calificacionEstandart;
    final String? comentarioDocente;
    final String? comentarioEstudiante;
    final dynamic  idActividad;
    final String idAMartriculaAcademica;
    final String idEstado;
    final dynamic idGrupo;
    final String idPersona;
    final String idCorte;
    final DateTime? fechaCalificacion;
    final dynamic createdAt;
    final dynamic updatedAt;
    final String notificacionEnviada;
    final bool esGrupal;
    final dynamic grupo;
    final String docRespuesta;
    final Actividad actividad;

    AssignedActivities({
        required this.id,
        required this.archivo,
        required this.fechaCreacion,
        required this.fechaInicial,
        required this.fechaFinal,
        required this.calificacionNumerica,
        required this.calificacionEstandart,
        required this.comentarioDocente,
        required this.comentarioEstudiante,
        required this.idActividad,
        required this.idAMartriculaAcademica,
        required this.idEstado,
        required this.idGrupo,
        required this.idPersona,
        required this.idCorte,
        required this.fechaCalificacion,
        required this.createdAt,
        required this.updatedAt,
        required this.notificacionEnviada,
        required this.esGrupal,
        required this.grupo,
        required this.docRespuesta,
        required this.actividad,
    });

    factory AssignedActivities.fromJson(Map<String, dynamic> json) => AssignedActivities(
        id: json["id"],
        archivo: json["archivo"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        fechaInicial: DateTime.parse(json["fechaInicial"]),
        fechaFinal: DateTime.parse(json["fechaFinal"]),
        calificacionNumerica: json["calificacionNumerica"],
        calificacionEstandart: json["calificacionEstandart"],
        comentarioDocente: json["ComentarioDocente"],
        comentarioEstudiante: json["ComentarioEstudiante"],
        idActividad: json["idActividad"],
        idAMartriculaAcademica: json["idAMartriculaAcademica"],
        idEstado: json["idEstado"],
        idGrupo: json["idGrupo"],
        idPersona: json["idPersona"],
        idCorte: json["idCorte"],
        fechaCalificacion: json["fechaCalificacion"] == null ? null : DateTime.parse(json["fechaCalificacion"]),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        notificacionEnviada: json["notificacionEnviada"],
        esGrupal: json["esGrupal"],
        grupo: json["grupo"],
        docRespuesta: json["DocRespuesta"],
        actividad: Actividad.fromJson(json["actividad"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "archivo": archivo,
        "fechaCreacion": "${fechaCreacion.year.toString().padLeft(4, '0')}-${fechaCreacion.month.toString().padLeft(2, '0')}-${fechaCreacion.day.toString().padLeft(2, '0')}",
        "fechaInicial": fechaInicial.toIso8601String(),
        "fechaFinal": fechaFinal.toIso8601String(),
        "calificacionNumerica": calificacionNumerica,
        "calificacionEstandart": calificacionEstandart,
        "ComentarioDocente": comentarioDocente,
        "ComentarioEstudiante": comentarioEstudiante,
        "idActividad": idActividad,
        "idAMartriculaAcademica": idAMartriculaAcademica,
        "idEstado": idEstado,
        "idGrupo": idGrupo,
        "idPersona": idPersona,
        "idCorte": idCorte,
        "fechaCalificacion": fechaCalificacion?.toIso8601String(),
        "created_at": createdAt,
        "updated_at": updatedAt,
        "notificacionEnviada": notificacionEnviada,
        "esGrupal": esGrupal,
        "grupo": grupo,
        "DocRespuesta": docRespuesta,
        "actividad": actividad.toJson(),
    };
}

class Actividad {
    final int id;
    final String tituloActividad;
    final String descripcionActividad;
    final String? pathDocumentoActividad;
    final String autor;
    final String idTipoActividad;
    final String idMateria;
    final String idEstado;
    final String idCompany;
    final String idPersona;
    final String docUrl;
    final Materia materia;
    final TipoActividad tipoActividad;
    final Estado estado;

    Actividad({
        required this.id,
        required this.tituloActividad,
        required this.descripcionActividad,
        required this.pathDocumentoActividad,
        required this.autor,
        required this.idTipoActividad,
        required this.idMateria,
        required this.idEstado,
        required this.idCompany,
        required this.idPersona,
        required this.docUrl,
        required this.materia,
        required this.tipoActividad,
        required this.estado,
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
        idPersona: json["idPersona"],
        docUrl: json["DocUrl"],
        materia: Materia.fromJson(json["materia"]),
        tipoActividad: TipoActividad.fromJson(json["tipoActividad"]),
        estado: Estado.fromJson(json["estado"]),
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
        "idPersona": idPersona,
        "DocUrl": docUrl,
        "materia": materia.toJson(),
        "tipoActividad": tipoActividad.toJson(),
        "estado": estado.toJson(),
    };
}

class Estado {
    final int id;
    final String estado;
    final String descripcion;

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
    final int id;
    final String nombreMateria;
    final dynamic descripcion;
    final String idCompany;
    final DateTime createdAt;
    final DateTime updatedAt;
    final String idAreaConocimiento;
    final dynamic idMateriaPadre;

    Materia({
        required this.id,
        required this.nombreMateria,
        required this.descripcion,
        required this.idCompany,
        required this.createdAt,
        required this.updatedAt,
        required this.idAreaConocimiento,
        required this.idMateriaPadre,
    });

    factory Materia.fromJson(Map<String, dynamic> json) => Materia(
        id: json["id"],
        nombreMateria: json["nombreMateria"],
        descripcion: json["descripcion"],
        idCompany: json["idCompany"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        idAreaConocimiento: json["idAreaConocimiento"],
        idMateriaPadre: json["idMateriaPadre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombreMateria": nombreMateria,
        "descripcion": descripcion,
        "idCompany": idCompany,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "idAreaConocimiento": idAreaConocimiento,
        "idMateriaPadre": idMateriaPadre,
    };
}

class TipoActividad {
    final int id;
    final String tipoActividad;
    final String descripcion;
    final String idCompany;

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
