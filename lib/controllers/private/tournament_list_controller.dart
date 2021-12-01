import 'package:get/get.dart';
import 'package:hackaton/controllers/auth_controller.dart';
import 'package:hackaton/services/tournament_service.dart';

class TournamentListController extends GetxController {
  final TournamentService tournamentService = TournamentService();
  final AuthController authController = AuthController.to;

  final listTournament = [].obs;
  // ignore: invalid_use_of_protected_member
  List<dynamic> get currentListTournament => listTournament.value;

  @override
  void onReady() async {
    tournamentService.streamFirestoreListTournament().listen(
      (event) {
        //print("streamFirestoreListTournament: " + event.toString());
        listTournament.value = event;
        update();
      },
    );
    super.onReady();
  }
}
