import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackaton/controllers/auth_controller.dart';
import 'package:hackaton/models/tournament_model.dart';
import 'package:hackaton/services/tournament_service.dart';

class TournamentDashboardController extends GetxController {
  static TournamentDashboardController to = Get.find();
  final AuthController authController = AuthController.to;
  final TournamentService tournamentService = TournamentService();

  TextEditingController nombreController = TextEditingController();
  TextEditingController detalleController = TextEditingController();
  TextEditingController nroEquiposController = TextEditingController();
  TextEditingController ubicacionController = TextEditingController();

  final hora = "00:00".obs;
  final fecha = DateTime.now().toString().split(" ")[0].obs;
  final tournament = TournamentModel.fromMap(Map<String, dynamic>()).obs;

  TournamentModel get currentTournament => tournament.value;
  String get currentHora => hora.value;
  String get currentFecha => fecha.value;

  @override
  void onReady() async {
    tournamentService.streamFirestoreTournament('FBvzaHJHiy2GeQRZX4Hk').listen(
      (event) {
        tournament.value = event;
        setDataController();
      },
    );
    super.onReady();
  }

  setDataController() {
    nombreController.text = currentTournament.nombre;
    detalleController.text = currentTournament.detalle;
    nroEquiposController.text = currentTournament.nroEquipos.toString();
    ubicacionController.text = currentTournament.ubicacion;
    DateTime fechaDT = DateTime.fromMicrosecondsSinceEpoch(
        currentTournament.fecha.microsecondsSinceEpoch);

    hora.value = "${fechaDT.hour}:${fechaDT.minute}";
    fecha.value = fechaDT.toString().split(" ")[0];
    update();
  }

  setHora(String value) {
    hora.value = value;
    update();
  }

  setFecha(String value) {
    fecha.value = value;
    update();
  }

  TournamentModel getTournamentModel() {
    DateTime fechaFinal = DateTime.parse(fecha.value + " " + hora.value);

    return TournamentModel(
      id: "",
      nombre: nombreController.text,
      fecha: Timestamp.fromDate(fechaFinal),
      detalle: detalleController.text,
      nombreJuego: nombreController.text,
      nroEquipos: int.parse(nroEquiposController.text),
      ubicacion: ubicacionController.text,
      participantes: currentTournament.participantes,
      competencia: currentTournament.competencia,
    );
  }
}
