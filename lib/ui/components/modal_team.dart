import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:hackaton/constants/constants.dart';
import 'package:hackaton/controllers/private/tournament_dashboard_controller.dart';
import 'package:hackaton/helpers/validator.dart';
import 'package:hackaton/models/models.dart';
import 'package:hackaton/models/teams_model.dart';
import 'package:hackaton/ui/ui.dart';

class ModalTeam {
  static void dialog({
    required BuildContext context,
    required String title,
    required Widget content,
    Future Function()? onPressed,
    Future Function()? onPressedWin,
  }) async {
    await Future.delayed(Duration(milliseconds: 500));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(10),
          actionsPadding: EdgeInsets.all(10),
          actionsAlignment: MainAxisAlignment.center,
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: content,
          actions: [
            if (onPressedWin != null)
              PrimaryButton(
                labelText: 'tournamentDashboard.winner'.tr,
                onPressed: () async {
                  var res = await onPressedWin.call();
                  if (res) Navigator.of(context).pop();
                },
              ),
            TextButton(
              child: Text('general.close'.tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            if (onPressed != null)
              TextButton(
                child: Text('general.accept'.tr),
                onPressed: () async {
                  await onPressed.call();
                  Navigator.of(context).pop();
                },
              ),
          ],
        );
      },
    );
  }

  static Widget detailsTeam(String etapa, TeamsModel team) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            '$etapa\n${team.nombre}',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        if (team.estado != TeamsModel.pendiente)
          Text(
            "${'tournamentDashboard.points'.tr} ${team.puntos}",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: statusColor(team.estado),
          ),
          padding: EdgeInsets.all(4),
          margin: EdgeInsets.only(bottom: 4, top: 4),
          child: Text(
            team.getEstados[team.estado],
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        FormVerticalSpace(),
        ...team.participantes
            .map(
              (e) => Text(
                "- ${e.nombre}",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
            .toList()
      ],
    );
  }

  static Color statusColor(int estado) {
    if (estado == TeamsModel.activo)
      return Colors.green;
    else if (estado == TeamsModel.ganador)
      return Colors.orange;
    else if (estado == TeamsModel.ganadorCompetencia)
      return Colors.cyan.shade800;
    else if (estado == TeamsModel.pendiente)
      return Colors.deepPurpleAccent;
    else
      return Colors.red;
  }

  static openDialog(
    TournamentDashboardController controller,
    BuildContext context,
    List<CompetenceModel> competencias,
    String etapa,
    TeamsModel team,
    int indCom,
    int indTeam,
  ) {
    if (competencias.length == (indCom + 1)) {
      ModalTeam.dialog(
        context: context,
        title: etapa,
        content: Text("${'tournamentDashboard.winner'.tr}!"),
      );
    } else if (team.estado == TeamsModel.activo) {
      controller.nombreTeamController.text = team.nombre;
      controller.puntosTeamController.text = team.puntos.toString();
      controller.setErrorDialog('');
      controller.updateDialogParticipante();
      ModalTeam.dialog(
        context: context,
        title: etapa,
        content: GetBuilder<TournamentDashboardController>(
          init: controller,
          id: "dialogParticipante",
          builder: (controller2) => SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("${'tournamentDashboard.state'.tr}: " +
                    team.getEstados[team.estado]),
                FormVerticalSpace(),
                FormInputFieldWithIcon(
                  controller: controller.nombreTeamController,
                  iconPrefix: Icons.app_registration,
                  labelText: 'tournamentDashboard.name'.tr,
                  validator: Validator().notEmpty,
                  keyboardType: TextInputType.text,
                  onChanged: (value) => null,
                  onSaved: (value) =>
                      controller.nombreTeamController.text = value!,
                ),
                FormInputFieldWithIcon(
                  controller: controller.puntosTeamController,
                  iconPrefix: Icons.app_registration,
                  labelText: 'tournamentDashboard.points'.tr,
                  validator: Validator().number,
                  keyboardType: TextInputType.number,
                  onChanged: (value) => null,
                  onSaved: (value) =>
                      controller.puntosTeamController.text = value!,
                ),
                FormVerticalSpace(),
                Center(
                  child: Text(
                    'tournamentDashboard.participants'.tr,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FormVerticalSpace(),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppThemes.orange,
                    ),
                  ),
                  child: Column(
                    children: team.participantes
                        .map(
                          (e) => RadioListTile(
                            title: Text(e.nombre),
                            value: e.nombre,
                            groupValue: team.participanteGanador,
                            onChanged: (String? value) {
                              team.setParticipanteGanador(value!);
                              controller.updateDialogParticipante();
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
                FormVerticalSpace(),
                Text(
                  controller.currentErrorDialog,
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
        //################ boton aceptar
        onPressed: () async {
          competencias[indCom].teams[indTeam] = TeamsModel(
            id: team.id,
            nombre: controller.nombreTeamController.text,
            participantes: team.participantes,
            puntos: int.parse(controller.puntosTeamController.text),
            estado: team.estado,
            participanteGanador: team.participanteGanador,
          );
          await controller.tournamentService.updateTournament(
            controller.currentId,
            controller.getTournamentWithoutCompetition(competencias),
          );
          controller.updateDialogParticipante();
        },
        //################ boton ganador|
        onPressedWin: () async {
          TournamentModel? winTournament = controller.winTournament(
            controller,
            team,
            indCom,
            indTeam,
          );
          if (winTournament != null) {
            controller.tournamentService.updateTournament(
              controller.currentId,
              winTournament,
            );
            controller.updateDialogParticipante();
            return true;
          } else {
            controller.updateDialogParticipante();
            return false;
          }
        },
      );
      controller.updateDialogParticipante();
    } else {
      ModalTeam.dialog(
        context: context,
        title: etapa,
        content: Text(
          "${'tournamentDashboard.stateConditions'.tr} ${team.getEstados[1].tr}",
        ),
      );
    }
  }
}
