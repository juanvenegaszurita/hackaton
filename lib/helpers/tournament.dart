import 'package:graphview/GraphView.dart';
import 'package:hackaton/models/models.dart';

class Tournament {
  List<List<TeamsModel>> createTeams(int grupo) {
    List<List<TeamsModel>> lista = [];

    while (grupo >= 1) {
      lista.add(List.generate(
        grupo,
        (i) => TeamsModel(id: i, nombre: '', participantes: []),
      ));

      grupo = grupo ~/ 2;
    }
    return lista;
  }
}
