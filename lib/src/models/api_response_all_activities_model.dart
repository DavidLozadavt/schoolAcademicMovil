class TipoActividad {
  int id;
  String tipoActividad;
  String descripcion;
  String idCompany;

  TipoActividad({
    required this.id,
    required this.tipoActividad,
    required this.descripcion,
    required this.idCompany,
  });

  factory TipoActividad.fromJson(Map<String, dynamic> json) {
    return TipoActividad(
      id: json['id'],
      tipoActividad: json['tipoActividad'],
      descripcion: json['descripcion'],
      idCompany: json['idCompany'],
    );
  }
}

class Materia {
  int id;
  String nombreMateria;
  String descripcion;
  String idCompany;
  String createdAt;
  String updatedAt;
  String idAreaConocimiento;

  Materia({
    required this.id,
    required this.nombreMateria,
    required this.descripcion,
    required this.idCompany,
    required this.createdAt,
    required this.updatedAt,
    required this.idAreaConocimiento,
  });

  factory Materia.fromJson(Map<String, dynamic> json) {
    return Materia(
      id: json['id'],
      nombreMateria: json['nombreMateria'],
      descripcion: json['descripcion'],
      idCompany: json['idCompany'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      idAreaConocimiento: json['idAreaConocimiento'],
    );
  }
}

class Estado {
  int id;
  String estado;
  String descripcion;

  Estado({
    required this.id,
    required this.estado,
    required this.descripcion,
  });

  factory Estado.fromJson(Map<String, dynamic> json) {
    return Estado(
      id: json['id'],
      estado: json['estado'],
      descripcion: json['descripcion'],
    );
  }
}

class Actividad {
  int id;
  String tituloActividad;
  String descripcionActividad;
  String pathDocumentoActividad;
  String autor;
  String idTipoActividad;
  String idMateria;
  String idEstado;
  String idCompany;
  String docUrl;
  TipoActividad tipoActividad;
  Materia materia;
  Estado estado;

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
    required this.docUrl,
    required this.tipoActividad,
    required this.materia,
    required this.estado,
  });

  factory Actividad.fromJson(Map<String, dynamic> json) {
    return Actividad(
      id: json['id'],
      tituloActividad: json['tituloActividad'],
      descripcionActividad: json['descripcionActividad'],
      pathDocumentoActividad: json['pathDocumentoActividad'],
      autor: json['autor'],
      idTipoActividad: json['idTipoActividad'],
      idMateria: json['idMateria'],
      idEstado: json['idEstado'],
      idCompany: json['idCompany'],
      docUrl: json['DocUrl'],
      tipoActividad: TipoActividad.fromJson(json['tipoActividad']),
      materia: Materia.fromJson(json['materia']),
      estado: Estado.fromJson(json['estado']),
    );
  }
}
