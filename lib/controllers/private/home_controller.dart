import 'package:flutter/material.dart';
import 'package:hackaton/controllers/auth_controller.dart';
import 'package:hackaton/helpers/tournament.dart';
import 'package:get/get.dart';
import 'package:hackaton/services/tournament_service.dart';
import 'package:hackaton/ui/private/private.dart';

class HomeController extends GetxController {
  static HomeController to = Get.find();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nombreParticipanteController = TextEditingController();
  final TournamentService tournamentService = TournamentService();
  final nroEquipos = 0.obs;
  final division = 50.obs;
  int get currentnroEquipos => nroEquipos.value;
  int get currentDivision => division.value;

  final participantes = RxList<String>([]).obs;
  List<String> get currentParticipantes => participantes.value;

  final List<String> listaParticipantes = [];

  @override
  void onReady() async {
    tournamentService.streamFirestoreListParticipantes().listen(
      (event) {
        var stringList = List<String>.from(event);
        listaParticipantes.addAll(stringList.toSet().toList());
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
    participantes.value.remove(participante);
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
        String idTournamet = await tournamentService.newTournament(
          Tournament.createTourment(
            currentParticipantes,
            currentnroEquipos.toInt(),
          ),
        );
        List<String> pParticipantes =
            [...listaParticipantes, ...currentParticipantes].toSet().toList();

        await tournamentService.updateListaParticipantes(pParticipantes);
        participantes.value.assignAll([]);
        nroEquipos.value = 0;
        update(["home"]);
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
