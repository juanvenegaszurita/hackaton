import 'package:flutter/material.dart';
import 'package:hackaton/constants/constants.dart';
import 'package:hackaton/controllers/private/home_controller.dart';
import 'package:hackaton/ui/ui.dart';

class ListCardDetails extends StatelessWidget {
  ListCardDetails({
    required this.list,
  }); //required this.onPressed});

  final List<dynamic> list;
  final HomeController controller = HomeController.to;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: list
              .map((e) => CardGeneric(
                    border: true,
                    color: AppThemes.nevada,
                    height: 80,
                    body: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            e.toString(),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              size: 26,
                              color: Colors.orange,
                            ),
                            onPressed: () {
                              controller.removePlayer(e);
                            },
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
