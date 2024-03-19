class ResponseUserData {
    UserDataClass userData;

    ResponseUserData({
        required this.userData,
    });

}

class UserDataClass {
    int id;
    String email;
    String idPersona;
    dynamic deviceToken;
    DateTime emailVerifiedAt;
    Persona persona;

    UserDataClass({
        required this.id,
        required this.email,
        required this.idPersona,
        required this.deviceToken,
        required this.emailVerifiedAt,
        required this.persona,
    });

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
    Ciudad ciudadUbicacion;
    Ciudad ciudadNac;

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
        required this.ciudadUbicacion,
        required this.ciudadNac,
    });

}

class Ciudad {
    int id;
    String codigo;
    String descripcion;
    String idDepartamento;
    dynamic createdAt;
    dynamic updatedAt;

    Ciudad({
        required this.id,
        required this.codigo,
        required this.descripcion,
        required this.idDepartamento,
        required this.createdAt,
        required this.updatedAt,
    });

}
