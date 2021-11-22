import 'dart:convert';

class CompetitorModel {
  final int id;
  final String nombre;

  CompetitorModel({
    required this.id,
    required this.nombre,
  });

  factory CompetitorModel.fromMap(Map data) {
    return CompetitorModel(
      id: data['id'] ?? 0,
      nombre: data['nombre'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
      };
  @override
  String toString() {
    return json.encode({
      "id": id,
      "nombre": nombre,
    });
  }
}
