import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rubik_solver/service/data_service.dart';
import 'package:rubik_solver/service/solver_service.dart';
import 'package:rubik_solver/utils/widget/init_container.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataService()),
        ChangeNotifierProvider(create: (context) => SolverService(context)),
      ],
      child: Consumer<DataService>(
        builder: (context, service, _) => Consumer<SolverService>(
          builder: (context, solver, _) => Scaffold(
              appBar: AppBar(
                title: Text("Rubik's Cube Solver"),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InitContainer(solver.checkSide(service, "top"), "Top",
                            Colors.yellow[600]),
                        InitContainer(solver.checkSide(service, "left"), "Left",
                            Colors.blue),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InitContainer(solver.checkSide(service, "front"),
                            "Front", Colors.red),
                        InitContainer(solver.checkSide(service, "right"),
                            "Right", Colors.green),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InitContainer(solver.checkSide(service, "back"), "Back",
                            Colors.orange),
                        InitContainer(solver.checkSide(service, "bottom"),
                            "Bottom", Colors.grey[300]),
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton:
                  new Builder(builder: (BuildContext _context) {
                return ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width,
                  height: 50,
                  child: RaisedButton(
                    onPressed: service.sideColorCode.containsValue("")
                        ? null
                        : () {
                            setState(() {
                              solver.loading = true;
                            });
                            solver.solveCube(service, _context);
                          },
                    color: Colors.indigo[800],
                    textColor: Colors.white,
                    child: solver.loading
                        ? Container(
                            height: 40,
                            child: SpinKitThreeBounce(
                              size: 18,
                              color: Colors.white,
                            ))
                        : Text("Solve", style: TextStyle(fontSize: 14)),
                  ),
                );
              })),
        ),
      ),
    );
  }
}
