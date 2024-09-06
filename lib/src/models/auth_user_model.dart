//LocalHost
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
    int expiresIn;

    UserData({
        required this.accessToken,
        required this.payload,
        required this.user,
        required this.expiresIn,
    });

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        accessToken: json["access_token"],
        payload: Payload.fromJson(json["payload"]),
        user: User.fromJson(json["user"]),
        expiresIn: json["expires_in"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "payload": payload.toJson(),
        "user": user.toJson(),
        "expires_in": expiresIn,
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
    String deviceToken;
    dynamic emailVerifiedAt;
    String estadoMensajeria;
    Persona persona;
    List<ActivationCompanyUser> activationCompanyUsers;
    List<dynamic> estadoMensajeriaJornadas;

    User({
        required this.id,
        required this.email,
        required this.idPersona,
        required this.deviceToken,
        required this.emailVerifiedAt,
        required this.estadoMensajeria,
        required this.persona,
        required this.activationCompanyUsers,
        required this.estadoMensajeriaJornadas,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        idPersona: json["idPersona"],
        deviceToken: json["device_token"],
        emailVerifiedAt: json["email_verified_at"],
        estadoMensajeria: json["estadoMensajeria"],
        persona: Persona.fromJson(json["persona"]),
        activationCompanyUsers: List<ActivationCompanyUser>.from(json["activation_company_users"].map((x) => ActivationCompanyUser.fromJson(x))),
        estadoMensajeriaJornadas: List<dynamic>.from(json["estado_mensajeria_jornadas"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "idPersona": idPersona,
        "device_token": deviceToken,
        "email_verified_at": emailVerifiedAt,
        "estadoMensajeria": estadoMensajeria,
        "persona": persona.toJson(),
        "activation_company_users": List<dynamic>.from(activationCompanyUsers.map((x) => x.toJson())),
        "estado_mensajeria_jornadas": List<dynamic>.from(estadoMensajeriaJornadas.map((x) => x)),
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
    dynamic apellido2;
    DateTime fechaNac;
    String direccion;
    String email;
    String telefonoFijo;
    String celular;
    dynamic perfil;
    String sexo;
    String rh;
    String rutaFoto;
    int idTipoIdentificacion;
    int idCiudadNac;
    int idCiudadUbicacion;
    String tipoPersona;
    DateTime createdAt;
    DateTime updatedAt;
    Contrato contrato;
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
        required this.tipoPersona,
        required this.createdAt,
        required this.updatedAt,
        required this.contrato,
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
        tipoPersona: json["tipoPersona"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        contrato: Contrato.fromJson(json["contrato"]),
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
        "tipoPersona": tipoPersona,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "contrato": contrato.toJson(),
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
    int idPais;

    Departamento({
        required this.id,
        required this.codigo,
        required this.descripcion,
        required this.idPais,
    });

    factory Departamento.fromJson(Map<String, dynamic> json) => Departamento(
        id: json["id"],
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        idPais: json["idPais"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "descripcion": descripcion,
        "idPais": idPais,
    };
}

class Contrato {
    int id;
    int idpersona;
    int idCompany;
    int idEstado;
    int idtipoContrato;
    int idSalario;
    dynamic idContrato;
    DateTime fechaContratacion;
    DateTime fechaFinalContrato;
    int valorTotalContrato;
    dynamic sueldo;
    dynamic numeroContrato;
    String objetoContrato;
    String observacion;
    String perfilProfesional;
    String otrosi;
    int periodoPago;
    DateTime createdAt;
    DateTime updatedAt;

    Contrato({
        required this.id,
        required this.idpersona,
        required this.idCompany,
        required this.idEstado,
        required this.idtipoContrato,
        required this.idSalario,
        required this.idContrato,
        required this.fechaContratacion,
        required this.fechaFinalContrato,
        required this.valorTotalContrato,
        required this.sueldo,
        required this.numeroContrato,
        required this.objetoContrato,
        required this.observacion,
        required this.perfilProfesional,
        required this.otrosi,
        required this.periodoPago,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Contrato.fromJson(Map<String, dynamic> json) => Contrato(
        id: json["id"],
        idpersona: json["idpersona"],
        idCompany: json["idCompany"],
        idEstado: json["idEstado"],
        idtipoContrato: json["idtipoContrato"],
        idSalario: json["idSalario"],
        idContrato: json["idContrato"],
        fechaContratacion: DateTime.parse(json["fechaContratacion"]),
        fechaFinalContrato: DateTime.parse(json["fechaFinalContrato"]),
        valorTotalContrato: json["valorTotalContrato"],
        sueldo: json["sueldo"],
        numeroContrato: json["numeroContrato"],
        objetoContrato: json["objetoContrato"],
        observacion: json["observacion"],
        perfilProfesional: json["perfilProfesional"],
        otrosi: json["otrosi"],
        periodoPago: json["periodoPago"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idpersona": idpersona,
        "idCompany": idCompany,
        "idEstado": idEstado,
        "idtipoContrato": idtipoContrato,
        "idSalario": idSalario,
        "idContrato": idContrato,
        "fechaContratacion": "${fechaContratacion.year.toString().padLeft(4, '0')}-${fechaContratacion.month.toString().padLeft(2, '0')}-${fechaContratacion.day.toString().padLeft(2, '0')}",
        "fechaFinalContrato": "${fechaFinalContrato.year.toString().padLeft(4, '0')}-${fechaFinalContrato.month.toString().padLeft(2, '0')}-${fechaFinalContrato.day.toString().padLeft(2, '0')}",
        "valorTotalContrato": valorTotalContrato,
        "sueldo": sueldo,
        "numeroContrato": numeroContrato,
        "objetoContrato": objetoContrato,
        "observacion": observacion,
        "perfilProfesional": perfilProfesional,
        "otrosi": otrosi,
        "periodoPago": periodoPago,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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

//Preproduccion
/*import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
    String accessToken;
    Payload payload;
    User user;
    int expiresIn;

    UserData({
        required this.accessToken,
        required this.payload,
        required this.user,
        required this.expiresIn,
    });

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        accessToken: json["access_token"],
        payload: Payload.fromJson(json["payload"]),
        user: User.fromJson(json["user"]),
        expiresIn: json["expires_in"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "payload": payload.toJson(),
        "user": user.toJson(),
        "expires_in": expiresIn,
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
    String deviceToken;
    dynamic emailVerifiedAt;
    String estadoMensajeria;
    Persona persona;
    List<ActivationCompanyUser> activationCompanyUsers;
    List<dynamic> estadoMensajeriaJornadas;

    User({
        required this.id,
        required this.email,
        required this.idPersona,
        required this.deviceToken,
        required this.emailVerifiedAt,
        required this.estadoMensajeria,
        required this.persona,
        required this.activationCompanyUsers,
        required this.estadoMensajeriaJornadas,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        idPersona: json["idPersona"],
        deviceToken: json["device_token"],
        emailVerifiedAt: json["email_verified_at"],
        estadoMensajeria: json["estadoMensajeria"],
        persona: Persona.fromJson(json["persona"]),
        activationCompanyUsers: List<ActivationCompanyUser>.from(json["activation_company_users"].map((x) => ActivationCompanyUser.fromJson(x))),
        estadoMensajeriaJornadas: List<dynamic>.from(json["estado_mensajeria_jornadas"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "idPersona": idPersona,
        "device_token": deviceToken,
        "email_verified_at": emailVerifiedAt,
        "estadoMensajeria": estadoMensajeria,
        "persona": persona.toJson(),
        "activation_company_users": List<dynamic>.from(activationCompanyUsers.map((x) => x.toJson())),
        "estado_mensajeria_jornadas": List<dynamic>.from(estadoMensajeriaJornadas.map((x) => x)),
    };
}

class ActivationCompanyUser {
    int id;
    String idUser;
    String idEstado;
    String idCompany;
    DateTime fechaInicio;
    DateTime fechaFin;
    dynamic createdAt;
    dynamic updatedAt;

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
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idUser": idUser,
        "idEstado": idEstado,
        "idCompany": idCompany,
        "fechaInicio": "${fechaInicio.year.toString().padLeft(4, '0')}-${fechaInicio.month.toString().padLeft(2, '0')}-${fechaInicio.day.toString().padLeft(2, '0')}",
        "fechaFin": "${fechaFin.year.toString().padLeft(4, '0')}-${fechaFin.month.toString().padLeft(2, '0')}-${fechaFin.day.toString().padLeft(2, '0')}",
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

class Persona {
    int id;
    String identificacion;
    String nombre1;
    String nombre2;
    String apellido1;
    dynamic apellido2;
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
    String idCiudadNac;
    String idCiudadUbicacion;
    String tipoPersona;
    dynamic createdAt;
    DateTime updatedAt;
    Contrato? contrato;
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
        required this.tipoPersona,
        required this.createdAt,
        required this.updatedAt,
        this.contrato,
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
        tipoPersona: json["tipoPersona"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        contrato: json["contrato"] != null ? Contrato.fromJson(json["contrato"]) : null, 
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
        "tipoPersona": tipoPersona,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
        "contrato": contrato?.toJson(), 
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
    String idPais;

    Departamento({
        required this.id,
        required this.codigo,
        required this.descripcion,
        required this.idPais,
    });

    factory Departamento.fromJson(Map<String, dynamic> json) => Departamento(
        id: json["id"],
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        idPais: json["idPais"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "descripcion": descripcion,
        "idPais": idPais,
    };
}

class Contrato {
    int id;
    String idpersona;
    String idCompany;
    String idEstado;
    String idtipoContrato;
    String idSalario;
    dynamic idContrato;
    DateTime fechaContratacion;
    DateTime fechaFinalContrato;
    String valorTotalContrato;
    dynamic sueldo;
    dynamic numeroContrato;
    String objetoContrato;
    String observacion;
    String perfilProfesional;
    String otrosi;
    String periodoPago;
    DateTime createdAt;
    DateTime updatedAt;

    Contrato({
        required this.id,
        required this.idpersona,
        required this.idCompany,
        required this.idEstado,
        required this.idtipoContrato,
        required this.idSalario,
        required this.idContrato,
        required this.fechaContratacion,
        required this.fechaFinalContrato,
        required this.valorTotalContrato,
        required this.sueldo,
        required this.numeroContrato,
        required this.objetoContrato,
        required this.observacion,
        required this.perfilProfesional,
        required this.otrosi,
        required this.periodoPago,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Contrato.fromJson(Map<String, dynamic> json) => Contrato(
        id: json["id"],
        idpersona: json["idpersona"],
        idCompany: json["idCompany"],
        idEstado: json["idEstado"],
        idtipoContrato: json["idtipoContrato"],
        idSalario: json["idSalario"],
        idContrato: json["idContrato"],
        fechaContratacion: DateTime.parse(json["fechaContratacion"]),
        fechaFinalContrato: DateTime.parse(json["fechaFinalContrato"]),
        valorTotalContrato: json["valorTotalContrato"],
        sueldo: json["sueldo"],
        numeroContrato: json["numeroContrato"],
        objetoContrato: json["objetoContrato"],
        observacion: json["observacion"],
        perfilProfesional: json["perfilProfesional"],
        otrosi: json["otrosi"],
        periodoPago: json["periodoPago"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idpersona": idpersona,
        "idCompany": idCompany,
        "idEstado": idEstado,
        "idtipoContrato": idtipoContrato,
        "idSalario": idSalario,
        "idContrato": idContrato,
        "fechaContratacion": "${fechaContratacion.year.toString().padLeft(4, '0')}-${fechaContratacion.month.toString().padLeft(2, '0')}-${fechaContratacion.day.toString().padLeft(2, '0')}",
        "fechaFinalContrato": "${fechaFinalContrato.year.toString().padLeft(4, '0')}-${fechaFinalContrato.month.toString().padLeft(2, '0')}-${fechaFinalContrato.day.toString().padLeft(2, '0')}",
        "valorTotalContrato": valorTotalContrato,
        "sueldo": sueldo,
        "numeroContrato": numeroContrato,
        "objetoContrato": objetoContrato,
        "observacion": observacion,
        "perfilProfesional": perfilProfesional,
        "otrosi": otrosi,
        "periodoPago": periodoPago,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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