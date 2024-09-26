// import 'dart:convert';

// List<Registrationsactivity> registrationsactivityFromJson(String str) => List<Registrationsactivity>.from(json.decode(str).map((x) => Registrationsactivity.fromJson(x)));

// String registrationsactivityToJson(List<Registrationsactivity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Registrationsactivity {
//     int id;
//     String? archivo;
//     DateTime? fechaCreacion;
//     DateTime? fechaInicial;
//     DateTime? fechaFinal;
//     String? calificacionNumerica;
//     String? calificacionEstandart;
//     String? comentarioDocente;
//     String? comentarioEstudiante;
//     int idActividad;
//     int idAMartriculaAcademica;
//     int idEstado;
//     dynamic idGrupo;
//     int idPersona;
//     int idCorte;
//     DateTime? fechaCalificacion;
//     dynamic createdAt;
//     dynamic updatedAt;
//     int notificacionEnviada;
//     String? docRespuesta;
//     MatriculaAcademica? matriculaAcademica;
//     Estado? estado;

//     Registrationsactivity({
//         required this.id,
//         this.archivo,
//         this.fechaCreacion,
//         this.fechaInicial,
//         this.fechaFinal,
//         this.calificacionNumerica,
//         this.calificacionEstandart,
//         this.comentarioDocente,
//         this.comentarioEstudiante,
//         required this.idActividad,
//         required this.idAMartriculaAcademica,
//         required this.idEstado,
//         this.idGrupo,
//         required this.idPersona,
//         required this.idCorte,
//         this.fechaCalificacion,
//         this.createdAt,
//         this.updatedAt,
//         required this.notificacionEnviada,
//         this.docRespuesta,
//         this.matriculaAcademica,
//         this.estado,
//     });

//     factory Registrationsactivity.fromJson(Map<String, dynamic> json) => Registrationsactivity(
//         id: json["id"],
//         archivo: json["archivo"],
//         fechaCreacion: json["fechaCreacion"] != null ? DateTime.parse(json["fechaCreacion"]) : null,
//         fechaInicial: json["fechaInicial"] != null ? DateTime.parse(json["fechaInicial"]) : null,
//         fechaFinal: json["fechaFinal"] != null ? DateTime.parse(json["fechaFinal"]) : null,
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
//         fechaCalificacion: json["fechaCalificacion"] != null ? DateTime.parse(json["fechaCalificacion"]) : null,
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//         notificacionEnviada: json["notificacionEnviada"],
//         docRespuesta: json["DocRespuesta"],
//         matriculaAcademica: json["matriculaAcademica"] != null ? MatriculaAcademica.fromJson(json["matriculaAcademica"]) : null,
//         estado: json["estado"] != null ? Estado.fromJson(json["estado"]) : null,
//     );

//     Map<String, dynamic> toJson() => {
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
//         "fechaCalificacion": fechaCalificacion?.toIso8601String(),
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//         "notificacionEnviada": notificacionEnviada,
//         "DocRespuesta": docRespuesta,
//         "matriculaAcademica": matriculaAcademica?.toJson(),
//         "estado": estado?.toJson(),
//     };
// }

// class Estado {
//     int id;
//     String? estado;
//     String? descripcion;

//     Estado({
//         required this.id,
//         this.estado,
//         this.descripcion,
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

// class MatriculaAcademica {
//     int id;
//     int idAsignacionPeriodoProgramaJornada;
//     int idMateria;
//     int idMatricula;
//     String? estado;
//     dynamic createdAt;
//     dynamic updatedAt;
//     Matricula? matricula;

//     MatriculaAcademica({
//         required this.id,
//         required this.idAsignacionPeriodoProgramaJornada,
//         required this.idMateria,
//         required this.idMatricula,
//         this.estado,
//         this.createdAt,
//         this.updatedAt,
//         this.matricula,
//     });

//     factory MatriculaAcademica.fromJson(Map<String, dynamic> json) => MatriculaAcademica(
//         id: json["id"],
//         idAsignacionPeriodoProgramaJornada: json["idAsignacionPeriodoProgramaJornada"],
//         idMateria: json["idMateria"],
//         idMatricula: json["idMatricula"],
//         estado: json["estado"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//         matricula: json["matricula"] != null ? Matricula.fromJson(json["matricula"]) : null,
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "idAsignacionPeriodoProgramaJornada": idAsignacionPeriodoProgramaJornada,
//         "idMateria": idMateria,
//         "idMatricula": idMatricula,
//         "estado": estado,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//         "matricula": matricula?.toJson(),
//     };
// }

// class Matricula {
//     int id;
//     DateTime? fecha;
//     dynamic idAcudiente;
//     int idAsignacionPeriodoProgramaJornada;
//     int idPersona;
//     int idCompany;
//     int idGrado;
//     String? estado;
//     dynamic createdAt;
//     dynamic updatedAt;
//     Persona? persona;

//     Matricula({
//         required this.id,
//         this.fecha,
//         this.idAcudiente,
//         required this.idAsignacionPeriodoProgramaJornada,
//         required this.idPersona,
//         required this.idCompany,
//         required this.idGrado,
//         this.estado,
//         this.createdAt,
//         this.updatedAt,
//         this.persona,
//     });

//     factory Matricula.fromJson(Map<String, dynamic> json) => Matricula(
//         id: json["id"],
//         fecha: json["fecha"] != null ? DateTime.parse(json["fecha"]) : null,
//         idAcudiente: json["idAcudiente"],
//         idAsignacionPeriodoProgramaJornada: json["idAsignacionPeriodoProgramaJornada"],
//         idPersona: json["idPersona"],
//         idCompany: json["idCompany"],
//         idGrado: json["idGrado"],
//         estado: json["estado"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//         persona: json["persona"] != null ? Persona.fromJson(json["persona"]) : null,
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "fecha": fecha?.toIso8601String(),
//         "idAcudiente": idAcudiente,
//         "idAsignacionPeriodoProgramaJornada": idAsignacionPeriodoProgramaJornada,
//         "idPersona": idPersona,
//         "idCompany": idCompany,
//         "idGrado": idGrado,
//         "estado": estado,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//         "persona": persona?.toJson(),
//     };
// }

// class Persona {
//     int id;
//     String? identificacion;
//     String? nombre1;
//     String? nombre2;
//     String? apellido1;
//     String? apellido2;
//     DateTime? fechaNac;
//     String? direccion;
//     String? email;
//     String? telefonoFijo;
//     String? celular;
//     String? perfil;
//     String? sexo;
//     String? rh;
//     dynamic rutaFoto;
//     int? idTipoIdentificacion;
//     int? idCiudadNac;
//     int? idCiudadResi;
//     int? idCiudadTrab;
//     int? idEstadoCivil;
//     String? estado;
//     dynamic createdAt;
//     dynamic updatedAt;

//     Persona({
//         required this.id,
//         this.identificacion,
//         this.nombre1,
//         this.nombre2,
//         this.apellido1,
//         this.apellido2,
//         this.fechaNac,
//         this.direccion,
//         this.email,
//         this.telefonoFijo,
//         this.celular,
//         this.perfil,
//         this.sexo,
//         this.rh,
//         this.rutaFoto,
//         this.idTipoIdentificacion,
//         this.idCiudadNac,
//         this.idCiudadResi,
//         this.idCiudadTrab,
//         this.idEstadoCivil,
//         this.estado,
//         this.createdAt,
//         this.updatedAt,
//     });

//     factory Persona.fromJson(Map<String, dynamic> json) => Persona(
//         id: json["id"],
//         identificacion: json["identificacion"],
//         nombre1: json["nombre1"],
//         nombre2: json["nombre2"],
//         apellido1: json["apellido1"],
//         apellido2: json["apellido2"],
//         fechaNac: json["fechaNac"] != null ? DateTime.parse(json["fechaNac"]) : null,
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
//         idCiudadResi: json["idCiudadResi"],
//         idCiudadTrab: json["idCiudadTrab"],
//         idEstadoCivil: json["idEstadoCivil"],
//         estado: json["estado"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "identificacion": identificacion,
//         "nombre1": nombre1,
//         "nombre2": nombre2,
//         "apellido1": apellido1,
//         "apellido2": apellido2,
//         "fechaNac": fechaNac?.toIso8601String(),
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
//         "idCiudadResi": idCiudadResi,
//         "idCiudadTrab": idCiudadTrab,
//         "idEstadoCivil": idEstadoCivil,
//         "estado": estado,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//     };
// }


import 'dart:convert';

List<Registrationsactivity> registrationsactivityFromJson(String str) =>
    List<Registrationsactivity>.from(
        json.decode(str).map((x) => Registrationsactivity.fromJson(x)));

String registrationsactivityToJson(List<Registrationsactivity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Registrationsactivity {
  final int id;
  final String archivo;
  final DateTime fechaCreacion;
  final DateTime fechaInicial;
  final DateTime fechaFinal;
  final String calificacionNumerica;
  final String calificacionEstandart;
  final String comentarioDocente;
  final String comentarioEstudiante;
  final dynamic idActividad;
  final dynamic idAMartriculaAcademica;
  final dynamic idEstado;
  final dynamic idGrupo;
  final dynamic idPersona;
  final String idCorte;
  final DateTime fechaCalificacion;
  final dynamic createdAt;
  final dynamic updatedAt;
  final String notificacionEnviada;
  final String docRespuesta;
  final MatriculaAcademica matriculaAcademica;
  final Estado estado;

  Registrationsactivity({
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
    required this.docRespuesta,
    required this.matriculaAcademica,
    required this.estado,
  });

  factory Registrationsactivity.fromJson(Map<String, dynamic> json) =>
      Registrationsactivity(
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
        fechaCalificacion: DateTime.parse(json["fechaCalificacion"]),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        notificacionEnviada: json["notificacionEnviada"],
        docRespuesta: json["DocRespuesta"],
        matriculaAcademica: MatriculaAcademica.fromJson(json["matriculaAcademica"]),
        estado: Estado.fromJson(json["estado"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "archivo": archivo,
        "fechaCreacion": fechaCreacion.toIso8601String(),
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
        "fechaCalificacion": fechaCalificacion.toIso8601String(),
        "created_at": createdAt,
        "updated_at": updatedAt,
        "notificacionEnviada": notificacionEnviada,
        "DocRespuesta": docRespuesta,
        "matriculaAcademica": matriculaAcademica.toJson(),
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

class MatriculaAcademica {
  final int id;
  final String idAsignacionPeriodoProgramaJornada;
  final String idMateria;
  final String idMatricula;
  final String estado;
  final dynamic createdAt;
  final dynamic updatedAt;
  final Matricula matricula;

  MatriculaAcademica({
    required this.id,
    required this.idAsignacionPeriodoProgramaJornada,
    required this.idMateria,
    required this.idMatricula,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
    required this.matricula,
  });

  factory MatriculaAcademica.fromJson(Map<String, dynamic> json) =>
      MatriculaAcademica(
        id: json["id"],
        idAsignacionPeriodoProgramaJornada: json["idAsignacionPeriodoProgramaJornada"],
        idMateria: json["idMateria"],
        idMatricula: json["idMatricula"],
        estado: json["estado"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        matricula: Matricula.fromJson(json["matricula"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idAsignacionPeriodoProgramaJornada": idAsignacionPeriodoProgramaJornada,
        "idMateria": idMateria,
        "idMatricula": idMatricula,
        "estado": estado,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "matricula": matricula.toJson(),
      };
}

class Matricula {
  final int id;
  final DateTime fecha;
  final dynamic idAcudiente;
  final String idAsignacionPeriodoProgramaJornada;
  final String idPersona;
  final String idCompany;
  final String idGrado;
  final String estado;
  final dynamic createdAt;
  final dynamic updatedAt;
  final Persona persona;

  Matricula({
    required this.id,
    required this.fecha,
    required this.idAcudiente,
    required this.idAsignacionPeriodoProgramaJornada,
    required this.idPersona,
    required this.idCompany,
    required this.idGrado,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
    required this.persona,
  });

  factory Matricula.fromJson(Map<String, dynamic> json) => Matricula(
        id: json["id"],
        fecha: DateTime.parse(json["fecha"]),
        idAcudiente: json["idAcudiente"],
        idAsignacionPeriodoProgramaJornada: json["idAsignacionPeriodoProgramaJornada"],
        idPersona: json["idPersona"],
        idCompany: json["idCompany"],
        idGrado: json["idGrado"],
        estado: json["estado"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        persona: Persona.fromJson(json["persona"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fecha": fecha.toIso8601String(),
        "idAcudiente": idAcudiente,
        "idAsignacionPeriodoProgramaJornada": idAsignacionPeriodoProgramaJornada,
        "idPersona": idPersona,
        "idCompany": idCompany,
        "idGrado": idGrado,
        "estado": estado,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "persona": persona.toJson(),
      };
}

class Persona {
  final int id;
  final String identificacion;
  final String nombre1;
  final dynamic nombre2;
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
  final String idTipoIdentificacion;
  final String idCiudadNac;
  final String idCiudadUbicacion;
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
        "fechaNac": fechaNac.toIso8601String(),
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
