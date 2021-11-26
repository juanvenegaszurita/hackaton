import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:hackaton/controllers/private/tournament_dashboard_controller.dart';
import 'package:hackaton/helpers/validator.dart';
import 'package:hackaton/models/models.dart';
import 'package:hackaton/models/teams_model.dart';
import 'package:hackaton/ui/ui.dart';

class ModalTeam {
  static Future<dynamic> dialog({
    required BuildContext context,
    required String title,
    required Widget content,
    Future Function()? onPressed,
    Future Function()? onPressedWin,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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
                  await onPressedWin.call();
                  Navigator.of(context).pop();
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
        Text(
          "${'tournamentDashboard.state'.tr}: " + team.getEstados[team.estado],
          style: TextStyle(
            color: Colors.white,
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
      ModalTeam.dialog(
        context: context,
        title: etapa,
        content: Column(
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
              onSaved: (value) => controller.nombreTeamController.text = value!,
            ),
            FormInputFieldWithIcon(
              controller: controller.puntosTeamController,
              iconPrefix: Icons.app_registration,
              labelText: 'tournamentDashboard.points'.tr,
              validator: Validator().number,
              keyboardType: TextInputType.number,
              onChanged: (value) => null,
              onSaved: (value) => controller.puntosTeamController.text = value!,
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
            ...team.participantes
                .map(
                  (e) => Text(
                    "- ${e.nombre}",
                    /* style: TextStyle(
                          color: Colors.white,
                        ), */
                  ),
                )
                .toList(),
            FormVerticalSpace(),
          ],
        ),
        onPressed: () async {
          competencias[indCom].teams[indTeam] = TeamsModel(
            id: team.id,
            nombre: controller.nombreTeamController.text,
            participantes: team.participantes,
            puntos: int.parse(controller.puntosTeamController.text),
            estado: team.estado,
          );
          await controller.tournamentService.updateTournament(
            controller.currentId,
            controller.getTournamentWithoutCompetition(competencias),
          );
        },
        onPressedWin: () async {
          controller.tournamentService.updateTournament(
            controller.currentId,
            controller.winTournament(
              team,
              indCom,
              indTeam,
            ),
          );
        },
      );
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
