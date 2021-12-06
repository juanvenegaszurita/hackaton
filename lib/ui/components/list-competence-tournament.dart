import 'package:flutter/material.dart';
import 'package:hackaton/constants/constants.dart';
import 'package:hackaton/controllers/private/tournament_dashboard_controller.dart';
import 'package:hackaton/models/models.dart';
import 'package:hackaton/ui/ui.dart';

class ListCompetenceTournament extends StatelessWidget {
  ListCompetenceTournament({required this.competencias});
  final List<CompetenceModel> competencias;
  final TournamentDashboardController controller =
      TournamentDashboardController.to;

  @override
  Widget build(BuildContext context) {
    List<Widget> lista = [];

    competencias.asMap().forEach((indCom, competencia) {
      List<Widget> listaTMP = [];
      double alto = 0;
      competencia.teams.asMap().forEach((indTeam, team) {
        double altoTMP = (team.participantes.length * 20);
        alto += altoTMP + 120;
        listaTMP.add(
          CardGeneric(
            border: true,
            color: AppThemes.nevada,
            onTap: () {
              if (controller.authController.firebaseUser.value?.uid != null) {
                ModalTeam.openDialog(
                  controller,
                  context,
                  competencias,
                  competencia.etapa,
                  team,
                  indCom,
                  indTeam,
                );
              }
            },
            height: altoTMP + 120,
            body: ModalTeam.detailsTeam(competencia.etapa, team),
          ),
        );
      });
      lista.add(
        CardGeneric(
          height: listaTMP.length > 1
              ? (alto + 50) + listaTMP.length * 7
              : 60 + alto,
          color: AppThemes.dodgerBanco,
          body: ListView(
            children: [
              Center(
                child: Text(
                  competencia.etapa,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.button!.color!,
                  ),
                ),
              ),
              ...listaTMP
            ],
          ),
        ),
      );
    });

    return ListView(
      children: lista,
    );
  }
}
