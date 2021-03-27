import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/kas_laundry_model/data_transaction_model.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/utils/export_utils.dart';

class DetailKasPage extends StatefulWidget {
  final DataTransaction data;
  final String type;

  const DetailKasPage({Key key, this.data, this.type}) : super(key: key);
  @override
  _DetailKasPageState createState() => _DetailKasPageState();
}

class _DetailKasPageState extends State<DetailKasPage> {
  DataTransaction get data => widget.data;
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
        child: Container(
          child: Column(
            children: [
              Container(
                  child: IconButton(
                icon: Icon(Icons.drag_handle, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: medium),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget?.type?.toUpperCase()}",
                            style: sansPro(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          SizedBox(height: normal),
                          CustomTextField(
                            label: "Kode",
                            hint: data?.kodeTransaksi ?? "n/a",
                            readOnly: true,
                          ),
                          SizedBox(height: normal),
                          CustomTextField(
                            label: "Cabang",
                            hint: data?.cabang?.namaCabang ?? "n/a",
                            readOnly: true,
                          ),
                          SizedBox(height: normal),
                          CustomTextField(
                            label: "Nama Konsumen",
                            hint: data?.namaKonsumen ?? "n/a",
                            readOnly: true,
                          ),
                          SizedBox(height: normal),
                          CustomTextField(
                            label: "Jenis Paket",
                            hint: data?.jenisPaket ?? "n/a",
                            readOnly: true,
                          ),
                          SizedBox(height: normal),
                          CustomTextField(
                            label: "Berat",
                            hint: "${data?.berat ?? "0"} Kg",
                            readOnly: true,
                          ),
                          SizedBox(height: normal),
                          CustomTextField(
                            label: "Harga",
                            hint: "${formatMoney(data?.harga ?? "0")}",
                            readOnly: true,
                          ),
                          SizedBox(height: normal),
                          CustomTextField(
                            label: "Create By",
                            hint: data?.createdBy ?? "n/a",
                            readOnly: true,
                          ),
                          SizedBox(height: normal),
                          CustomTextField(
                            label: "Create At",
                            hint: data?.createdDate ?? "",
                            readOnly: true,
                          ),
                          SizedBox(height: normal),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
