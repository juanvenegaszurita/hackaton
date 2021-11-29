import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackaton/models/models.dart';

class Tournament {
  List<List<TeamsModel>> createTeams(int grupo) {
    List<List<TeamsModel>> lista = [];

    while (grupo >= 1) {
      lista.add(List.generate(
        grupo,
        (i) => TeamsModel(
          id: i,
          nombre: '',
          participantes: [],
          puntos: 0,
          estado: 0,
        ),
      ));

      grupo = grupo ~/ 2;
    }
    return lista;
  }

  TournamentModel createTourment(
      List<String> listParticipantes, int nroEquipos) {
    int indTmpPart = 0;
    List<CompetenceModel> competencia = [];
    int etapa = 1;

    int largoEquipo = listParticipantes.length ~/ nroEquipos;
    while (largoEquipo >= 1) {
      List<TeamsModel> teams = [];
      bool isFirt = indTmpPart < listParticipantes.length;
      for (int i = 0; i < largoEquipo; i++) {
        List<CompetitorModel> participantes = [];
        if (isFirt) {
          for (int x = 0; x < (listParticipantes.length / nroEquipos); x++) {
            participantes.add(
              CompetitorModel(
                id: x,
                nombre: listParticipantes[indTmpPart],
              ),
            );
            indTmpPart++;
          }
        }
        teams.add(
          TeamsModel(
            id: i,
            nombre: isFirt ? "Team ${i + 1}" : "",
            participantes: participantes,
            puntos: 0,
            estado: isFirt ? TeamsModel.activo : TeamsModel.pendiente,
          ),
        );
      }

      competencia.add(
        new CompetenceModel(
          id: largoEquipo,
          etapa: "Etapa ${largoEquipo == 1 ? "Final" : etapa}",
          teams: teams,
        ),
      );
      if (isFirt) {
        etapa++;
        List<TeamsModel> newTeams = teams
            .map((element) => TeamsModel(
                  id: element.id,
                  nombre: "",
                  participantes: [],
                  puntos: 0,
                  estado: TeamsModel.pendiente,
                ))
            .toList();
        competencia.add(
          new CompetenceModel(
            id: largoEquipo,
            etapa: "Etapa $etapa",
            teams: newTeams,
          ),
        );
      }
      largoEquipo = largoEquipo ~/ 2;
      etapa++;
    }

    return TournamentModel(
      id: "",
      nombre: "Torneo 1",
      fecha: Timestamp.now(),
      detalle: "",
      nombreJuego: "",
      nroEquipos: nroEquipos,
      ubicacion: "",
      participantes: listParticipantes
          .map((e) => CompetitorModel(id: 0, nombre: e))
          .toList(),
      competencia: competencia,
    );
  }
}
