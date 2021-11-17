import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  TextEditingController nombreParticipanteController = TextEditingController();
  final participantes = ["juan"].obs;
  List<dynamic> get currentParticipantes => participantes.value;

  addPlayer() {
    participantes.value.add(nombreParticipanteController.text);
    nombreParticipanteController.text = "";
    update(["home"]);
  }

  removePlayer() {
    //participantes.value.remove();
    //update(["home"]);
  }
}
