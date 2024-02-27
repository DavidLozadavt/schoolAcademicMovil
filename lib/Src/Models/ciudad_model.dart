// To parse this JSON data, do
//
//     final Ciudades = CiudadesFromJson(jsonString);

import 'dart:convert';

List<Ciudades> CiudadesFromJson(String str) => List<Ciudades>.from(json.decode(str).map((x) => Ciudades.fromJson(x)));

String CiudadesToJson(List<Ciudades> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ciudades {
    int id;
    String codigo;
    String descripcion;
    int idDepartamento;
    dynamic createdAt;
    dynamic updatedAt;

    Ciudades({
        required this.id,
        required this.codigo,
        required this.descripcion,
        required this.idDepartamento,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Ciudades.fromJson(Map<String, dynamic> json) => Ciudades(
        id: json["id"],
        codigo: json["codigo"],
        descripcion: json["descripcion"],
        idDepartamento: json["idDepartamento"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "descripcion": descripcion,
        "idDepartamento": idDepartamento,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
