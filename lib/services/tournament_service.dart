import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackaton/controllers/auth_controller.dart';
import 'package:hackaton/models/tournament_model.dart';
import 'package:hackaton/ui/components/loading.dart';

class TournamentService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final AuthController authController = AuthController.to;

  // code singleton
  static final TournamentService _tournamentService =
      TournamentService._internal();
  factory TournamentService() {
    return _tournamentService;
  }
  TournamentService._internal();
  // code singleton

  Stream<List<TournamentModel>> streamFirestoreListTournament() => _db
      .collection('torneosPrueba')
      .doc(authController.firebaseUser.value!.uid)
      .collection('listaTorneo')
      .snapshots()
      .map((event) => event.docs.map((e) {
            Map<String, dynamic> finalData = e.data();
            finalData['id'] = e.id;
            return TournamentModel.fromMap(finalData);
          }).toList());

  Stream<TournamentModel> streamFirestoreTournament(String id) => _db
          .collection('torneosPrueba')
          .doc(authController.firebaseUser.value!.uid)
          .collection('listaTorneo')
          .doc(id)
          .snapshots()
          .map(
        (event) {
          Map<String, dynamic> finalData =
              event.exists ? event.data()! : Map<String, dynamic>();
          finalData['id'] = id;
          return TournamentModel.fromMap(finalData);
        },
      );

  Future<bool> updateTournament(
    String idTournament,
    TournamentModel tournamentModel,
  ) async {
    showLoadingIndicator();
    try {
      await _db
          .collection('torneosPrueba')
          .doc(authController.firebaseUser.value!.uid)
          .collection('listaTorneo')
          .doc(idTournament)
          .update(tournamentModel.toJson());
      hideLoadingIndicator();
      return true;
    } catch (e) {
      hideLoadingIndicator();
      return false;
    }
  }

  Future<bool> newTournament(
    TournamentModel tournamentModel,
  ) async {
    showLoadingIndicator();
    try {
      await _db
          .collection('torneosPrueba')
          .doc(authController.firebaseUser.value!.uid)
          .collection('listaTorneo')
          .add(tournamentModel.toJson());
      hideLoadingIndicator();
      return true;
    } catch (e) {
      hideLoadingIndicator();
      return false;
    }
  }
}
