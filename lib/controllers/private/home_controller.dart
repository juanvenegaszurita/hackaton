import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackaton/models/models.dart';
import 'package:get/get.dart';
import 'package:hackaton/models/competitor_models.dart';
import 'package:hackaton/models/tournament_model.dart';
import 'package:hackaton/services/tournament_service.dart';

class HomeController extends GetxController {
  TextEditingController nombreParticipanteController = TextEditingController();
  final TournamentService tournamentService = TournamentService();
  final nroEquipos = 1.0.obs;
  final division = 50.obs;
  double get currentnroEquipos => nroEquipos.value;
  int get currentDivision => division.value;

  final participantes = RxList([]).obs;
  List<dynamic> get currentParticipantes => participantes.value;

  addPlayer() {
    participantes.value.add(nombreParticipanteController.text);
    nombreParticipanteController.text = "";
    update(["home"]);
  }

  removePlayer() {
    //participantes.value.remove();
    //update(["home"]);
  }

  createNewTournament() {
    if ((currentParticipantes.length > 2) &&
        (currentParticipantes.length > currentnroEquipos.toInt())) {
      TournamentService tor = TournamentService();
      List<CompetitorModel> participantes = [];
      List<List<TeamsModel>> listTeams = [];
      List<CompetitorModel> competitorModel = [];
      List<CompetenceModel> competencia = [];
      int incremento = 0;
      double cantidadParticipantesPorEquipo =
          currentParticipantes.length / currentnroEquipos.toInt();

      currentParticipantes.asMap().forEach((key, value) {
        participantes.add(CompetitorModel(id: key, nombre: value));
      });

      listTeams = List.generate(cantidadParticipantesPorEquipo.toInt(), (ind) {
        List<TeamsModel> teamsModel = [];
        for (int i = 0;
            i < (participantes.length / cantidadParticipantesPorEquipo.toInt());
            i++) {
          competitorModel.add(participantes[incremento]);
          teamsModel.add(TeamsModel(
              id: i,
              nombre: "Equipo $incremento",
              participantes: competitorModel));
          incremento++;
        }
        return teamsModel;
      });

      print(listTeams);

      tor.newTournament(TournamentModel(
          id: '',
          nombre: 'Torneo',
          fecha: Timestamp.now(),
          detalle: '',
          nombreJuego: '',
          nroEquipos: currentnroEquipos.toInt(),
          ubicacion: '',
          participantes: participantes,
          competencia: competencia));
    }
  }

  setNroEquipos(dynamic value) {
    nroEquipos.value = value;
    if (currentnroEquipos > 4) {
      division.value = 25;
    } else if (currentnroEquipos <= 4) {
      division.value = 50;
    }
    update(["home"]);
  }
}
