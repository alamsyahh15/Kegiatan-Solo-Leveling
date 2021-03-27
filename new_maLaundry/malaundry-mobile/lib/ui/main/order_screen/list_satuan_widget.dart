import 'package:flutter/material.dart';
import 'package:ma_laundry/ui/config/export_config.dart';

class ListSatuanWidget extends StatefulWidget {
  final List<List<String>> listInputUnit;

  const ListSatuanWidget({Key key, this.listInputUnit}) : super(key: key);
  @override
  _ListSatuanWidgetState createState() => _ListSatuanWidgetState();
}

class _ListSatuanWidgetState extends State<ListSatuanWidget> {
  List<List<String>> get listInputUnit => widget.listInputUnit;
  bool showSatuan = true;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: listInputUnit.length > 0,
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
                      showSatuan = !showSatuan;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Service Satuan",
                        style: sansPro(),
                      ),
                      Icon(showSatuan
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down)
                    ],
                  ),
                ),
              ),
              Visibility(visible: showSatuan, child: SizedBox(height: medium)),
              Visibility(
                visible: showSatuan,
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
                                'Pcs',
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
                          children: listInputUnit
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
