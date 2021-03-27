import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/pengeluaran_model/pengeluaran_model.dart';

import '../../../utils/intl_tools.dart';
import '../../config/colors.dart';
import '../../config/export_config.dart';
import '../../config/fonts_local.dart';
import '../../config/widget.dart';

class DetailPengeluaran extends StatefulWidget {
  final DataPengeluaran data;

  const DetailPengeluaran({Key key, this.data}) : super(key: key);
  @override
  _DetailPengeluaranState createState() => _DetailPengeluaranState();
}

class _DetailPengeluaranState extends State<DetailPengeluaran> {
  DataPengeluaran get data => widget.data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.only(top: small),
        decoration: BoxDecoration(
            color: whiteNeutral,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(medium),
              topRight: Radius.circular(medium),
            ),
            boxShadow: [
              BoxShadow(blurRadius: 5, spreadRadius: 5, color: greyColor)
            ]),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Icon(Icons.drag_handle, size: 30),
            Container(
              margin: EdgeInsets.symmetric(horizontal: medium),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pengeluaran",
                    style: sansPro(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(height: normal),
                  CustomTextField(
                    label: "Cabang",
                    hint: data?.cabang?.namaCabang ?? "n/a",
                    readOnly: true,
                  ),
                  SizedBox(height: normal),
                  CustomTextField(
                    label: "Item",
                    hint: data?.item?.item ?? "n/a",
                    readOnly: true,
                  ),
                  Visibility(
                      visible: data?.item?.item != "Tarikan",
                      child: SizedBox(height: normal)),
                  Visibility(
                    visible: data?.item?.item != "Tarikan",
                    child: Row(
                      children: [
                        Flexible(
                          child: CustomTextField(
                            label: "Jumlah",
                            hint: data?.jumlah ?? "n/a",
                            readOnly: true,
                          ),
                        ),
                        SizedBox(width: medium),
                        Flexible(
                          child: CustomTextField(
                            label: "Satuan",
                            hint: data?.satuanUnit ?? "n/a",
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: normal),
                  CustomTextField(
                    label: "Harga",
                    hint: formatMoney(data?.totalHarga ?? "0"),
                    readOnly: true,
                  ),
                  SizedBox(height: normal),
                  Row(
                    children: [
                      Flexible(
                        child: CustomTextField(
                          label: "Kas Sebelum",
                          hint: formatMoney(data?.kasSebelum ?? "0"),
                          readOnly: true,
                        ),
                      ),
                      SizedBox(width: medium),
                      Flexible(
                        child: CustomTextField(
                          label: "Kas Sesudah",
                          hint: formatMoney(data?.kasSesudah ?? "0"),
                          readOnly: true,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: normal),
                  CustomTextField(
                    label: "Catatan",
                    hint: data?.catatan ?? "n/a",
                    readOnly: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
