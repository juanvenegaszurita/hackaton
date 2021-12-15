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
    showLoadingIndicator();
    tournamentService.streamFirestoreListTournamentAll().listen(
      (event) {
        tournamentList = [];
        event.forEach((elementTorneo) {
          elementTorneo.reference.snapshots().forEach(
            (elementDocTorneo) {
              elementDocTorneo.reference
                  .collection(TournamentService.listaTorneo)
                  .snapshots()
                  .forEach(
                (listaTorneo) {
                  List<TournamentModel> listaTorneos = [];
                  listaTorneo.docs.forEach(
                    (torneo) {
                      Map<String, dynamic> finalData = torneo.data();
                      finalData['id'] = torneo.id;
                      listaTorneos.add(TournamentModel.fromMap(finalData));
                    },
                  );
                  tournamentList.add(
                    TournamentListModel(
                      id: elementTorneo.id,
                      listaTorneo: listaTorneos,
                    ),
                  );
                  update();
                },
              );
            },
          );
        });
      },
    );
    super.onReady();
    hideLoadingIndicator();
  }
}
