import 'package:flutter/material.dart';
import 'package:ma_laundry/ui/bloc/registrasi_laundry_bloc/registrasi_bloc.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/utils/export_utils.dart';

class PaymentDetailPage extends StatefulWidget {
  final RegistrasiBloc registrasiBloc;

  const PaymentDetailPage({Key key, this.registrasiBloc}) : super(key: key);

  @override
  _PaymentDetailPageState createState() => _PaymentDetailPageState();
}

class _PaymentDetailPageState extends State<PaymentDetailPage> {
  RegistrasiBloc get regBloc => widget?.registrasiBloc;
  bool _changeTagihan = false;
  bool get changeTagihan => _changeTagihan;
  set changeTagihan(bool val) {
    setState(() => _changeTagihan = val);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: normal, vertical: medium),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(normal)),
            elevation: 5,
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: medium, vertical: medium),
              width: widthScreen(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: normal),
                  Text(
                    "Detail Pembayaran",
                    style: sansPro(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  SizedBox(height: medium),
                  CustomTextField(
                    label: "Total Tagihan",
                    readOnly: true,
                    hint: regBloc?.totalTagihan ?? "0",
                    onChanged: (val) {},
                  ),
                  SizedBox(height: medium),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: normal),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Metode Pembayaran",
                          style: sansPro(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: tiny),
                        borderDropdown(
                            child: Container(
                          padding: EdgeInsets.symmetric(horizontal: medium),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text("Pilih Metode Pembayaran"),
                              isExpanded: true,
                              value: regBloc.paymentMethodVal,
                              items: PAYMENT_METHOD.map((e) {
                                return DropdownMenuItem(
                                  child: Text("$e"),
                                  value: e,
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  regBloc?.paymentMethodVal = val;
                                  regBloc?.billingStatusVal = null;
                                  regBloc?.jumlahPembayaran = "0";
                                  regBloc?.sisaTagihan = regBloc?.backupTagihan;
                                  regBloc?.kembalian = "0";
                                  if (val == "TRANSFER") {
                                    regBloc.billingStatusVal = "BELUM LUNAS";
                                  }
                                });
                              },
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                  SizedBox(height: medium),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: normal),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Status Tagihan",
                          style: sansPro(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: tiny),
                        borderDropdown(
                            child: Container(
                          padding: EdgeInsets.symmetric(horizontal: medium),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                hint: Text("Pilih Status Tagihan"),
                                isExpanded: true,
                                value: regBloc.billingStatusVal,
                                items: BILLING_STATUS.map((e) {
                                  return DropdownMenuItem(
                                    child: Text("$e"),
                                    value: e,
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  changeTagihan = true;
                                  if (regBloc?.paymentMethodVal != "TRANSFER") {
                                    setState(() {
                                      regBloc?.jumlahPembayaran = "0";
                                      regBloc?.sisaTagihan =
                                          regBloc?.backupTagihan;
                                      if (val != "BELUM LUNAS") {
                                        regBloc?.jumlahPembayaran =
                                            regBloc?.sisaTagihan;
                                        if (val == "LUNAS" || val == "DP") {
                                          regBloc?.sisaTagihan = "0";
                                        }
                                        print("${regBloc?.jumlahPembayaran}");
                                      }
                                      regBloc.billingStatusVal = val;
                                    });
                                  }
                                  Future.delayed(Duration(milliseconds: 300),
                                      () => changeTagihan = false);
                                }),
                          ),
                        )),
                      ],
                    ),
                  ),
                  SizedBox(height: medium),
                  changeTagihan
                      ? Center()
                      : regBloc.paymentMethodVal == "TRANSFER"
                          ? CustomTextField(
                              hint: "0",
                              readOnly: true,
                              label: "Jumlah Pembayaran")
                          : regBloc.billingStatusVal == "BELUM LUNAS"
                              ? CustomTextField(
                                  readOnly: true,
                                  label: "Jumlah Pembayaran",
                                  hint: "0",
                                )
                              : CustomTextField(
                                  key: Key(""),
                                  keyboardType: TextInputType.number,
                                  label: "Jumlah Pembayaran",
                                  initialValue:
                                      regBloc?.jumlahPembayaran ?? "0",
                                  onEditingComplete: () {},
                                  onChanged: (val) {
                                    regBloc?.sisaTagihan =
                                        regBloc.backupTagihan;
                                    if (val.isNotEmpty) {
                                      regBloc?.sisaTagihan =
                                          regBloc.backupTagihan;
                                      regBloc?.jumlahPembayaran = val;
                                      double pembayaran = double.parse(
                                          regBloc?.jumlahPembayaran ?? "0");
                                      double totalTagihan = double.parse(
                                          regBloc?.sisaTagihan ?? "0");
                                      double diskon =
                                          double.parse(regBloc?.diskon ?? "0");
                                      regBloc?.kembalian = "0";
                                      if (pembayaran > totalTagihan) {
                                        regBloc?.kembalian =
                                            "${(pembayaran - totalTagihan).round()}";
                                      }
                                      if (pembayaran < totalTagihan) {
                                        regBloc?.sisaTagihan =
                                            "${((totalTagihan) - pembayaran).round()}";
                                      }
                                      if (pembayaran >= totalTagihan) {
                                        regBloc?.sisaTagihan = "0";
                                      }
                                    }
                                  },
                                ),
                  SizedBox(height: medium),
                  CustomTextField(
                    label: "Sisa Tagihan",
                    hint: regBloc?.sisaTagihan ?? "",
                    readOnly: true,
                  ),
                  SizedBox(height: medium),
                  Row(
                    children: [
                      Flexible(
                        child: CustomTextField(
                          label: "Diskon",
                          readOnly: true,
                          hint: regBloc?.diskon ?? "",
                          onChanged: (val) {},
                        ),
                      ),
                      SizedBox(width: medium),
                      Flexible(
                        child: CustomTextField(
                          label: "Kembalian",
                          hint: regBloc?.kembalian ?? "0",
                          readOnly: true,
                          onChanged: (val) {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
