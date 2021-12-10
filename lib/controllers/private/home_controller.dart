import 'package:flutter/material.dart';
import 'package:hackaton/controllers/auth_controller.dart';
import 'package:hackaton/helpers/tournament.dart';
import 'package:get/get.dart';
import 'package:hackaton/services/tournament_service.dart';
import 'package:hackaton/ui/private/private.dart';

class HomeController extends GetxController {
  static HomeController to = Get.find();
  TextEditingController nombreParticipanteController = TextEditingController();
  final TournamentService tournamentService = TournamentService();
  final nroEquipos = 0.obs;
  final division = 50.obs;
  int get currentnroEquipos => nroEquipos.value;
  int get currentDivision => division.value;

  final participantes = RxList([]).obs;
  List<dynamic> get currentParticipantes => participantes.value;

  final List<String> listaParticipantes = [];

  @override
  void onReady() async {
    tournamentService.streamFirestoreListParticipantes().listen(
      (event) {
        var stringList = List<String>.from(event);
        listaParticipantes.addAll(stringList);
      },
    );

    super.onReady();
  }

  addPlayer() {
    participantes.value.add(nombreParticipanteController.text);
    nombreParticipanteController.text = "";
    update(["home"]);
  }

  removePlayer(participante) {
    currentParticipantes.remove(participante);
    update(["home"]);
  }

  createNewTournament() async {
    if (currentnroEquipos < 2) {
      Get.snackbar('home.setError'.tr, 'home.setMinimunTeams'.tr,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    } else if (currentParticipantes.length < 2) {
      Get.snackbar('home.setError'.tr, 'home.setMinimunPlayers'.tr,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    } else if (currentnroEquipos > currentParticipantes.length) {
      Get.snackbar('home.setError'.tr, 'home.maxNumTeams'.tr,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    } else {
      {
        TournamentService tor = TournamentService();
        List<String> listParticipantes = [];
        currentParticipantes.forEach((element) {
          listParticipantes.add(element);
        });

        String idTournamet = await tor.newTournament(Tournament.createTourment(
            listParticipantes, currentnroEquipos.toInt()));
        currentParticipantes.clear();
        nombreParticipanteController.clear();
        Get.to(
          TournamentDashboardUI(),
          arguments: {
            "id": idTournamet,
            "uId": AuthController.to.firestoreUser.value?.uid
          },
        );
      }
    }
  }

  setNroEquipos(int value) {
    nroEquipos.value = value;
    if (currentnroEquipos > 4) {
      division.value = 25;
    } else if (currentnroEquipos <= 4) {
      division.value = 50;
    }
    update(["home"]);
  }
}
