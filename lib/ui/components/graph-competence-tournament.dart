import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:hackaton/constants/constants.dart';
import 'package:hackaton/controllers/private/tournament_dashboard_controller.dart';
import 'package:hackaton/models/competence_model.dart';
import 'package:hackaton/models/models.dart';
import 'package:hackaton/ui/ui.dart';

class GraphCompetenceTournament extends StatelessWidget {
  GraphCompetenceTournament({required this.competencias});

  final List<CompetenceModel> competencias;
  final Graph graph = Graph()..isTree = true;
  final BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  final TournamentDashboardController controller =
      TournamentDashboardController.to;

  @override
  Widget build(BuildContext context) {
    if (competencias.length == 0) return Text("Sin Datos");

    List<List<Node>> nodeTeams = competencias
        .map((competencia) => competencia.teams
            .map((team) => Node.Id("${competencia.id}-${team.id}"))
            .toList())
        .toList();
    nodeTeams = new List.from(nodeTeams.reversed);

    nodeTeams.asMap().forEach((keyLN, listaNodo) {
      if ((keyLN + 1) < nodeTeams.length) {
        List<Node> siguiente = nodeTeams[(keyLN + 1)];
        int aunmento = 0;
        if (siguiente.length > nodeTeams[keyLN].length) {
          listaNodo.asMap().forEach((keyN, nodo) {
            graph.addEdge(nodo, siguiente[aunmento]);
            graph.addEdge(nodo, siguiente[aunmento + 1]);

            aunmento = aunmento + 2;
          });
        } else {
          listaNodo.asMap().forEach((keyN, nodo) {
            graph.addEdge(nodo, siguiente[keyN]);
            aunmento = aunmento++;
          });
        }
      }
    });

    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_RIGHT_LEFT);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: GraphView(
          graph: graph,
          algorithm: BuchheimWalkerAlgorithm(
            builder,
            TreeEdgeRenderer(builder),
          ),
          paint: Paint()
            ..color = Theme.of(context).textTheme.button!.color!
            ..strokeWidth = 1
            ..style = PaintingStyle.stroke,
          builder: (Node node) {
            // I can decide what widget should be shown here based on the id
            var key = node.key!.value as String;
            List<String> keyList = key.split("-");
            return rectangleWidget(
              context,
              competencias[int.parse(keyList[0])].etapa,
              competencias[int.parse(keyList[0])].teams[int.parse(keyList[1])],
              int.parse(keyList[0]),
              int.parse(keyList[1]),
            );
          },
        ),
      ),
    );
  }

  Widget rectangleWidget(
    BuildContext context,
    String etapa,
    TeamsModel team,
    int indCom,
    int indTeam,
  ) {
    return InkWell(
      // open dialog edit team
      onTap: () {
        if (controller.authController.firebaseUser.value?.uid != null) {
          ModalTeam.openDialog(
            controller,
            context,
            competencias,
            etapa,
            team,
            indCom,
            indTeam,
          );
        }
      },
      child: Container(
        width: 200,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppThemes.orange,
          ),
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: AppThemes.nevada,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ModalTeam.detailsTeam(etapa, team),
      ),
    );
  }
}
