import 'dart:convert';
import 'package:hackaton/models/competitor_models.dart';

class TeamsModel {
  final int id;
  final String nombre;
  final List<CompetitorModel> participantes;

  TeamsModel({
    required this.id,
    required this.nombre,
    required this.participantes,
  });

  factory TeamsModel.fromMap(Map data) {
    List<CompetitorModel> participantes = [];
    if (data['participantes'] != null) {
      (data['participantes'] as List).asMap().forEach((key, value) {
        participantes.add(CompetitorModel(id: key, nombre: value));
      });
    }
    return TeamsModel(
      id: data['id'] ?? 0,
      nombre: data['nombre'] ?? '',
      participantes: participantes,
    );
  }

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "participantes": participantes,
      };
  @override
  String toString() {
    return json.encode({
      "id": id,
      "nombre": nombre,
      "participantes": participantes,
    });
  }
}
