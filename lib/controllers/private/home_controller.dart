import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackaton/models/tournament_model.dart';
import 'package:hackaton/services/tournament_service.dart';

class HomeController extends GetxController {
  TextEditingController nombreParticipanteController = TextEditingController();
  final TournamentService tournamentService = TournamentService();

  final participantes = [].obs;
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
    TournamentService tor = TournamentService();
    List<dynamic> competencia = currentParticipantes;

    tor.newTournament(TournamentModel(
        id: '',
        nombre: 'Torneo',
        fecha: Timestamp.now(),
        detalle: '',
        nombreJuego: '',
        nroEquipos: 0,
        ubicacion: '',
        participantes: currentParticipantes,
        competencia: competencia));
  }
}
