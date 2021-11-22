import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackaton/models/competence_model.dart';
import 'package:hackaton/models/competitor_models.dart';

class TournamentModel {
  final String id;
  final String nombre;
  final Timestamp fecha;
  final String detalle;
  final String nombreJuego;
  final int nroEquipos;
  final String ubicacion;
  final List<CompetitorModel> participantes;
  final List<CompetenceModel> competencia;

  TournamentModel({
    required this.id,
    required this.nombre,
    required this.fecha,
    required this.detalle,
    required this.nombreJuego,
    required this.nroEquipos,
    required this.ubicacion,
    required this.participantes,
    required this.competencia,
  });

  factory TournamentModel.fromMap(Map data) {
    List<CompetenceModel> competencia = [];
    if (data['competencia'] != null) {
      (data['competencia'] as List).asMap().forEach((key, value) {
        value = value as Map<dynamic, dynamic>;
        value['id'] = key;
        competencia.add(CompetenceModel.fromMap(value));
      });
    }
    List<CompetitorModel> participantes = [];
    if (data['participantes'] != null) {
      (data['participantes'] as List).asMap().forEach((key, value) {
        participantes.add(CompetitorModel(id: key, nombre: value));
      });
    }
    return TournamentModel(
      id: data['id'] ?? '',
      nombre: data['nombre'] ?? '',
      fecha: data['fecha'] ?? Timestamp.now(),
      detalle: data['detalle'] ?? '',
      nombreJuego: data['nombreJuego'] ?? '',
      nroEquipos: data['nroEquipos'] ?? 0,
      ubicacion: data['ubicacion'] ?? '',
      participantes: participantes,
      competencia: competencia,
    );
  }

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "fecha": fecha,
        "detalle": detalle,
        "nombreJuego": nombreJuego,
        "nroEquipos": nroEquipos,
        "ubicacion": ubicacion,
        "participantes": participantes,
        "competencia": competencia,
      };
  @override
  String toString() {
    return json.encode({
      "id": id,
      "nombre": nombre,
      "fecha": fecha.toString(),
      "detalle": detalle,
      "nombreJuego": nombreJuego,
      "nroEquipos": nroEquipos,
      "ubicacion": ubicacion,
      "participantes": participantes,
      "competencia": competencia,
    });
  }
}
