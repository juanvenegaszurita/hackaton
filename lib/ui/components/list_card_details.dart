import 'package:flutter/material.dart';
import 'package:hackaton/controllers/private/home_controller.dart';

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
              .map((e) => Card(
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 9),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  e.toString(),
                                  style: Theme.of(context).textTheme.headline5,
                                )
                              ],
                            ),
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
