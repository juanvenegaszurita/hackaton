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
}
