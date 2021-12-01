import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackaton/controllers/public/viewer_controller.dart';
import 'package:hackaton/ui/components/components.dart';
import 'package:hackaton/ui/private/tournament_dashboard_ui.dart';
import 'package:intl/intl.dart';

class ViewersUI extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewerController>(
      init: ViewerController(),
      builder: (controller) => ScaffoldGeneric(
        isMenu: false,
        isAppBarActions: false,
        title: 'viewers.textTournamentTitle'.tr,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 10.0), 
            ListView(
              shrinkWrap: true,
              children: _rowsTorneo(context, controller),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _rowsTorneo(
    BuildContext context,
    ViewerController controller,
  ) {
    List<Widget> rowsTorneo = [];

    controller.tournamentList.forEach((tl) {
      tl.listaTorneo.forEach((item) {
        DateTime fechaDT = DateTime.fromMicrosecondsSinceEpoch(
          item.fecha.microsecondsSinceEpoch,
        );

        final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
        final String formatted = formatter.format(fechaDT);
        rowsTorneo.add(
          Column(
            children: <Widget>[
              ListTile(
                title: Text(item.nombreJuego),
                subtitle: Text('viewers.textDateTitle'.tr + ' ' + formatted.toString()),
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
                    "uid": tl.id,
                  },
                ),
              ),
              Divider()
            ],
          ),
        );
      });
    });

    return rowsTorneo;
  }

}
