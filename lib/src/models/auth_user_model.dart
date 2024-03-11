// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
    String accessToken;
    Payload payload;
    User user;

    UserData({
        required this.accessToken,
        required this.payload,
        required this.user,
    });

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        accessToken: json["access_token"],
        payload: Payload.fromJson(json["payload"]),
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "payload": payload.toJson(),
        "user": user.toJson(),
    };
}

class Payload {
    String iss;
    int iat;
    int exp;
    int nbf;
    String jti;
    String sub;
    String prv;
    String idCompany;
    List<String> roles;
    List<String> permissions;
    Company company;

    Payload({
        required this.iss,
        required this.iat,
        required this.exp,
        required this.nbf,
        required this.jti,
        required this.sub,
        required this.prv,
        required this.idCompany,
        required this.roles,
        required this.permissions,
        required this.company,
    });

    factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        iss: json["iss"],
        iat: json["iat"],
        exp: json["exp"],
        nbf: json["nbf"],
        jti: json["jti"],
        sub: json["sub"],
        prv: json["prv"],
        idCompany: json["idCompany"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        permissions: List<String>.from(json["permissions"].map((x) => x)),
        company: Company.fromJson(json["company"]),
    );

    Map<String, dynamic> toJson() => {
        "iss": iss,
        "iat": iat,
        "exp": exp,
        "nbf": nbf,
        "jti": jti,
        "sub": sub,
        "prv": prv,
        "idCompany": idCompany,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "permissions": List<dynamic>.from(permissions.map((x) => x)),
        "company": company.toJson(),
    };
}

class Company {
    int id;
    String razonSocial;
    String email;
    String nit;
    String rutaLogo;
    String representanteLegal;
    String digitoVerificacion;
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

class User {
    int id;
    String email;
    String idPersona;
    DateTime emailVerifiedAt;
    Persona persona;
    List<ActivationCompanyUser> activationCompanyUsers;

    User({
        required this.id,
        required this.email,
        required this.idPersona,
        required this.emailVerifiedAt,
        required this.persona,
        required this.activationCompanyUsers,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        idPersona: json["idPersona"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        persona: Persona.fromJson(json["persona"]),
        activationCompanyUsers: List<ActivationCompanyUser>.from(json["activation_company_users"].map((x) => ActivationCompanyUser.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "idPersona": idPersona,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "persona": persona.toJson(),
        "activation_company_users": List<dynamic>.from(activationCompanyUsers.map((x) => x.toJson())),
    };
}

class ActivationCompanyUser {
    int id;
    String idUser;
    String idEstado;
    String idCompany;
    DateTime fechaInicio;
    DateTime fechaFin;
    DateTime createdAt;
    DateTime updatedAt;

    ActivationCompanyUser({
        required this.id,
        required this.idUser,
        required this.idEstado,
        required this.idCompany,
        required this.fechaInicio,
        required this.fechaFin,
        required this.createdAt,
        required this.updatedAt,
    });

    factory ActivationCompanyUser.fromJson(Map<String, dynamic> json) => ActivationCompanyUser(
        id: json["id"],
        idUser: json["idUser"],
        idEstado: json["idEstado"],
        idCompany: json["idCompany"],
        fechaInicio: DateTime.parse(json["fechaInicio"]),
        fechaFin: DateTime.parse(json["fechaFin"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
    String idTipoIdentificacion;
    String idCiudadNac;
    String idCiudadUbicacion;
    DateTime createdAt;
    DateTime updatedAt;
    CiudadNac ubicacion;
    dynamic ciudad;
    CiudadNac ciudadNac;
    CiudadNac ciudadUbicacion;
    TipoIdentificacion tipoIdentificacion;

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
        required this.ubicacion,
        required this.ciudad,
        required this.ciudadNac,
        required this.ciudadUbicacion,
        required this.tipoIdentificacion,
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
        ubicacion: CiudadNac.fromJson(json["ubicacion"]),
        ciudad: json["ciudad"],
        ciudadNac: CiudadNac.fromJson(json["ciudad_nac"]),
        ciudadUbicacion: CiudadNac.fromJson(json["ciudad_ubicacion"]),
        tipoIdentificacion: TipoIdentificacion.fromJson(json["tipo_identificacion"]),
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
        "ubicacion": ubicacion.toJson(),
        "ciudad": ciudad,
        "ciudad_nac": ciudadNac.toJson(),
        "ciudad_ubicacion": ciudadUbicacion.toJson(),
        "tipo_identificacion": tipoIdentificacion.toJson(),
    };
}

class CiudadNac {
    int id;
    String codigo;
    String descripcion;
    String idDepartamento;
    dynamic createdAt;
    dynamic updatedAt;
    Departamento? departamento;

    CiudadNac({
        required this.id,
        required this.codigo,
        required this.descripcion,
        required this.idDepartamento,
        required this.createdAt,
        required this.updatedAt,
        this.departamento,
    });

    factory CiudadNac.fromJson(Map<String, dynamic> json) => CiudadNac(
        id: json["id"],
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        idDepartamento: json["idDepartamento"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        departamento: json["departamento"] == null ? null : Departamento.fromJson(json["departamento"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "descripcion": descripcion,
        "idDepartamento": idDepartamento,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "departamento": departamento?.toJson(),
    };
}

class Departamento {
    int id;
    String codigo;
    String descripcion;

    Departamento({
        required this.id,
        required this.codigo,
        required this.descripcion,
    });

    factory Departamento.fromJson(Map<String, dynamic> json) => Departamento(
        id: json["id"],
        codigo: json["codigo"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "descripcion": descripcion,
    };
}

class TipoIdentificacion {
    int id;
    String codigo;
    String detalle;

    TipoIdentificacion({
        required this.id,
        required this.codigo,
        required this.detalle,
    });

    factory TipoIdentificacion.fromJson(Map<String, dynamic> json) => TipoIdentificacion(
        id: json["id"],
        codigo: json["codigo"],
        detalle: json["detalle"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "detalle": detalle,
    };
}

/*
import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
    String accessToken;
    Payload payload;
    User user;

    UserData({
        required this.accessToken,
        required this.payload,
        required this.user,
    });

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        accessToken: json["access_token"],
        payload: Payload.fromJson(json["payload"]),
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "payload": payload.toJson(),
        "user": user.toJson(),
    };
}

class Payload {
    String iss;
    int iat;
    int exp;
    int nbf;
    String jti;
    String sub;
    String prv;
    int idCompany;
    List<String> roles;
    List<String> permissions;
    Company company;

    Payload({
        required this.iss,
        required this.iat,
        required this.exp,
        required this.nbf,
        required this.jti,
        required this.sub,
        required this.prv,
        required this.idCompany,
        required this.roles,
        required this.permissions,
        required this.company,
    });

    factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        iss: json["iss"],
        iat: json["iat"],
        exp: json["exp"],
        nbf: json["nbf"],
        jti: json["jti"],
        sub: json["sub"],
        prv: json["prv"],
        idCompany: json["idCompany"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        permissions: List<String>.from(json["permissions"].map((x) => x)),
        company: Company.fromJson(json["company"]),
    );

    Map<String, dynamic> toJson() => {
        "iss": iss,
        "iat": iat,
        "exp": exp,
        "nbf": nbf,
        "jti": jti,
        "sub": sub,
        "prv": prv,
        "idCompany": idCompany,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "permissions": List<dynamic>.from(permissions.map((x) => x)),
        "company": company.toJson(),
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

class User {
    int id;
    String email;
    int idPersona;
    DateTime emailVerifiedAt;
    Persona persona;
    List<ActivationCompanyUser> activationCompanyUsers;

    User({
        required this.id,
        required this.email,
        required this.idPersona,
        required this.emailVerifiedAt,
        required this.persona,
        required this.activationCompanyUsers,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        idPersona: json["idPersona"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        persona: Persona.fromJson(json["persona"]),
        activationCompanyUsers: List<ActivationCompanyUser>.from(json["activation_company_users"].map((x) => ActivationCompanyUser.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "idPersona": idPersona,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "persona": persona.toJson(),
        "activation_company_users": List<dynamic>.from(activationCompanyUsers.map((x) => x.toJson())),
    };
}

class ActivationCompanyUser {
    int id;
    int idUser;
    int idEstado;
    int idCompany;
    DateTime fechaInicio;
    DateTime fechaFin;
    DateTime createdAt;
    DateTime updatedAt;

    ActivationCompanyUser({
        required this.id,
        required this.idUser,
        required this.idEstado,
        required this.idCompany,
        required this.fechaInicio,
        required this.fechaFin,
        required this.createdAt,
        required this.updatedAt,
    });

    factory ActivationCompanyUser.fromJson(Map<String, dynamic> json) => ActivationCompanyUser(
        id: json["id"],
        idUser: json["idUser"],
        idEstado: json["idEstado"],
        idCompany: json["idCompany"],
        fechaInicio: DateTime.parse(json["fechaInicio"]),
        fechaFin: DateTime.parse(json["fechaFin"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
    CiudadNac ubicacion;
    dynamic ciudad;
    CiudadNac ciudadNac;
    CiudadNac ciudadUbicacion;
    TipoIdentificacion tipoIdentificacion;

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
        required this.ubicacion,
        required this.ciudad,
        required this.ciudadNac,
        required this.ciudadUbicacion,
        required this.tipoIdentificacion,
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
        ubicacion: CiudadNac.fromJson(json["ubicacion"]),
        ciudad: json["ciudad"],
        ciudadNac: CiudadNac.fromJson(json["ciudad_nac"]),
        ciudadUbicacion: CiudadNac.fromJson(json["ciudad_ubicacion"]),
        tipoIdentificacion: TipoIdentificacion.fromJson(json["tipo_identificacion"]),
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
        "ubicacion": ubicacion.toJson(),
        "ciudad": ciudad,
        "ciudad_nac": ciudadNac.toJson(),
        "ciudad_ubicacion": ciudadUbicacion.toJson(),
        "tipo_identificacion": tipoIdentificacion.toJson(),
    };
}

class CiudadNac {
    int id;
    String codigo;
    String descripcion;
    int idDepartamento;
    dynamic createdAt;
    dynamic updatedAt;
    Departamento? departamento;

    CiudadNac({
        required this.id,
        required this.codigo,
        required this.descripcion,
        required this.idDepartamento,
        required this.createdAt,
        required this.updatedAt,
        this.departamento,
    });

    factory CiudadNac.fromJson(Map<String, dynamic> json) => CiudadNac(
        id: json["id"],
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        idDepartamento: json["idDepartamento"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        departamento: json["departamento"] == null ? null : Departamento.fromJson(json["departamento"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "descripcion": descripcion,
        "idDepartamento": idDepartamento,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "departamento": departamento?.toJson(),
    };
}

class Departamento {
    int id;
    String codigo;
    String descripcion;

    Departamento({
        required this.id,
        required this.codigo,
        required this.descripcion,
    });

    factory Departamento.fromJson(Map<String, dynamic> json) => Departamento(
        id: json["id"],
        codigo: json["codigo"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "descripcion": descripcion,
    };
}

class TipoIdentificacion {
    int id;
    String codigo;
    String detalle;

    TipoIdentificacion({
        required this.id,
        required this.codigo,
        required this.detalle,
    });

    factory TipoIdentificacion.fromJson(Map<String, dynamic> json) => TipoIdentificacion(
        id: json["id"],
        codigo: json["codigo"],
        detalle: json["detalle"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "detalle": detalle,
    };
}
*/

/*import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    String accessToken;
    Payload payload;
    UserClass user;

    User({
        required this.accessToken,
        required this.payload,
        required this.user,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        accessToken: json["access_token"],
        payload: Payload.fromJson(json["payload"]),
        user: UserClass.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "payload": payload.toJson(),
        "user": user.toJson(),
    };
}

class Payload {
    String iss;
    int iat;
    int exp;
    int nbf;
    String jti;
    String sub;
    String prv;
    int idCompany;
    List<String> roles;
    List<String> permissions;
    Company company;

    Payload({
        required this.iss,
        required this.iat,
        required this.exp,
        required this.nbf,
        required this.jti,
        required this.sub,
        required this.prv,
        required this.idCompany,
        required this.roles,
        required this.permissions,
        required this.company,
    });

    factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        iss: json["iss"],
        iat: json["iat"],
        exp: json["exp"],
        nbf: json["nbf"],
        jti: json["jti"],
        sub: json["sub"],
        prv: json["prv"],
        idCompany: json["idCompany"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        permissions: List<String>.from(json["permissions"].map((x) => x)),
        company: Company.fromJson(json["company"]),
    );

    Map<String, dynamic> toJson() => {
        "iss": iss,
        "iat": iat,
        "exp": exp,
        "nbf": nbf,
        "jti": jti,
        "sub": sub,
        "prv": prv,
        "idCompany": idCompany,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "permissions": List<dynamic>.from(permissions.map((x) => x)),
        "company": company.toJson(),
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

class UserClass {
    int id;
    String email;
    int idPersona;
    DateTime emailVerifiedAt;
    Persona persona;
    List<ActivationCompanyUser> activationCompanyUsers;

    UserClass({
        required this.id,
        required this.email,
        required this.idPersona,
        required this.emailVerifiedAt,
        required this.persona,
        required this.activationCompanyUsers,
    });

    factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["id"],
        email: json["email"],
        idPersona: json["idPersona"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        persona: Persona.fromJson(json["persona"]),
        activationCompanyUsers: List<ActivationCompanyUser>.from(json["activation_company_users"].map((x) => ActivationCompanyUser.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "idPersona": idPersona,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "persona": persona.toJson(),
        "activation_company_users": List<dynamic>.from(activationCompanyUsers.map((x) => x.toJson())),
    };
}

class ActivationCompanyUser {
    int id;
    int idUser;
    int idEstado;
    int idCompany;
    DateTime fechaInicio;
    DateTime fechaFin;
    DateTime createdAt;
    DateTime updatedAt;

    ActivationCompanyUser({
        required this.id,
        required this.idUser,
        required this.idEstado,
        required this.idCompany,
        required this.fechaInicio,
        required this.fechaFin,
        required this.createdAt,
        required this.updatedAt,
    });

    factory ActivationCompanyUser.fromJson(Map<String, dynamic> json) => ActivationCompanyUser(
        id: json["id"],
        idUser: json["idUser"],
        idEstado: json["idEstado"],
        idCompany: json["idCompany"],
        fechaInicio: DateTime.parse(json["fechaInicio"]),
        fechaFin: DateTime.parse(json["fechaFin"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
    CiudadNac ubicacion;
    dynamic ciudad;
    CiudadNac ciudadNac;
    CiudadNac ciudadUbicacion;
    TipoIdentificacion tipoIdentificacion;

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
        required this.ubicacion,
        required this.ciudad,
        required this.ciudadNac,
        required this.ciudadUbicacion,
        required this.tipoIdentificacion,
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
        ubicacion: CiudadNac.fromJson(json["ubicacion"]),
        ciudad: json["ciudad"],
        ciudadNac: CiudadNac.fromJson(json["ciudad_nac"]),
        ciudadUbicacion: CiudadNac.fromJson(json["ciudad_ubicacion"]),
        tipoIdentificacion: TipoIdentificacion.fromJson(json["tipo_identificacion"]),
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
        "ubicacion": ubicacion.toJson(),
        "ciudad": ciudad,
        "ciudad_nac": ciudadNac.toJson(),
        "ciudad_ubicacion": ciudadUbicacion.toJson(),
        "tipo_identificacion": tipoIdentificacion.toJson(),
    };
}

class CiudadNac {
    int id;
    String codigo;
    String descripcion;
    int idDepartamento;
    dynamic createdAt;
    dynamic updatedAt;
    Departamento? departamento;

    CiudadNac({
        required this.id,
        required this.codigo,
        required this.descripcion,
        required this.idDepartamento,
        required this.createdAt,
        required this.updatedAt,
        this.departamento,
    });

    factory CiudadNac.fromJson(Map<String, dynamic> json) => CiudadNac(
        id: json["id"],
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        idDepartamento: json["idDepartamento"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        departamento: json["departamento"] == null ? null : Departamento.fromJson(json["departamento"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "descripcion": descripcion,
        "idDepartamento": idDepartamento,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "departamento": departamento?.toJson(),
    };
}

class Departamento {
    int id;
    String codigo;
    String descripcion;

    Departamento({
        required this.id,
        required this.codigo,
        required this.descripcion,
    });

    factory Departamento.fromJson(Map<String, dynamic> json) => Departamento(
        id: json["id"],
        codigo: json["codigo"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "descripcion": descripcion,
    };
}

class TipoIdentificacion {
    int id;
    String codigo;
    String detalle;

    TipoIdentificacion({
        required this.id,
        required this.codigo,
        required this.detalle,
    });

    factory TipoIdentificacion.fromJson(Map<String, dynamic> json) => TipoIdentificacion(
        id: json["id"],
        codigo: json["codigo"],
        detalle: json["detalle"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "detalle": detalle,
    };
}


import 'dart:convert';
User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    String token;

    User({
        required this.token,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        token: json["access_token"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": token,
    };
}*/