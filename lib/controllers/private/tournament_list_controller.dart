import 'package:get/get.dart';
import 'package:hackaton/controllers/auth_controller.dart';
import 'package:hackaton/services/tournament_service.dart';
import 'package:hackaton/ui/components/loading.dart';

class TournamentListController extends GetxController {
  final TournamentService tournamentService = TournamentService();
  final AuthController authController = AuthController.to;

  final listTournament = [].obs;
  List<dynamic> get currentListTournament => listTournament.value;

  @override
  void onReady() async {
    showLoadingIndicator();
    tournamentService.streamFirestoreListTournament().listen(
      (event) {
        listTournament.value = event;
        update();
      },
    );
    super.onReady();
    hideLoadingIndicator();
  }
}
