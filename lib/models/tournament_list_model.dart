import 'dart:convert';

import 'package:hackaton/models/tournament_model.dart';

class TournamentListModel {
  final String id;
  final List<TournamentModel> listaTorneo;

  TournamentListModel({
    required this.id,
    required this.listaTorneo,
  });

  factory TournamentListModel.fromMap(Map data) {
    List<TournamentModel> listaTorneo = [];
    if (data['listaTorneo'] != null) {
      (data['listaTorneo'] as List).forEach((value) {
        listaTorneo.add(TournamentModel.fromMap(value));
      });
    }
    return TournamentListModel(
      id: data['id'] ?? '',
      listaTorneo: listaTorneo,
    );
  }

  Map<String, dynamic> toJson() => {
        "listaTorneo": listaTorneo,
      };
  @override
  String toString() {
    return json.encode({
      "id": id,
      "listaTorneo": listaTorneo.toString(),
    });
  }
}
