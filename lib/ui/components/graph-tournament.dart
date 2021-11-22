import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:hackaton/models/competence_model.dart';
import 'package:hackaton/models/models.dart';
import 'package:hackaton/ui/ui.dart';

class GraphTournament extends StatelessWidget {
  GraphTournament({required this.competencias});

  final List<CompetenceModel> competencias;
  final Graph graph = Graph()..isTree = true;
  final BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

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
        if (siguiente.length > 0) {
          siguiente = new List.from(siguiente.reversed);
          listaNodo = new List.from(listaNodo.reversed);
          listaNodo.asMap().forEach((keyN, nodo) {
            graph.addEdge(nodo, siguiente[aunmento]);
            graph.addEdge(nodo, siguiente[aunmento + 1]);

            aunmento = aunmento + 2;
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
            competencias[int.parse(keyList[0])].teams![int.parse(keyList[1])],
          );
        },
      ),
    );
  }

  Widget rectangleWidget(BuildContext context, TeamsModel team) {
    return InkWell(
      onTap: () {
        print('clicked');
      },
      child: Container(
        width: 200,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary,
              spreadRadius: 1,
            ),
          ],
        ),
        /* child: Text(
          '${team.nombre}\n\n${team.participantes.map((e) => '${e.nombre}').join("\n")}',
          style: TextStyle(
            color: Theme.of(context).primaryIconTheme.color,
          ),
        ), */
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              team.nombre,
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            Text(
              "Puntos: ${team.puntos}",
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            FormVerticalSpace(),
            ...team.participantes
                .map(
                  (e) => Text(
                    "- ${e.nombre}",
                    style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                )
                .toList()
          ],
        ),
      ),
    );
  }
}
