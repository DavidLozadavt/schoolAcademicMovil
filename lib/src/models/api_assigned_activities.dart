// To parse this JSON data, do
//
//     final assignedActivities = assignedActivitiesFromJson(jsonString);

import 'dart:convert';

List<AssignedActivities> assignedActivitiesFromJson(String str) =>
    List<AssignedActivities>.from(
        json.decode(str).map((x) => AssignedActivities.fromJson(x)));

String assignedActivitiesToJson(List<AssignedActivities> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AssignedActivities {
  int? id;
  dynamic archivo;
  DateTime? fechaCreacion;
  DateTime? fechaInicial;
  DateTime? fechaFinal;
  dynamic calificacionNumerica;
  dynamic calificacionEstandart;
  dynamic comentarioDocente;
  dynamic comentarioEstudiante;
  int idActividad;
  int? idAMartriculaAcademica;
  int? idEstado;
  dynamic idGrupo;
  int? idPersona;
  int? idCorte;
  dynamic fechaCalificacion;
  dynamic createdAt;
  dynamic updatedAt;
  int? notificacionEnviada;
  bool esGrupal;
  final Grupo? grupo;
  String? docRespuesta;
  Actividades? actividad;

  AssignedActivities({
    this.id,
    this.archivo,
    this.fechaCreacion,
    this.fechaInicial,
    this.fechaFinal,
    this.calificacionNumerica,
    this.calificacionEstandart,
    this.comentarioDocente,
    this.comentarioEstudiante,
    required this.idActividad,
    this.idAMartriculaAcademica,
    this.idEstado,
    this.idGrupo,
    this.idPersona,
    this.idCorte,
    this.fechaCalificacion,
    this.createdAt,
    this.updatedAt,
    this.notificacionEnviada,
    required this.esGrupal,
    this.grupo,
    this.docRespuesta,
    this.actividad,
  });

  factory AssignedActivities.fromJson(Map<String, dynamic> json) =>
      AssignedActivities(
        id: json["id"],
        archivo: json["archivo"],
        fechaCreacion: json["fechaCreacion"] != null
            ? DateTime.parse(json["fechaCreacion"])
            : null,
        fechaInicial: json["fechaInicial"] != null
            ? DateTime.parse(json["fechaInicial"])
            : null,
        fechaFinal: json["fechaFinal"] != null
            ? DateTime.parse(json["fechaFinal"])
            : null,
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
        fechaCalificacion: json["fechaCalificacion"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        notificacionEnviada: json["notificacionEnviada"],
        esGrupal: json["esGrupal"],
        grupo: json["grupo"] != null ? Grupo.fromJson(json["grupo"]) : null,
        docRespuesta: json["DocRespuesta"],
        actividad: json["actividad"] != null
            ? Actividades.fromJson(json["actividad"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "archivo": archivo,
        "fechaCreacion": fechaCreacion?.toIso8601String(),
        "fechaInicial": fechaInicial?.toIso8601String(),
        "fechaFinal": fechaFinal?.toIso8601String(),
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
        "fechaCalificacion": fechaCalificacion,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "notificacionEnviada": notificacionEnviada,
        "esGrupal": esGrupal,
        "grupo": grupo?.toJson(),
        "DocRespuesta": docRespuesta,
        "actividad": actividad?.toJson(),
      };
}

class Actividades {
  int? id;
  String? tituloActividad;
  String? descripcionActividad;
  String? pathDocumentoActividad;
  String? autor;
  int? idTipoActividad;
  int? idMateria;
  int? idEstado;
  int? idCompany;
  int? idPersona;
  String? docUrl;
  Materia? materia;
  TipoActividad? tipoActividad;
  Estado? estado;

  Actividades({
    this.id,
    this.tituloActividad,
    this.descripcionActividad,
    this.pathDocumentoActividad,
    this.autor,
    this.idTipoActividad,
    this.idMateria,
    this.idEstado,
    this.idCompany,
    this.idPersona,
    this.docUrl,
    this.materia,
    this.tipoActividad,
    this.estado,
  });

  factory Actividades.fromJson(Map<String, dynamic> json) => Actividades(
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
        materia:
            json["materia"] != null ? Materia.fromJson(json["materia"]) : null,
        tipoActividad: json["tipoActividad"] != null
            ? TipoActividad.fromJson(json["tipoActividad"])
            : null,
        estado: json["estado"] != null ? Estado.fromJson(json["estado"]) : null,
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
        "materia": materia?.toJson(),
        "tipoActividad": tipoActividad?.toJson(),
        "estado": estado?.toJson(),
      };
}

class Estado {
  int? id;
  String? estado;
  String? descripcion;

  Estado({
    this.id,
    this.estado,
    this.descripcion,
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
  int? id;
  String? nombreMateria;
  String? descripcion;
  int? idCompany;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? idAreaConocimiento;

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
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
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

class TipoActividad {
  int? id;
  String? tipoActividad;
  String? descripcion;
  int? idCompany;

  TipoActividad({
    this.id,
    this.tipoActividad,
    this.descripcion,
    this.idCompany,
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

class Grupo {
  int? id;
  String? nombre;
  String? descripcion;
  int? idCompany;
  int? idPersona;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic esGrupoDirector;

  Grupo({
    this.id,
    this.nombre,
    this.descripcion,
    this.idCompany,
    this.idPersona,
    this.createdAt,
    this.updatedAt,
    this.esGrupoDirector,
  });

  factory Grupo.fromJson(Map<String, dynamic> json) => Grupo(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        idCompany: json["idCompany"],
        idPersona: json["idPersona"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        esGrupoDirector: json["esGrupoDirector"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "idCompany": idCompany,
        "idPersona": idPersona,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "esGrupoDirector": esGrupoDirector,
      };
}
