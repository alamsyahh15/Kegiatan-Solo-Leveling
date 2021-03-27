import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rubik_solver/service/data_service.dart';
import 'package:rubik_solver/service/solver_service.dart';

class InitContainer extends StatelessWidget {
  Widget widget;
  String side;
  Color colors;

  InitContainer(this.widget, this.side, this.colors);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataService()),
      ],
      child: Consumer<DataService>(
        builder: (context, service, _) => Center(
          child: Container(
            width: 160,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      side,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    side != ""
                        ? service.sideColor[side.toLowerCase()].length > 1
                            ? InkWell(
                                onTap: () {
                                  service.setsideColor(side.toLowerCase(), []);
                                },
                                child: Icon(
                                  Icons.replay,
                                  size: 20,
                                  color: Colors.green[700],
                                ),
                              )
                            : Container()
                        : Container(),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300],
                  ),
                  width: 160,
                  height: 160,
                  child: widget,
                ),
                SizedBox(
                  height: 3,
                ),
                side != ""
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "***Center must:  ",
                            style: TextStyle(fontSize: 12),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1),
                                color: colors),
                            width: 12,
                            height: 12,
                          )
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
