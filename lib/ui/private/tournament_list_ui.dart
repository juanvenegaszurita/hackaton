import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackaton/controllers/auth_controller.dart';
import 'package:hackaton/controllers/private/tournament_list_controller.dart';
import 'package:hackaton/ui/private/tournament_dashboard_ui.dart';
import 'package:intl/intl.dart';

class TournamentListUI extends StatelessWidget {
  final AuthController authController = AuthController.to;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TournamentListController>(
        init: TournamentListController(),
        builder: (controller) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 20.0),
                Center(
                    child: Text(
                  'viewers.textTournamentTitle'.tr,
                  style: TextStyle(
                      //color: AppThemes.ebonyClay,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
                SizedBox(height: 20.0),
                ListView(
                  shrinkWrap: true,
                  children: _rowsTorneo(context, controller),
                )
              ],
            ));
  }

  List<Widget> _rowsTorneo(
    BuildContext context,
    TournamentListController controller,
  ) {
    List<Widget> rowsTorneo = [];

    controller.currentListTournament.forEach((item) {
      DateTime fechaDT = DateTime.fromMicrosecondsSinceEpoch(
        item.fecha.microsecondsSinceEpoch,
      );

      final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
      final String formatted = formatter.format(fechaDT);
      rowsTorneo.add(
        Column(
          children: <Widget>[
            ListTile(
              title: Text(item.nombre),
              subtitle: Text(
                  'Juego: ' + item.nombreJuego + '\n' + 'viewers.textDateTitle'.tr 
                  + ' ' + formatted.toString(),
                  textAlign: TextAlign.left,
                  style: TextStyle( fontSize: 12),),
              leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                    maxWidth: 64,
                    maxHeight: 64,
                  ),
                  child: Icon(Icons.account_tree_outlined)),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () => Get.to(
                TournamentDashboardUI(),
                arguments: {
                  "id": item.id,
                  "uid": authController.firebaseUser.value?.uid,
                },
              ),
            ),
            Divider()
          ],
        ),
      );
    });

    return rowsTorneo;
  }
}
