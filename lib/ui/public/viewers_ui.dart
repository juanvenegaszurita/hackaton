import 'package:flutter/material.dart'; 
import 'package:get/get.dart';
import 'package:hackaton/constants/app_themes.dart';
import 'package:hackaton/controllers/public/tournament_controller.dart'; 
import 'package:hackaton/ui/components/components.dart';
import 'package:hackaton/ui/private/tournament_dashboard_ui.dart'; 
import 'package:intl/intl.dart';

class ViewersUI extends StatelessWidget {
  //final AuthController authController = AuthController.to;
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _imageLogo = 'assets/images/icons_tournament.png'; 
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TournamentListController>(
      init: TournamentListController(),
      builder: (controller) => ScaffoldGeneric(
        isMenu: false,
        isAppBarActions: false,
        //maxWidth: screen.settings.tabletChangePoint,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch, 
          children: <Widget>[
            SizedBox(height: 20.0),
            Center(child: Text('viewers.textTournamentTitle'.tr, 
                                style: TextStyle(color: AppThemes.ebonyClay,
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                )), 
            SizedBox(height: 48.0),
            ListView(
              shrinkWrap: true,
              children: _rowsTorneo(context, controller),
            )
          ],
        ),
      ),
    );
  }
 
  List<Widget> _rowsTorneo(BuildContext context, TournamentListController controller,){
 
    return controller.listaTorneos.map((item) { 
      print("item:" + item.id);
      DateTime fechaDT = DateTime.fromMicrosecondsSinceEpoch(item.fecha.microsecondsSinceEpoch,);
      
      final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
      final String formatted = formatter.format(fechaDT); 

      return Column(
        children: <Widget>[
          ListTile(
            title: Text(item.nombreJuego),
            subtitle: Text("Fecha Torneo : " + formatted.toString()),
            leading: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 44,
                minHeight: 44,
                maxWidth: 64,
                maxHeight: 64,
              ),
              child: Image.asset(_imageLogo, fit: BoxFit.cover)
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            //onTap: () { print(item.id + ' ' + item.nombreJuego); },
            onTap: () => Get.to(TournamentDashboardUI(), arguments: {"id": item.id}), 
          ),
          Divider()
        ],
      );
    }).toList();
  }  
}

 
