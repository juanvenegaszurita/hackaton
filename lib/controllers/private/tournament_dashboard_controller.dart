import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackaton/controllers/auth_controller.dart';
import 'package:hackaton/helpers/tournament.dart';
import 'package:hackaton/models/models.dart';
import 'package:hackaton/models/tournament_model.dart';
import 'package:hackaton/services/tournament_service.dart';

class TournamentDashboardController extends GetxController {
  static TournamentDashboardController to = Get.find();
  final AuthController authController = AuthController.to;
  final TournamentService tournamentService = TournamentService();

  // Tournament
  TextEditingController nombreController = TextEditingController();
  TextEditingController nombreJuegoController = TextEditingController();
  TextEditingController detalleController = TextEditingController();
  TextEditingController nroEquiposController = TextEditingController();
  TextEditingController ubicacionController = TextEditingController();

  // team
  TextEditingController nombreTeamController = TextEditingController();
  TextEditingController puntosTeamController = TextEditingController();

  final id = "".obs;
  final uid = "".obs;
  final hora = "00:00".obs;
  final fecha = DateTime.now().toString().split(" ")[0].obs;
  final tournament = TournamentModel.fromMap(Map<String, dynamic>()).obs;
  final errorDialog = "".obs;

  TournamentModel get currentTournament => tournament.value;
  String get currentId => id.value;
  String get currentUid => uid.value;
  String get currentHora => hora.value;
  String get currentFecha => fecha.value;
  String get currentErrorDialog => errorDialog.value;

  @override
  void onReady() async {
    id.value = Get.arguments['id'];
    uid.value = authController.firebaseUser.value?.uid == null
        ? Get.arguments['uid']
        : authController.firebaseUser.value!.uid;
    if (currentId.isNotEmpty && currentUid.isNotEmpty) {
      tournamentService.streamFirestoreTournament(currentId, currentUid).listen(
        (event) {
          tournament.value = event;
          setDataController();
        },
      );
    }
    super.onReady();
  }

  setDataController() {
    nombreController.text = currentTournament.nombre;
    nombreJuegoController.text = currentTournament.nombreJuego;
    detalleController.text = currentTournament.detalle;
    nroEquiposController.text = currentTournament.nroEquipos.toString();
    ubicacionController.text = currentTournament.ubicacion;
    DateTime fechaDT = DateTime.fromMicrosecondsSinceEpoch(
      currentTournament.fecha.microsecondsSinceEpoch,
    );

    hora.value = "${fechaDT.hour}:${fechaDT.minute}";
    fecha.value = fechaDT.toString().split(" ")[0];
    update(["tournamentDashboard"]);
    this.updateDialogParticipante();
  }

  setHora(String value) {
    hora.value = value;
    update();
  }

  setFecha(String value) {
    fecha.value = value;
    update();
  }

  setErrorDialog(String value) {
    errorDialog.value = value;
    updateDialogParticipante();
  }

  updateDialogParticipante() {
    update(["dialogParticipante"]);
    Get.forceAppUpdate();
  }

  TournamentModel getTournamentModel() {
    return getTournamentWithoutCompetition(currentTournament.competencia);
  }

  TournamentModel getTournamentWithoutCompetition(
    List<CompetenceModel> competencia,
  ) {
    return TournamentModel(
      id: "",
      nombre: nombreController.text,
      fecha: Tournament.convertTimestamp(fecha.value, hora.value),
      detalle: detalleController.text,
      nombreJuego: nombreJuegoController.text,
      nroEquipos: int.parse(nroEquiposController.text),
      ubicacion: ubicacionController.text,
      participantes: currentTournament.participantes,
      competencia: competencia,
    );
  }

  TournamentModel? winTournament(
    TournamentDashboardController controller,
    TeamsModel team,
    int indCom,
    int indTeam,
  ) {
    controller.setErrorDialog('');
    if (controller.nombreTeamController.text.isEmpty) {
      controller.setErrorDialog('Ingresar Nombre Teams');
    } else if (team.participanteGanador.isNotEmpty) {
      if (controller.currentTournament.competencia.length > 0 &&
          controller.currentTournament.competencia[indCom].teams.length >
              controller
                  .currentTournament.competencia[indCom + 1].teams.length) {
        int intPerdedor = (indTeam % 2 == 0) ? indTeam + 1 : indTeam - 1;

        // debe estar activo el perdedor
        if (controller.currentTournament.competencia[indCom].teams[intPerdedor]
                .estado ==
            TeamsModel.activo) {
          // ganador
          controller.currentTournament.competencia[indCom].teams[indTeam] =
              TeamsModel(
            id: team.id,
            nombre: controller.nombreTeamController.text,
            participantes: team.participantes,
            puntos: int.parse(controller.puntosTeamController.text),
            estado: TeamsModel.ganador,
            participanteGanador: team.participanteGanador,
          );
          // perdedor
          TeamsModel teamPerdedor = controller
              .currentTournament.competencia[indCom].teams[intPerdedor];
          controller.currentTournament.competencia[indCom].teams[intPerdedor] =
              TeamsModel(
            id: teamPerdedor.id,
            nombre: teamPerdedor.nombre,
            participantes: teamPerdedor.participantes,
            puntos: teamPerdedor.puntos,
            estado: TeamsModel.perdedor,
            participanteGanador: team.participanteGanador,
          );
          // traspaso ganador
          int indNext = indTeam < 2
              ? 0
              : (indTeam % 2 == 0)
                  ? indTeam ~/ 2
                  : (indTeam - 1) ~/ 2;
          int estadoWin =
              controller.currentTournament.competencia.length == (indCom + 2)
                  ? TeamsModel.ganadorCompetencia
                  : TeamsModel.activo;
          controller.currentTournament.competencia[indCom + 1].teams[indNext] =
              TeamsModel(
            id: team.id,
            nombre: controller.nombreTeamController.text,
            participantes: team.participantes,
            puntos: int.parse(controller.puntosTeamController.text),
            estado: estadoWin,
            participanteGanador: team.participanteGanador,
          );
          return controller.getTournamentWithoutCompetition(
              controller.currentTournament.competencia);
        } else {
          controller.setErrorDialog('tournamentDashboard.noCompetitor'.tr);
        }
      } else {
        // ganador
        controller.currentTournament.competencia[indCom].teams[indTeam] =
            TeamsModel(
          id: team.id,
          nombre: controller.nombreTeamController.text,
          participantes: team.participantes,
          puntos: int.parse(controller.puntosTeamController.text),
          estado: TeamsModel.ganador,
          participanteGanador: team.participanteGanador,
        );
        // traspaso ganador
        controller.currentTournament.competencia[indCom + 1].teams[indTeam] =
            TeamsModel(
          id: team.id,
          nombre: controller.nombreTeamController.text,
          participantes: [
            CompetitorModel(id: 1, nombre: team.participanteGanador)
          ],
          puntos: int.parse(controller.puntosTeamController.text),
          estado: TeamsModel.activo,
          participanteGanador: team.participanteGanador,
        );
        return controller.getTournamentWithoutCompetition(
            controller.currentTournament.competencia);
      }
    } else {
      controller.setErrorDialog('tournamentDashboard.selectParticipant'.tr);
    }
  }
}
