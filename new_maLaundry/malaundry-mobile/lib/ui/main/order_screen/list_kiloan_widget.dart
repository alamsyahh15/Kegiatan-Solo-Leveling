import 'package:flutter/material.dart';
import 'package:ma_laundry/ui/config/export_config.dart';

class ListKiloanWidget extends StatefulWidget {
  final List<List<String>> listInputKilos;

  const ListKiloanWidget({Key key, this.listInputKilos}) : super(key: key);
  @override
  _ListKiloanWidgetState createState() => _ListKiloanWidgetState();
}

class _ListKiloanWidgetState extends State<ListKiloanWidget> {
  List<List<String>> get listInputKilos => widget.listInputKilos;
  bool showKilos = true;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: listInputKilos.length > 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: medium),
        width: widthScreen(context),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: normal),
          decoration: BoxDecoration(
            border: Border.all(color: greyColor, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(medium),
                decoration: BoxDecoration(
                    color: greyNeutral,
                    border: Border.all(color: greyColor, width: 1),
                    borderRadius: BorderRadius.circular(normal)),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      showKilos = !showKilos;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Service Kiloan",
                        style: sansPro(),
                      ),
                      Icon(showKilos
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down)
                    ],
                  ),
                ),
              ),
              Visibility(visible: showKilos, child: SizedBox(height: medium)),
              Visibility(
                visible: showKilos,
                child: Container(
                  margin: EdgeInsets.all(medium),
                  child: Column(
                    children: [
                      Table(
                        border: TableBorder.all(),
                        children: [
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Nama Paket',
                                textAlign: TextAlign.center,
                              ),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Kg',
                                textAlign: TextAlign.center,
                              ),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Harga',
                                textAlign: TextAlign.center,
                              ),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Subtotal',
                                textAlign: TextAlign.center,
                              ),
                            )),
                          ]),
                        ],
                      ),
                      Table(
                          border: TableBorder.all(),
                          children: listInputKilos
                              .map((e) => TableRow(
                                  children: e
                                      .map(
                                        (b) => TableCell(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '$b',
                                            textAlign: TextAlign.center,
                                          ),
                                        )),
                                      )
                                      .toList()))
                              .toList()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
