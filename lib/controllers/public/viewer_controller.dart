import 'package:get/get.dart';
import 'package:hackaton/models/tournament_list_model.dart';
import 'package:hackaton/models/tournament_model.dart';
import 'package:hackaton/services/tournament_service.dart';
import 'package:hackaton/ui/components/loading.dart';

class ViewerController extends GetxController {
  final TournamentService tournamentService = TournamentService();
  List<TournamentListModel> tournamentList = [];

  @override
  void onReady() async {
    tournamentService.streamFirestoreOnlyTournament().snapshots().forEach(
      (torneo) {
        torneo.docs.forEach(
          (docTorneo) {
            List<TournamentModel> listaTorneos = [];
            docTorneo.reference
                .collection(TournamentService.listaTorneo)
                .snapshots()
                .forEach(
              (listaTorneo) {
                listaTorneo.docs.forEach(
                  (torneo) {
                    Map<String, dynamic> finalData = torneo.data();
                    finalData['id'] = torneo.id;

                    bool existe = false;
                    for (int i = 0; i < listaTorneos.length; i++) {
                      if (listaTorneos[i].id == torneo.id) {
                        listaTorneos[i] = TournamentModel.fromMap(finalData);
                        existe = true;
                      }
                    }
                    if (!existe)
                      listaTorneos.add(TournamentModel.fromMap(finalData));
                    update();
                  },
                );
              },
            );
            bool existe = false;
            for (int i = 0; i < tournamentList.length; i++) {
              if (tournamentList[i].id == docTorneo.id) {
                tournamentList[i] = TournamentListModel(
                  id: docTorneo.id,
                  listaTorneo: listaTorneos,
                );
                existe = true;
                break;
              }
            }
            if (!existe) {
              tournamentList.add(
                TournamentListModel(
                  id: docTorneo.id,
                  listaTorneo: listaTorneos,
                ),
              );
            }
            update();
          },
        );
      },
    );
    hideLoadingIndicator();
    super.onReady();
  }
}
