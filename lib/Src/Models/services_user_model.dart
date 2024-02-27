// ignore_for_file: file_names

import 'dart:convert';

List<ServicesByUser> servicesByUserFromJson(String str) => List<ServicesByUser>.from(json.decode(str).map((x) => ServicesByUser.fromJson(x)));

String servicesByUserToJson(List<ServicesByUser> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServicesByUser {
    int id;
    DateTime fechaServicio;
    DateTime? finServicio;
    dynamic observaciones;
    String totalMinutos;
    String? idAfiliacion;
    String idUbicacionTelefono;
    String idCliente;
    String idEstado;
    String idEmpresa;
    dynamic idActivationCompanyUser;
    String origenServicio;
    Afiliacion? afiliacion;
    Estado estado;

    ServicesByUser({
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
        required this.estado,
    });

    factory ServicesByUser.fromJson(Map<String, dynamic> json) => ServicesByUser(
        id: json["id"],
        fechaServicio: DateTime.parse(json["fechaServicio"]),
        finServicio: json["finServicio"] == null ? null : DateTime.parse(json["finServicio"]),
        observaciones: json["observaciones"],
        totalMinutos: json["totalMinutos"],
        idAfiliacion: json["idAfiliacion"],
        idUbicacionTelefono: json["idUbicacionTelefono"],
        idCliente: json["idCliente"],
        idEstado: json["idEstado"],
        idEmpresa: json["idEmpresa"],
        idActivationCompanyUser: json["idActivationCompanyUser"],
        origenServicio: json["origenServicio"],
        afiliacion: json["afiliacion"] == null ? null : Afiliacion.fromJson(json["afiliacion"]),
        estado: Estado.fromJson(json["estado"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fechaServicio": fechaServicio.toIso8601String(),
        "finServicio": finServicio?.toIso8601String(),
        "observaciones": observaciones,
        "totalMinutos": totalMinutos,
        "idAfiliacion": idAfiliacion,
        "idUbicacionTelefono": idUbicacionTelefono,
        "idCliente": idCliente,
        "idEstado": idEstado,
        "idEmpresa": idEmpresa,
        "idActivationCompanyUser": idActivationCompanyUser,
        "origenServicio": origenServicio,
        "afiliacion": afiliacion?.toJson(),
        "estado": estado.toJson(),
    };
}

class Afiliacion {
    int id;
    DateTime fechaAfiliacion;
    dynamic fechaFinalAfiliacion;
    String numero;
    String idEstado;
    String idEmpresa;
    dynamic bloqueo;
    List<Conductor> conductor;
    List<Vehiculo> vehiculo;

    Afiliacion({
        required this.id,
        required this.fechaAfiliacion,
        required this.fechaFinalAfiliacion,
        required this.numero,
        required this.idEstado,
        required this.idEmpresa,
        required this.bloqueo,
        required this.conductor,
        required this.vehiculo,
    });

    factory Afiliacion.fromJson(Map<String, dynamic> json) => Afiliacion(
        id: json["id"],
        fechaAfiliacion: DateTime.parse(json["fechaAfiliacion"]),
        fechaFinalAfiliacion: json["fechaFinalAfiliacion"],
        numero: json["numero"],
        idEstado: json["idEstado"],
        idEmpresa: json["idEmpresa"],
        bloqueo: json["bloqueo"],
        conductor: List<Conductor>.from(json["conductor"].map((x) => Conductor.fromJson(x))),
        vehiculo: List<Vehiculo>.from(json["vehiculo"].map((x) => Vehiculo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fechaAfiliacion": fechaAfiliacion.toIso8601String(),
        "fechaFinalAfiliacion": fechaFinalAfiliacion,
        "numero": numero,
        "idEstado": idEstado,
        "idEmpresa": idEmpresa,
        "bloqueo": bloqueo,
        "conductor": List<dynamic>.from(conductor.map((x) => x.toJson())),
        "vehiculo": List<dynamic>.from(vehiculo.map((x) => x.toJson())),
    };
}

class Conductor {
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
    dynamic perfil;
    String sexo;
    String rh;
    String rutaFoto;
    String idTipoIdentificacion;
    String idCiudad;
    String idCiudadNac;
    String idCiudadUbicacion;
    DateTime createdAt;
    DateTime updatedAt;
    String rutaFotoUrl;
    ConductorPivot pivot;

    Conductor({
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
        required this.idCiudad,
        required this.idCiudadNac,
        required this.idCiudadUbicacion,
        required this.createdAt,
        required this.updatedAt,
        required this.rutaFotoUrl,
        required this.pivot,
    });

    factory Conductor.fromJson(Map<String, dynamic> json) => Conductor(
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
        idCiudad: json["idCiudad"],
        idCiudadNac: json["idCiudadNac"],
        idCiudadUbicacion: json["idCiudadUbicacion"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        rutaFotoUrl: json["rutaFotoUrl"],
        pivot: ConductorPivot.fromJson(json["pivot"]),
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
        "idCiudad": idCiudad,
        "idCiudadNac": idCiudadNac,
        "idCiudadUbicacion": idCiudadUbicacion,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "rutaFotoUrl": rutaFotoUrl,
        "pivot": pivot.toJson(),
    };
}

class ConductorPivot {
    String idAfiliacion;
    String idConductor;

    ConductorPivot({
        required this.idAfiliacion,
        required this.idConductor,
    });

    factory ConductorPivot.fromJson(Map<String, dynamic> json) => ConductorPivot(
        idAfiliacion: json["idAfiliacion"],
        idConductor: json["idConductor"],
    );

    Map<String, dynamic> toJson() => {
        "idAfiliacion": idAfiliacion,
        "idConductor": idConductor,
    };
}

class Vehiculo {
    int id;
    String placa;
    String chasis;
    String serie;
    String runt;
    dynamic foto;
    String idModelo;
    String idTipo;
    String idMarca;
    String idEstado;
    String idEmpresa;
    dynamic createdAt;
    dynamic updatedAt;
    String fotoUrl;
    VehiculoPivot pivot;
    Modelo modelo;

    Vehiculo({
        required this.id,
        required this.placa,
        required this.chasis,
        required this.serie,
        required this.runt,
        required this.foto,
        required this.idModelo,
        required this.idTipo,
        required this.idMarca,
        required this.idEstado,
        required this.idEmpresa,
        required this.createdAt,
        required this.updatedAt,
        required this.fotoUrl,
        required this.pivot,
        required this.modelo,
    });

    factory Vehiculo.fromJson(Map<String, dynamic> json) => Vehiculo(
        id: json["id"],
        placa: json["placa"],
        chasis: json["chasis"],
        serie: json["serie"],
        runt: json["runt"],
        foto: json["foto"],
        idModelo: json["idModelo"],
        idTipo: json["idTipo"],
        idMarca: json["idMarca"],
        idEstado: json["idEstado"],
        idEmpresa: json["idEmpresa"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        fotoUrl: json["fotoUrl"],
        pivot: VehiculoPivot.fromJson(json["pivot"]),
        modelo: Modelo.fromJson(json["modelo"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "placa": placa,
        "chasis": chasis,
        "serie": serie,
        "runt": runt,
        "foto": foto,
        "idModelo": idModelo,
        "idTipo": idTipo,
        "idMarca": idMarca,
        "idEstado": idEstado,
        "idEmpresa": idEmpresa,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "fotoUrl": fotoUrl,
        "pivot": pivot.toJson(),
        "modelo": modelo.toJson(),
    };
}

class Modelo {
    int id;
    String modelo;
    dynamic descripcion;

    Modelo({
        required this.id,
        required this.modelo,
        required this.descripcion,
    });

    factory Modelo.fromJson(Map<String, dynamic> json) => Modelo(
        id: json["id"],
        modelo: json["modelo"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "modelo": modelo,
        "descripcion": descripcion,
    };
}

class VehiculoPivot {
    String idAfiliacion;
    String idVehiculo;

    VehiculoPivot({
        required this.idAfiliacion,
        required this.idVehiculo,
    });

    factory VehiculoPivot.fromJson(Map<String, dynamic> json) => VehiculoPivot(
        idAfiliacion: json["idAfiliacion"],
        idVehiculo: json["idVehiculo"],
    );

    Map<String, dynamic> toJson() => {
        "idAfiliacion": idAfiliacion,
        "idVehiculo": idVehiculo,
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
