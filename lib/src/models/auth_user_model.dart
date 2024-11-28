//LocalHost
import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  String accessToken;
  Payload payload;
  User user;
  int expiresIn;
  List<Children>? children;

  UserData({
    required this.accessToken,
    required this.payload,
    required this.user,
    required this.expiresIn,
    this.children,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        accessToken: json["access_token"],
        payload: Payload.fromJson(json["payload"]),
        user: User.fromJson(json["user"]),
        expiresIn: json["expires_in"],
         children: json["children"] != null
            ? List<Children>.from(json["children"].map((x) => Children.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "payload": payload.toJson(),
        "user": user.toJson(),
        "expires_in": expiresIn,
          "children": children != null
            ? List<dynamic>.from(children!.map((x) => x.toJson())) 
            : null,
      };
}

class Payload {
  List<String> roles;

  Payload({
    required this.roles,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        roles: List<String>.from(json["roles"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "roles": List<dynamic>.from(roles.map((x) => x)),
      };
}

class User {
  int id;
  String deviceToken;
  String estadoMensajeria;
  Persona persona;
  List<ActivationCompanyUser> activationCompanyUsers;

  User({
    required this.id,
    required this.deviceToken,
    required this.estadoMensajeria,
    required this.persona,
    required this.activationCompanyUsers,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        deviceToken: json["device_token"],
        estadoMensajeria: json["estadoMensajeria"],
        persona: Persona.fromJson(json["persona"]),
        activationCompanyUsers: List<ActivationCompanyUser>.from(json["activation_company_users"].map((x) => ActivationCompanyUser.fromJson(x))),
        
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "device_token": deviceToken,
        "estadoMensajeria": estadoMensajeria,
        "persona": persona.toJson(),
        "activation_company_users": List<dynamic>.from(activationCompanyUsers.map((x) => x.toJson())),
        
      };
}

class ActivationCompanyUser {
    
    int idEstado;
    

    ActivationCompanyUser({
        
        required this.idEstado,
     
    });

    factory ActivationCompanyUser.fromJson(Map<String, dynamic> json) => ActivationCompanyUser(
      
        idEstado: json["idEstado"],
       
    );

    Map<String, dynamic> toJson() => {
        
        "idEstado": idEstado,
       
    };
}

class Persona {
  int id;
  Contrato? contrato;

  Persona({
    required this.id,
    this.contrato,
  });

  factory Persona.fromJson(Map<String, dynamic> json) => Persona(
        id: json["id"],
        contrato: json["contrato"] != null
            ? Contrato.fromJson(json["contrato"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contrato": contrato?.toJson(),
      };
}

class Children {
  int id;
  int idEstudiante;
  int idAcudiente;
  Estudiante estudiante;

  Children({
    required this.id,
    required this.idEstudiante,
    required this.idAcudiente,
    required this.estudiante,
  });

  factory Children.fromJson(Map<String, dynamic> json) => Children(
        id: json["id"],
        idEstudiante: json["idEstudiante"],
        idAcudiente: json["idAcudiente"],
        estudiante: Estudiante.fromJson(json["estudiante"]),
      );

      Map<String, dynamic> toJson() => {
        "id": id,
        "idEstudiante": idEstudiante,
        "idAcudiente": idAcudiente,
        "estudiante": estudiante.toJson()
      };
}

class Estudiante {
  int id;
  String nombre1;
  String nombre2;
  String apellido1;
  String apellido2;
  String rutaFoto;


  Estudiante({
    required this.id,
    required this.nombre1,
    required this.nombre2,
    required this.apellido1,
    required this.apellido2,
    required this.rutaFoto,

  });

  factory Estudiante.fromJson(Map<String, dynamic> json) => Estudiante(
        id: json["id"],
        nombre1: json["nombre1"],
        nombre2: json["nombre2"],
        apellido1: json["apellido1"],
        apellido2: json["apellido2"],
        rutaFoto: json["rutaFoto"],
      );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre1": nombre1,
        "nombre2": nombre2,
        "apellido1": apellido1,
        "apellido2": apellido2,
        "rutaFoto": rutaFoto

      };
}

class Contrato {
  int id;

  Contrato({
    required this.id,
  });

  factory Contrato.fromJson(Map<String, dynamic> json) => Contrato(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}