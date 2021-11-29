import 'package:get/get.dart';
import 'package:hackaton/models/tournament_list_model.dart';
import 'package:hackaton/models/tournament_model.dart';
import 'package:hackaton/services/tournament_service.dart';

class TournamentListController extends GetxController {
  final TournamentService tournamentService = TournamentService();

  List<TournamentListModel> tournamentList = [];

  @override
  void onReady() async {
    tournamentService.streamFirestoreListTournamentAll().listen(
      (event) {
        event.forEach((elementTorneo) {
          elementTorneo.reference.snapshots().forEach(
            (elementDocTorneo) {
              elementDocTorneo.reference
                  .collection("listaTorneo")
                  .snapshots()
                  .forEach(
                (listaTorneo) {
                  List<TournamentModel> listaTorneos = [];
                  listaTorneo.docs.forEach(
                    (torneo) {
                      Map<String, dynamic> finalData = torneo.data();
                      finalData['id'] = torneo.id;
                      listaTorneos.add(TournamentModel.fromMap(finalData));
                      update();
                    },
                  );
                  tournamentList.add(
                    TournamentListModel(
                      id: elementTorneo.id,
                      listaTorneo: listaTorneos,
                    ),
                  );
                },
              );
            },
          );
        });
      },
    );

    super.onReady();
  }
}
