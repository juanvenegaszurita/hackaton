import 'dart:convert';
import 'package:hackaton/models/competitor_models.dart';

class TeamsModel {
  final int id;
  final String nombre;
  final List<CompetitorModel> participantes;
  final int puntos;

  TeamsModel({
    required this.id,
    required this.nombre,
    required this.participantes,
    required this.puntos,
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
      puntos: data['puntos'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "participantes": participantes,
        "puntos": puntos,
      };
  @override
  String toString() {
    return json.encode({
      "id": id,
      "nombre": nombre,
      "participantes": participantes,
      "puntos": puntos,
    });
  }
}
