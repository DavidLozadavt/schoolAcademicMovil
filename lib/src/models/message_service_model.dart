import 'dart:convert';

List<MesaggeService> mesaggeServiceFromJson(String str) => List<MesaggeService>.from(json.decode(str).map((x) => MesaggeService.fromJson(x)));

String mesaggeServiceToJson(List<MesaggeService> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MesaggeService {
    int id;
    dynamic title;
    String? body;
    int? idActivationCompanyUser;
    DateTime createdAt;
    DateTime updatedAt;
    String origen;

    MesaggeService({
        required this.id,
        required this.title,
        required this.body,
        required this.idActivationCompanyUser,
        required this.createdAt,
        required this.updatedAt,
        required this.origen,
    });

    factory MesaggeService.fromJson(Map<String, dynamic> json) => MesaggeService(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        idActivationCompanyUser: json["idActivationCompanyUser"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        origen: json["origen"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "idActivationCompanyUser": idActivationCompanyUser,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "origen": origen,
    };
}
