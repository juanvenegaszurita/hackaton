import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackaton/helpers/tournament.dart';
import 'package:hackaton/models/models.dart';
import 'package:get/get.dart';
import 'package:hackaton/models/competitor_models.dart';
import 'package:hackaton/models/tournament_model.dart';
import 'package:hackaton/services/tournament_service.dart';

class HomeController extends GetxController {
  static HomeController to = Get.find();
  TextEditingController nombreParticipanteController = TextEditingController();
  final TournamentService tournamentService = TournamentService();
  final nroEquipos = 0.0.obs;
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

  removePlayer(participante) {
    print(participante);
    currentParticipantes.remove(participante);
    update(["home"]);
  }

  createNewTournament() {
    if ((currentParticipantes.length > 2) &&
        (currentParticipantes.length > currentnroEquipos.toInt())) {
      TournamentService tor = TournamentService();
      Tournament helperTournament = Tournament();
      List<String> listParticipantes = [];
      currentParticipantes.forEach((element) {
        listParticipantes.add(element);
      });
      tor.newTournament(helperTournament.createTourment(
          listParticipantes, currentnroEquipos.toInt()));
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
