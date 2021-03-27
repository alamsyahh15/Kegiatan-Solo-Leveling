import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/laundry_form_model.dart/service_kiloan_model.dart';
import 'package:ma_laundry/data/model/laundry_form_model.dart/service_satuan_model.dart';
import 'package:ma_laundry/ui/bloc/registrasi_laundry_bloc/registrasi_bloc.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/utils/constant.dart';

// ignore: must_be_immutable
class ItemService extends StatefulWidget {
  DataKiloan dataKiloan;
  DataSatuan dataSatuan;
  List<int> listPriceKilos = [];
  List<int> listPriceUnit = [];
  RegistrasiBloc regBloc;
  bool showItem;
  int index;
  ItemService({
    this.dataKiloan,
    this.dataSatuan,
    this.regBloc,
    this.index,
    this.showItem,
    this.listPriceKilos,
    this.listPriceUnit,
  });

  @override
  _ItemServiceState createState() => _ItemServiceState();
}

class _ItemServiceState extends State<ItemService> {
  int get index => widget?.index;
  RegistrasiBloc get regBloc => widget?.regBloc;
  DataKiloan get dataKiloan => widget?.dataKiloan;
  DataSatuan get dataSatuan => widget?.dataSatuan;
  bool get showItem => widget?.showItem;
  set showItem(bool val) {
    setState(() => widget?.showItem = val);
  }

  onAddDataKilos() {
    regBloc?.listCheckItemKilos[index] = !regBloc?.listCheckItemKilos[index];

    ///Add Data
    if (regBloc?.listCheckItemKilos[index] == true) {
      regBloc?.listInputKilos?.add(dataKiloan);
    } else {
      regBloc.listInputKilos
          .removeWhere((e) => e.idServiceKiloan == dataKiloan.idServiceKiloan);
    }
    if (regBloc?.valDataConsumer?.isKuota == "YA") {
      setState(() {
        double whasingQuota = double.parse(regBloc?.valDataConsumer?.kuotaCuci);
        double setrikaQouta =
            double.parse(regBloc.valDataConsumer?.kuotaSetrika);
        double totalWhasing = double.parse(dataKiloan?.berat);
        if ((dataKiloan.jenisService == jenisService &&
            dataKiloan.tipeService == typeService)) {
          if (totalWhasing > whasingQuota) {
            regBloc.washingQuotaUsed = "$whasingQuota";
          } else {
            regBloc.washingQuotaUsed = dataKiloan.berat;
          }
          log("Quota Washing ${regBloc.washingQuotaUsed}");
        }
        if ((dataKiloan.jenisService == setrikaService &&
            dataKiloan.tipeService == typeService)) {
          if (totalWhasing > setrikaQouta) {
            regBloc.setrikaQuotaUsed = "$setrikaQouta";
          } else {
            regBloc.setrikaQuotaUsed = dataKiloan.berat;
          }
          log("Quota Setrika ${regBloc.setrikaQuotaUsed}");
        }
        regBloc.countSisaTagihan();
        onChangeKilos(dataKiloan?.berat);
      });
    } else {
      setState(() {
        regBloc.countSisaTagihan();
        onChangeKilos(dataKiloan?.berat);
      });
    }
  }

  onChangeKilos(String val) {
    dataKiloan?.berat = val;
    log("Res use kuota ${regBloc?.valDataConsumer?.isKuota}");
    double totalWhasing = double.parse(val);
    if (regBloc?.valDataConsumer?.isKuota == "YA") {
      setState(() {
        dataKiloan?.harga = "0";
        double whasingQuota = double.parse(regBloc?.valDataConsumer?.kuotaCuci);
        double setrikaQouta =
            double.parse(regBloc.valDataConsumer?.kuotaSetrika);
        if (val.isNotEmpty) {
          if ((dataKiloan.jenisService == jenisService &&
              dataKiloan.tipeService == typeService)) {
            if (totalWhasing > whasingQuota) {
              totalWhasing -= whasingQuota;
              regBloc.washingQuotaUsed = "$whasingQuota";
            } else {
              regBloc.washingQuotaUsed = dataKiloan?.berat;
              totalWhasing = 0;
            }
          }
          if ((dataKiloan.jenisService == setrikaService &&
              dataKiloan.tipeService == typeService)) {
            if (totalWhasing > setrikaQouta) {
              totalWhasing -= setrikaQouta;
              regBloc.setrikaQuotaUsed = "$setrikaQouta";
            } else {
              regBloc.setrikaQuotaUsed = dataKiloan?.berat;
              totalWhasing = 0;
            }
          }
          dataKiloan?.harga =
              "${(totalWhasing * regBloc.listPriceKiloan[index]).round()}";
        }
      });
    } else {
      setState(() {
        dataKiloan?.harga =
            "${(totalWhasing * regBloc.listPriceKiloan[index]).round()}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (dataKiloan != null)
      return Container(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        onAddDataKilos();
                      },
                      child: Icon(
                        regBloc?.listCheckItemKilos[index]
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                      )),
                  InkWell(
                    onTap: () {
                      setState(() {
                        regBloc.listShowItemUnit[index] =
                            !regBloc.listShowItemUnit[index];
                      });
                    },
                    child: Text(
                      dataKiloan?.namaService,
                      style: sansPro(),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          regBloc.listShowItemUnit[index] =
                              !regBloc.listShowItemUnit[index];
                        });
                      },
                      child: Icon(Icons.keyboard_arrow_down))
                ],
              ),
            ),
            Visibility(
              visible: regBloc.listShowItemUnit[index],
              child: Container(
                margin:
                    EdgeInsets.symmetric(horizontal: normal, vertical: medium),
                child: Column(
                  children: [
                    SizedBox(height: medium),
                    CustomTextField(
                      label: "Jumlah (${dataKiloan?.satuanUnit})",
                      initialValue: "${dataKiloan?.berat}",
                      keyboardType: TextInputType.number,
                      onEditingComplete: () {
                        if ((regBloc?.listInputKilos?.length ?? 0) > 0) {
                          regBloc.countSisaTagihan();
                        }
                      },
                      onChanged: (val) {
                        onChangeKilos(val);
                      },
                    ),
                    SizedBox(height: medium),
                    CustomTextField(
                      readOnly: dataKiloan.tipeService == "VIP" ||
                          dataKiloan.tipeService == "VVIP",
                      keyboardType: TextInputType.number,
                      label: "Durasi (${dataKiloan?.satuanWaktu})",
                      initialValue: "${dataKiloan?.durasi}",
                      onChanged: (val) {
                        dataKiloan?.durasi = val;
                      },
                    ),
                    SizedBox(height: medium),
                    CustomTextField(
                      label: "Harga",
                      hint: "${dataKiloan?.harga}",
                      readOnly: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    else
      return Container(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        setState(() {
                          regBloc?.listCheckItemUnit[index] =
                              !regBloc?.listCheckItemUnit[index];

                          ///Add Data
                          dataSatuan?.jumlah = dataSatuan?.jumlah ?? "1";
                          if (regBloc?.listCheckItemUnit[index] == true) {
                            regBloc?.listInputUnit?.add(dataSatuan);
                          } else {
                            regBloc.listInputUnit.removeWhere((e) =>
                                e.idServiceSatuan ==
                                dataSatuan.idServiceSatuan);
                          }
                          regBloc.countSisaTagihan();
                        });
                      },
                      child: Icon(
                        regBloc?.listCheckItemUnit[index]
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                      )),
                  InkWell(
                    onTap: () {
                      setState(() {
                        regBloc.listShowItemUnit[index] =
                            !regBloc.listShowItemUnit[index];
                      });
                    },
                    child: Text(
                      dataSatuan?.namaService,
                      style: sansPro(),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          regBloc.listShowItemUnit[index] =
                              !regBloc.listShowItemUnit[index];
                        });
                        print("Show Item $showItem");
                      },
                      child: Icon(Icons.keyboard_arrow_down))
                ],
              ),
            ),
            Visibility(
              visible: regBloc.listShowItemUnit[index],
              child: Container(
                margin:
                    EdgeInsets.symmetric(horizontal: normal, vertical: medium),
                child: Column(
                  children: [
                    SizedBox(height: medium),
                    CustomTextField(
                      keyboardType: TextInputType.number,
                      label: "Jumlah ",
                      initialValue: "${dataSatuan?.jumlah ?? 1}",
                      onChanged: (val) {
                        setState(() {
                          dataSatuan?.jumlah = val;
                          if (val.isNotEmpty) {
                            dataSatuan?.harga =
                                "${(double.parse(val) * regBloc.listPriceSatuan[index]).round()}";
                          } else {
                            dataSatuan?.harga = "0";
                          }
                          regBloc.countSisaTagihan();
                        });
                      },
                    ),
                    SizedBox(height: medium),
                    CustomTextField(
                      keyboardType: TextInputType.number,
                      label: "Durasi (${dataSatuan?.satuanWaktu})",
                      initialValue: "${dataSatuan?.durasi}",
                    ),
                    SizedBox(height: medium),
                    CustomTextField(
                      label: "Harga",
                      hint: "${dataSatuan?.harga}",
                      readOnly: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
}
