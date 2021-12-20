import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackaton/models/models.dart';

class Tournament {
  static List<List<TeamsModel>> createTeams(int grupo) {
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

  static TournamentModel createTourment(
      List<String> listParticipantes, int nroEquipos, String nombreTorneo) {
    int indTmpPart = 0;
    List<CompetenceModel> competencia = [];
    int etapa = 1;

    int largoEquipo = listParticipantes.length ~/ nroEquipos;
    int largoEquipoItera = largoEquipo == 1 ? nroEquipos : largoEquipo;
    while (largoEquipoItera >= 1) {
      List<TeamsModel> teams = [];
      bool isFirt = indTmpPart < listParticipantes.length;

      // recorre lista de equipos seleccionados
      for (int i = 0; i < largoEquipoItera; i++) {
        List<CompetitorModel> participantes = [];
        // solo agrega personas si es la primera etapa
        // de lo contrario agrega teams sin participantes (vacio)
        if (isFirt) {
          // recorre participantes
          for (int x = 0; x < largoEquipo; x++) {
            participantes.add(
              CompetitorModel(
                id: x,
                nombre: listParticipantes[indTmpPart],
              ),
            );
            indTmpPart++;
          }
        }
        // agrega el teams
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
      // agrega competencia
      competencia.add(
        new CompetenceModel(
          id: largoEquipoItera,
          etapa: "Etapa ${largoEquipoItera == 1 ? "Final" : etapa}",
          teams: teams,
        ),
      );
      if (isFirt && largoEquipo != 1) {
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
            id: largoEquipoItera,
            etapa: "Etapa $etapa",
            teams: newTeams,
          ),
        );
      }
      largoEquipoItera = largoEquipoItera ~/ 2;
      etapa++;
    }

    return TournamentModel(
      id: "",
      nombre: nombreTorneo,
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

  static convertTimestamp(String fecha, String hora) {
    String horaFinal =
        hora.split(":").map((h) => h.length > 1 ? h : "0$h").join(":");
    DateTime fechaFinal = DateTime.parse("$fecha $horaFinal:00.000");
    return Timestamp.fromDate(fechaFinal);
  }
}
