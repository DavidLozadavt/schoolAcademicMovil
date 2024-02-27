import 'dart:convert';

CRequestService cRequestServiceFromJson(String str) => CRequestService.fromJson(json.decode(str));

String cRequestServiceToJson(CRequestService data) => json.encode(data.toJson());

class CRequestService {
    int id;
    DateTime fechaServicio;
    dynamic finServicio;
    String observaciones;
    String totalMinutos;
    dynamic idAfiliacion;
    String idUbicacionTelefono;
    String idCliente;
    String idEstado;
    String idEmpresa;
    dynamic idActivationCompanyUser;
    String origenServicio;
    dynamic afiliacion;
    UbicacionTelefono ubicacionTelefono;
    Estado estado;

    CRequestService({
        required this.id,
        required this.fechaServicio,
        required this.finServicio,
        required this.observaciones,
        required this.totalMinutos,
        required this.idAfiliacion,
        required this.idUbicacionTelefono,
        required this.idCliente,
        required this.idEstado,
        required this.idEmpresa,
        required this.idActivationCompanyUser,
        required this.origenServicio,
        required this.afiliacion,
        required this.ubicacionTelefono,
        required this.estado,
    });

    factory CRequestService.fromJson(Map<String, dynamic> json) => CRequestService(
        id: json["id"],
        fechaServicio: DateTime.parse(json["fechaServicio"]),
        finServicio: json["finServicio"],
        observaciones: json["observaciones"],
        totalMinutos: json["totalMinutos"],
        idAfiliacion: json["idAfiliacion"],
        idUbicacionTelefono: json["idUbicacionTelefono"],
        idCliente: json["idCliente"],
        idEstado: json["idEstado"],
        idEmpresa: json["idEmpresa"],
        idActivationCompanyUser: json["idActivationCompanyUser"],
        origenServicio: json["origenServicio"],
        afiliacion: json["afiliacion"],
        ubicacionTelefono: UbicacionTelefono.fromJson(json["ubicacionTelefono"]),
        estado: Estado.fromJson(json["estado"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fechaServicio": fechaServicio.toIso8601String(),
        "finServicio": finServicio,
        "observaciones": observaciones,
        "totalMinutos": totalMinutos,
        "idAfiliacion": idAfiliacion,
        "idUbicacionTelefono": idUbicacionTelefono,
        "idCliente": idCliente,
        "idEstado": idEstado,
        "idEmpresa": idEmpresa,
        "idActivationCompanyUser": idActivationCompanyUser,
        "origenServicio": origenServicio,
        "afiliacion": afiliacion,
        "ubicacionTelefono": ubicacionTelefono.toJson(),
        "estado": estado.toJson(),
    };
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

class UbicacionTelefono {
    int id;
    dynamic alpha;
    String idTelefono;
    String idUbicacion;
    dynamic idEmpresa;
    Ubicacion ubicacion;
    Telefono telefono;

    UbicacionTelefono({
        required this.id,
        required this.alpha,
        required this.idTelefono,
        required this.idUbicacion,
        required this.idEmpresa,
        required this.ubicacion,
        required this.telefono,
    });

    factory UbicacionTelefono.fromJson(Map<String, dynamic> json) => UbicacionTelefono(
        id: json["id"],
        alpha: json["alpha"],
        idTelefono: json["idTelefono"],
        idUbicacion: json["idUbicacion"],
        idEmpresa: json["idEmpresa"],
        ubicacion: Ubicacion.fromJson(json["ubicacion"]),
        telefono: Telefono.fromJson(json["telefono"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "alpha": alpha,
        "idTelefono": idTelefono,
        "idUbicacion": idUbicacion,
        "idEmpresa": idEmpresa,
        "ubicacion": ubicacion.toJson(),
        "telefono": telefono.toJson(),
    };
}

class Telefono {
    int id;
    String numeroTelefono;
    String idTipoTelefono;
    dynamic idEmpresa;
    TipoTelefono tipoTelefono;

    Telefono({
        required this.id,
        required this.numeroTelefono,
        required this.idTipoTelefono,
        required this.idEmpresa,
        required this.tipoTelefono,
    });

    factory Telefono.fromJson(Map<String, dynamic> json) => Telefono(
        id: json["id"],
        numeroTelefono: json["numeroTelefono"],
        idTipoTelefono: json["idTipoTelefono"],
        idEmpresa: json["idEmpresa"],
        tipoTelefono: TipoTelefono.fromJson(json["tipoTelefono"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "numeroTelefono": numeroTelefono,
        "idTipoTelefono": idTipoTelefono,
        "idEmpresa": idEmpresa,
        "tipoTelefono": tipoTelefono.toJson(),
    };
}

class TipoTelefono {
    int id;
    String tipo;

    TipoTelefono({
        required this.id,
        required this.tipo,
    });

    factory TipoTelefono.fromJson(Map<String, dynamic> json) => TipoTelefono(
        id: json["id"],
        tipo: json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
    };
}

class Ubicacion {
    int id;
    String direccion;
    String idBarrio;
    dynamic idEmpresa;
    Barrio barrio;

    Ubicacion({
        required this.id,
        required this.direccion,
        required this.idBarrio,
        required this.idEmpresa,
        required this.barrio,
    });

    factory Ubicacion.fromJson(Map<String, dynamic> json) => Ubicacion(
        id: json["id"],
        direccion: json["direccion"],
        idBarrio: json["idBarrio"],
        idEmpresa: json["idEmpresa"],
        barrio: Barrio.fromJson(json["barrio"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "direccion": direccion,
        "idBarrio": idBarrio,
        "idEmpresa": idEmpresa,
        "barrio": barrio.toJson(),
    };
}

class Barrio {
    int id;
    String nombre;
    String idCiudad;

    Barrio({
        required this.id,
        required this.nombre,
        required this.idCiudad,
    });

    factory Barrio.fromJson(Map<String, dynamic> json) => Barrio(
        id: json["id"],
        nombre: json["nombre"],
        idCiudad: json["idCiudad"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "idCiudad": idCiudad,
    };
}
