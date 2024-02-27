// To parse this JSON data, do
//
//     final dataUserLog = dataUserLogFromJson(jsonString);

import 'dart:convert';

List<DataUserLog> dataUserLogFromJson(String str) => List<DataUserLog>.from(json.decode(str).map((x) => DataUserLog.fromJson(x)));

String dataUserLogToJson(List<DataUserLog> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataUserLog {
    int id;
    int idUser;
    int idEstado;
    int idCompany;
    DateTime fechaInicio;
    DateTime fechaFin;
    DateTime createdAt;
    DateTime updatedAt;
    Company company;
    User user;
    List<Role> roles;
    Estado estado;

    DataUserLog({
        required this.id,
        required this.idUser,
        required this.idEstado,
        required this.idCompany,
        required this.fechaInicio,
        required this.fechaFin,
        required this.createdAt,
        required this.updatedAt,
        required this.company,
        required this.user,
        required this.roles,
        required this.estado,
    });

    factory DataUserLog.fromJson(Map<String, dynamic> json) => DataUserLog(
        id: json["id"],
        idUser: json["idUser"],
        idEstado: json["idEstado"],
        idCompany: json["idCompany"],
        fechaInicio: DateTime.parse(json["fechaInicio"]),
        fechaFin: DateTime.parse(json["fechaFin"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        company: Company.fromJson(json["company"]),
        user: User.fromJson(json["user"]),
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
        estado: Estado.fromJson(json["estado"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idUser": idUser,
        "idEstado": idEstado,
        "idCompany": idCompany,
        "fechaInicio": "${fechaInicio.year.toString().padLeft(4, '0')}-${fechaInicio.month.toString().padLeft(2, '0')}-${fechaInicio.day.toString().padLeft(2, '0')}",
        "fechaFin": "${fechaFin.year.toString().padLeft(4, '0')}-${fechaFin.month.toString().padLeft(2, '0')}-${fechaFin.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "company": company.toJson(),
        "user": user.toJson(),
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
        "estado": estado.toJson(),
    };
}

class Company {
    int id;
    String razonSocial;
    String email;
    String nit;
    String rutaLogo;
    String representanteLegal;
    int digitoVerificacion;
    DateTime createdAt;
    DateTime updatedAt;
    String rutaLogoUrl;

    Company({
        required this.id,
        required this.razonSocial,
        required this.email,
        required this.nit,
        required this.rutaLogo,
        required this.representanteLegal,
        required this.digitoVerificacion,
        required this.createdAt,
        required this.updatedAt,
        required this.rutaLogoUrl,
    });

    factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        razonSocial: json["razonSocial"],
        email: json["email"],
        nit: json["nit"],
        rutaLogo: json["rutaLogo"],
        representanteLegal: json["representanteLegal"],
        digitoVerificacion: json["digitoVerificacion"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        rutaLogoUrl: json["rutaLogoUrl"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "razonSocial": razonSocial,
        "email": email,
        "nit": nit,
        "rutaLogo": rutaLogo,
        "representanteLegal": representanteLegal,
        "digitoVerificacion": digitoVerificacion,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "rutaLogoUrl": rutaLogoUrl,
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

class Role {
    int id;
    String name;
    String guardName;
    String rutaImagen;
    DateTime createdAt;
    DateTime updatedAt;
    int idCompany;
    Pivot pivot;

    Role({
        required this.id,
        required this.name,
        required this.guardName,
        required this.rutaImagen,
        required this.createdAt,
        required this.updatedAt,
        required this.idCompany,
        required this.pivot,
    });

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        guardName: json["guard_name"],
        rutaImagen: json["rutaImagen"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        idCompany: json["idCompany"],
        pivot: Pivot.fromJson(json["pivot"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "guard_name": guardName,
        "rutaImagen": rutaImagen,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "idCompany": idCompany,
        "pivot": pivot.toJson(),
    };
}

class Pivot {
    int modelId;
    int roleId;
    String modelType;

    Pivot({
        required this.modelId,
        required this.roleId,
        required this.modelType,
    });

    factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        modelId: json["model_id"],
        roleId: json["role_id"],
        modelType: json["model_type"],
    );

    Map<String, dynamic> toJson() => {
        "model_id": modelId,
        "role_id": roleId,
        "model_type": modelType,
    };
}

class User {
    int id;
    String email;
    int idPersona;
    DateTime emailVerifiedAt;
    Persona persona;

    User({
        required this.id,
        required this.email,
        required this.idPersona,
        required this.emailVerifiedAt,
        required this.persona,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
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
    };
}
