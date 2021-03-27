import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/data_transaction_model/create_paket_model.dart';
import 'package:ma_laundry/data/model/data_transaction_model/paket_kuota_model.dart';
import 'package:ma_laundry/data/model/laundry_form_model.dart/consumer_model.dart';
import 'package:ma_laundry/ui/bloc/data_transaction_bloc/data_transaction_bloc.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/utils/constant.dart';
import 'package:ma_laundry/utils/export_utils.dart';
import 'package:provider/provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class FormDataTransactionPage extends StatefulWidget {
  final TabController tabController;

  const FormDataTransactionPage({Key key, this.tabController})
      : super(key: key);
  @override
  _FormDataTransactionPageState createState() =>
      _FormDataTransactionPageState();
}

class _FormDataTransactionPageState extends State<FormDataTransactionPage> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  DataPaket dataPaket = DataPaket();
  bool _isChange = false;
  bool get isChange => _isChange;
  set isChange(bool val) {
    setState(() => _isChange = val);
  }

  setPaket({DataConsumer consumer, DataKuota kuota, String payment}) {
    if (consumer != null) {
      dataPaket.idKonsumen = "${consumer.idKonsumen}";
    }
    if (kuota != null) {
      dataPaket.berat = kuota.berat;
      dataPaket.unit = kuota.unit;
      dataPaket.idPaketKuota = "${kuota.idPaketKuota}";
      dataPaket.harga = kuota.harga;
      dataPaket.jenisPaket = kuota.jenisPaket;
    }
    if (payment != null) {
      dataPaket.metodePembayaran = payment;
    }
  }

  bool valid() {
    if (dataPaket.idKonsumen == null) {
      showLocalSnackbar("Silahkan pilih Konsumen", key);
    }
    if (dataPaket.metodePembayaran == null) {
      showLocalSnackbar("Silahkan pilih Metode Pembayaran", key);
    }

    if (dataPaket.idPaketKuota == null) {
      showLocalSnackbar("Silahkan pilih Paket Kuota", key);
    }
    return dataPaket.idKonsumen != null &&
        dataPaket.idPaketKuota != null &&
        dataPaket.idPaketKuota != null;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                DataTransactionBloc.initForm(context, key: key))
      ],
      child: Consumer<DataTransactionBloc>(
        builder: (context, transcBloc, _) => Scaffold(
          key: key,
          body: transcBloc.isLoading
              ? circularProgressIndicator()
              : SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(medium),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(normal)),
                      child: Container(
                        margin: EdgeInsets.all(medium),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: normal),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Konsumen",
                                    style: sansPro(fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: tiny),
                                  borderDropdown(
                                    child: SearchableDropdown<DataConsumer>(
                                      isExpanded: true,
                                      underline: NotGiven(),
                                      icon: Icon(Icons.search),
                                      isCaseSensitiveSearch: false,
                                      value: transcBloc.valDataConsumer,
                                      items: transcBloc.listConsumer.map((e) {
                                        return DropdownMenuItem<DataConsumer>(
                                          child: Text(
                                            "${e?.namaDepan} ${e?.namaBelakang}",
                                            maxLines: 2,
                                          ),
                                          value: e,
                                        );
                                      }).toList(),
                                      onChanged: (DataConsumer value) {
                                        setState(() {
                                          transcBloc?.valDataConsumer = value;
                                          setPaket(consumer: value);
                                        });
                                      },
                                      hint: Text("Select Konsumen"),
                                    ),
                                  ),
                                  SizedBox(height: medium),
                                  CustomTextField(
                                    label: "Nomor HP",
                                    readOnly: true,
                                    hint:
                                        transcBloc?.valDataConsumer?.telp ?? "",
                                  ),
                                  SizedBox(height: medium),
                                  CustomTextField(
                                    label: "Alamat",
                                    readOnly: true,
                                    hint: transcBloc?.valDataConsumer?.alamat ??
                                        "",
                                  ),
                                  SizedBox(height: medium),
                                  Text(
                                    "Paket Kuota",
                                    style: sansPro(fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: tiny),
                                  borderDropdown(
                                    child: DropdownButtonHideUnderline(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: medium),
                                        child: DropdownButton(
                                          hint: Text("Pilih Kuota"),
                                          isExpanded: true,
                                          value: transcBloc.valDataKuota,
                                          items: transcBloc.listKuota.map((e) {
                                            return DropdownMenuItem(
                                              child: Text(
                                                  "${e.jenisPaket}, ${e.berat}Kg => ${e.harga}"),
                                              value: e,
                                            );
                                          }).toList(),
                                          onChanged: (DataKuota value) {
                                            isChange = true;
                                            if (value != null) {
                                              setState(() {
                                                transcBloc.valDataKuota = value;
                                                dataPaket.totalBayar =
                                                    value.harga;
                                                setPaket(kuota: value);
                                              });
                                            }
                                            Future.delayed(
                                                Duration(milliseconds: 500),
                                                () {
                                              isChange = false;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: medium),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: CustomTextField(
                                          label: "Berat",
                                          readOnly: true,
                                          hint:
                                              "${transcBloc?.valDataKuota?.berat ?? ""} Kg",
                                        ),
                                      ),
                                      SizedBox(width: medium),
                                      Flexible(
                                        child: CustomTextField(
                                          label: "Harga",
                                          readOnly: true,
                                          hint: formatMoney(
                                              transcBloc.valDataKuota?.harga ??
                                                  "0"),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: medium),
                                  Text(
                                    "Metode Pembayaran",
                                    style: sansPro(fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: tiny),
                                  borderDropdown(
                                    child: DropdownButtonHideUnderline(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: medium),
                                        child: DropdownButton(
                                          isExpanded: true,
                                          value: transcBloc?.valPayment,
                                          hint: Text("Pilih Pembayaran"),
                                          items: PAYMENT_METHOD.map((e) {
                                            return DropdownMenuItem(
                                              child: Text("$e"),
                                              value: e,
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            if (value != null) {
                                              setState(() {
                                                transcBloc?.valPayment = value;
                                                setPaket(payment: value);
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: medium),
                                  isChange
                                      ? disableTextField()
                                      : CustomTextField(
                                          keyboardType: TextInputType.number,
                                          label: "Jumlah Bayar",
                                          initialValue:
                                              dataPaket.totalBayar ?? "",
                                          onChanged: (val) {
                                            dataPaket.totalBayar = val;
                                          },
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
                margin:
                    EdgeInsets.symmetric(horizontal: medium, vertical: normal),
                child: Row(
                  children: [
                    Flexible(
                      child: Container(
                        height: 45,
                        width: widthScreen(context),
                        // ignore: deprecated_member_use
                        child: OutlineButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(normal)),
                          borderSide: BorderSide(color: primaryColor),
                          color: whiteNeutral,
                          textColor: primaryColor,
                          child: Text("Cancel"),
                          onPressed: () {
                            setState(() {
                              FocusScope.of(context).unfocus();
                              widget.tabController.animateTo(0);
                              setState(() {});
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: medium),
                    Flexible(
                      child: Container(
                        height: 45,
                        width: widthScreen(context),
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(normal)),
                          color: primaryColor,
                          textColor: whiteNeutral,
                          child: Text("Submit"),
                          onPressed: () async {
                            setState(() {
                              FocusScope.of(context).unfocus();
                              bool res = valid();
                              if (res) {
                                transcBloc.createPaket(
                                    dataPaket, widget.tabController);
                              }
                            });
                          },
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
