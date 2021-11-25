import 'dart:convert';
import 'package:hackaton/models/competitor_models.dart';

class TeamsModel {
  final int id;
  final String nombre;
  final List<CompetitorModel> participantes;
  final int puntos;
  final int estado;

  List<String> get getEstados => [
        "Pendiente",
        "Activo",
        "Ganador",
        "Perdedor",
        "Ganador Competencia",
      ];
  static int pendiente = 0;
  static int activo = 1;
  static int ganador = 2;
  static int perdedor = 3;
  static int ganadorCompetencia = 4;

  TeamsModel({
    required this.id,
    required this.nombre,
    required this.participantes,
    required this.puntos,
    required this.estado,
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
      estado: data['estado'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "participantes": participantes.map((e) => e.nombre),
        "puntos": puntos,
        "estado": estado,
      };

  @override
  String toString() {
    return json.encode({
      "id": id,
      "nombre": nombre,
      "participantes": participantes,
      "puntos": puntos,
      "estado": estado,
    });
  }
}
