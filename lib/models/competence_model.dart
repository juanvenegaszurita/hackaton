import 'dart:convert';
import 'package:hackaton/models/teams_model.dart';

class CompetenceModel {
  final int id;
  final String etapa;
  final List<TeamsModel> teams;

  CompetenceModel({
    required this.id,
    required this.etapa,
    required this.teams,
  });

  factory CompetenceModel.fromMap(Map data) {
    List<TeamsModel> teams = [];
    if (data['teams'] != null) {
      (data['teams'] as List).asMap().forEach((key, value) {
        value = value as Map<dynamic, dynamic>;
        value['id'] = key;
        teams.add(TeamsModel.fromMap(value));
      });
    }
    return CompetenceModel(
      id: data['id'] ?? 0,
      etapa: data['etapa'] ?? '',
      teams: teams,
    );
  }

  Map<String, dynamic> toJson() => {
        "etapa": etapa,
        "teams": teams.map((e) => e.toJson()),
      };
  @override
  String toString() {
    return json.encode({
      "id": id,
      "etapa": etapa,
      "teams": teams.toString(),
    });
  }
}
