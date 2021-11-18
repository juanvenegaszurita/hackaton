//User Model
import 'package:cloud_firestore/cloud_firestore.dart';

class TournamentModel {
  final String id;
  final String nombre;
  final Timestamp fecha;
  final String detalle;
  final String nombreJuego;
  final int nroEquipos;
  final String ubicacion;
  final List<dynamic> participantes;
  final List<dynamic> competencia;
  /* final List<dynamic> competencia; */

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
    return TournamentModel(
      id: data['id'] ?? '',
      nombre: data['nombre'] ?? '',
      fecha: data['fecha'] ?? Timestamp.now(),
      detalle: data['detalle'] ?? '',
      nombreJuego: data['nombreJuego'] ?? '',
      nroEquipos: data['nroEquipos'] ?? 0,
      ubicacion: data['ubicacion'] ?? '',
      participantes: data['participantes'] != null ? data['participantes'] : [],
      competencia: data['competencia'] ?? [],
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
}
